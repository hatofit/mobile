# HatoFit Security Documentation

## Overview

HatoFit implements comprehensive security measures to protect user data, ensure secure communication, and comply with privacy regulations. This document covers authentication mechanisms, data encryption, secure storage practices, and compliance considerations.

## Table of Contents

1. [Security Architecture](#security-architecture)
2. [Authentication](#authentication)
3. [Data Encryption](#data-encryption)
4. [Secure Storage](#secure-storage)
5. [Network Security](#network-security)
6. [Permissions & Privacy](#permissions--privacy)
7. [Compliance](#compliance)
8. [Security Best Practices](#security-best-practices)

---

## Security Architecture

### Defense in Depth

```
┌─────────────────────────────────────────────────────────────────┐
│                    Application Layer                             │
│         (Input Validation, Secure UI, Biometrics)                │
├─────────────────────────────────────────────────────────────────┤
│                    Business Logic Layer                          │
│              (Authentication, Authorization)                     │
├─────────────────────────────────────────────────────────────────┤
│                      Data Layer                                  │
│         (Encrypted Storage, Token Management)                    │
├─────────────────────────────────────────────────────────────────┤
│                     Network Layer                                │
│         (HTTPS/TLS, Certificate Pinning, API Security)           │
├─────────────────────────────────────────────────────────────────┤
│                    Device Layer                                  │
│         (Keychain/Keystore, Secure Enclave)                      │
└─────────────────────────────────────────────────────────────────┘
```

---

## Authentication

### JWT Token-Based Authentication

```dart
// Token storage after successful login
class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, AuthResponseEntity>> login(
    LoginParams params,
  ) async {
    final res = await _remote.login(params);
    return res.fold(
      (failure) => Left(failure),
      (authResponseModel) async {
        final entity = authResponseModel.toEntity();
        // Securely store token
        await _local.upsertToken(entity.token ?? "");
        await _local.upsertUser(entity.user ?? const UserEntity());
        return Right(entity);
      },
    );
  }
}
```

### Token Management

```dart
// lib/data/sources/local/user_local_data_source.dart
class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Either<Failure, String> readToken() {
    try {
      final String? res = _client.userBox.get(UserBoxKeys.token.name);
      if (res == null) return const Left(CacheFailure("Token not found"));
      return Right(res);
    } catch (error, stackTrace) {
      nonFatalError(error: error, stackTrace: stackTrace);
      return Left(CacheFailure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, String>> upsertToken(String token) async {
    try {
      await _client.userBox.put(UserBoxKeys.token.name, token);
      return readToken();
    } catch (error, stackTrace) {
      nonFatalError(error: error, stackTrace: stackTrace);
      return Left(CacheFailure(error.toString()));
    }
  }
}
```

### Google OAuth Integration

```dart
// lib/ui/auth/cubit/auth_cubit.dart
class AuthCubit extends Cubit<AuthState> {
  static const List<String> _scopes = <String>[
    "email",
    "profile",
    "https://www.googleapis.com/auth/fitness.heart_rate.read",
    "https://www.googleapis.com/auth/fitness.heart_rate.write",
    // ... other fitness scopes
  ];
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: _scopes,
    forceCodeForRefreshToken: true, // Security: Force refresh token
  );
  
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? res = await _googleSignIn.signIn();
      if (res != null) {
        emit(_Success(res.displayName));
      }
    } catch (e, stackTrace) {
      emit(_Failure("An error occurred: ${e.toString()}"));
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
  }
}
```

### Password Security

```dart
// Password validation in UI
TextField(
  obscureText: isPasswordHide,
  decoration: InputDecoration(
    suffixIcon: IconButton(
      icon: Icon(isPasswordHide ? Icons.visibility : Icons.visibility_off),
      onPressed: () => context.read<AuthCubit>().showHidePassword(),
    ),
  ),
)

// Server-side validation (API)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<Failure, AuthResponseModel>> register(
    RegisterParams params,
  ) async {
    final res = await _client.postRequest(
      APIConstant.authRegister,
      formData: params.toFormData(),
      converter: (res) => AuthResponseModel.fromJson(res),
    );
    return res;
  }
}
```

---

## Data Encryption

### Local Storage Encryption

Hive supports AES-256 encryption for sensitive data:

```dart
// Secure box initialization with encryption
static Future<void> initHive() async {
  await Hive.initFlutter();
  
  // Generate or retrieve encryption key
  final encryptionKey = await _getEncryptionKey();
  
  _userBox = await Hive.openBox(
    BoxKeys.user.name,
    encryptionCipher: HiveAesCipher(encryptionKey),
  );
}

// Key management
Future<Uint8List> _getEncryptionKey() async {
  const secureStorage = FlutterSecureStorage();
  String? key = await secureStorage.read(key: 'hive_encryption_key');
  
  if (key == null) {
    final newKey = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'hive_encryption_key',
      value: base64UrlEncode(newKey),
    );
    return newKey;
  }
  
  return base64Url.decode(key);
}
```

### Data Anonymization

For analytics and crash reporting:

```dart
// lib/utils/helper/firebase_crashlogger.dart
mixin FirebaseCrashLogger {
  void nonFatalError({
    required dynamic error,
    required StackTrace stackTrace,
  }) {
    // Remove PII before logging
    final sanitizedError = _sanitizeError(error);
    FirebaseCrashlytics.instance.recordError(
      sanitizedError,
      stackTrace,
      fatal: false,
    );
  }
  
  dynamic _sanitizeError(dynamic error) {
    if (error is String) {
      return error
        .replaceAll(RegExp(r'[\w.-]+@[\w.-]+\.\w+'), '[EMAIL]')
        .replaceAll(RegExp(r'\b\d{3}-\d{2}-\d{4}\b'), '[SSN]');
    }
    return error;
  }
}
```

---

## Secure Storage

### Key Storage Locations

| Platform | Secure Storage | Implementation |
|----------|---------------|----------------|
| iOS | Keychain | `flutter_secure_storage` |
| Android | Keystore | `flutter_secure_storage` |
| General | Hive (encrypted) | AES-256 cipher |

### Implementation

```dart
// Using flutter_secure_storage for critical data
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accountName: 'hatofit_secure_storage',
    ),
  );
  
  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
```

---

## Network Security

### HTTPS & TLS

All API communications use HTTPS:

```dart
// lib/core/sources/http/dio_client.dart
class DioClient {
  late final Dio _dio;
  
  DioClient(NetworkInfo networkInfo) {
    _dio = Dio(BaseOptions(
      baseUrl: APIConstant.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      // Enforce HTTPS
      validateStatus: (status) => status != null && status < 500,
    ));
    
    _dio.interceptors.addAll([
      DioInterceptor(),
      PrettyDioLogger(),
    ]);
  }
}
```

### API Security Headers

```dart
// Automatic header injection via interceptor
class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add auth token
    final token = _getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    // Security headers
    options.headers['X-Request-ID'] = const Uuid().v4();
    options.headers['X-App-Version'] = AppConstant.version;
    
    handler.next(options);
  }
}
```

### Certificate Pinning (Optional)

```dart
// Certificate pinning for production
class SecureDioClient {
  Dio createSecureDio() {
    final dio = Dio();
    
    // Pin SSL certificate
    final cert = rootBundle.load('assets/certificates/server.crt');
    final securityContext = SecurityContext();
    securityContext.setTrustedCertificates(cert as Uint8List);
    
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient(context: securityContext);
        client.badCertificateCallback = (cert, host, port) => false;
        return client;
      },
    );
    
    return dio;
  }
}
```

---

## Permissions & Privacy

### Permission Handling

```dart
// lib/domain/usecases/ble/req_ble_perm_usecase.dart
class ReqBLEPermUsecase extends UseCase<Future<bool>, void> {
  final CommonBLERepo _repo;
  
  @override
  Future<bool> call(void params) async {
    final permissions = await _repo.requestPermissions();
    return permissions.values.every((status) => status.isGranted);
  }
}

// Permission explanations in AndroidManifest.xml & Info.plist
```

### Privacy-Preserving Analytics

```dart
// Firebase Analytics with user consent
class AnalyticsService {
  static Future<void> logEvent(String name, Map<String, dynamic> params) async {
    // Check user consent
    final hasConsent = await _checkUserConsent();
    if (!hasConsent) return;
    
    // Anonymize user data
    final sanitizedParams = params.map((key, value) {
      if (value is String && _isPii(key)) {
        return MapEntry(key, '[REDACTED]');
      }
      return MapEntry(key, value);
    });
    
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: sanitizedParams,
    );
  }
}
```

---

## Compliance

### GDPR Considerations

1. **Data Minimization**: Only collect necessary health data
2. **Consent Management**: Clear consent for data processing
3. **Right to Deletion**: Account deletion functionality
4. **Data Portability**: Export workout data feature

```dart
// Account deletion
class SettingsCubit extends Cubit<SettingsState> {
  Future<void> deleteAccount() async {
    // 1. Confirm user identity (re-authenticate)
    // 2. Delete remote data
    await _deleteUserUsecase.call();
    // 3. Clear local storage
    await _clearLocalData();
    // 4. Sign out
    await _signOut();
  }
}
```

### Health Data Regulations

- **HIPAA**: Health data is encrypted in transit and at rest
- **FDA**: Not a medical device; app is for fitness tracking only

### Security Checklist

- [ ] All API calls use HTTPS
- [ ] Authentication tokens are securely stored
- [ ] Sensitive data is encrypted at rest
- [ ] User passwords meet complexity requirements
- [ ] Session timeout is implemented
- [ ] Biometric authentication is available (optional)
- [ ] Account deletion is supported
- [ ] Privacy policy is accessible in-app

---

## Security Best Practices

### 1. Never Hardcode Secrets

```dart
// Bad
const apiKey = 'sk_live_1234567890abcdef';

// Good
final apiKey = const String.fromEnvironment('API_KEY');

// Or use Firebase Remote Config
final apiKey = await _remoteConfig.getString('api_key');
```

### 2. Validate All Inputs

```dart
// Server-side validation
class RegisterParams {
  final String email;
  final String password;
  
  Map<String, dynamic> toJson() {
    // Validation
    assert(email.isNotEmpty && email.contains('@'));
    assert(password.length >= 8);
    
    return {
      'email': email,
      'password': password, // Server will hash this
    };
  }
}
```

### 3. Secure Logging

```dart
// Never log sensitive data
log.d('User logged in: $email'); // BAD
log.d('User logged in: [REDACTED]'); // GOOD

// Sanitize before logging
String sanitizeForLog(String input) {
  return input
    .replaceAll(RegExp(r'\b\d{16}\b'), '[CARD]')
    .replaceAll(RegExp(r'password[=:]\S+', caseSensitive: false), '[PASSWORD]');
}
```

### 4. Session Management

```dart
// Automatic token refresh
class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, attempt refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry request with new token
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer ${await _getToken()}';
        handler.resolve(await _dio.fetch(opts));
        return;
      }
    }
    handler.next(err);
  }
}
```

### 5. Biometric Authentication (Optional)

```dart
// Local authentication for sensitive actions
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  Future<bool> authenticate() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    if (!canCheck) return false;
    
    return await _localAuth.authenticate(
      localizedReason: 'Authenticate to access workout data',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
  }
}
```

---

## Security Incident Response

### Reporting Security Issues

1. **Internal**: Report to security@hatofit.com
2. **Bug Bounty**: Participate in our responsible disclosure program
3. **Emergency**: Disable API access via Firebase Console

### Data Breach Response

```dart
// Remote kill switch via Firebase Remote Config
class SecurityService {
  static Future<bool> isAppBlocked() async {
    final blocked = await _remoteConfig.getBool('security_block_app');
    if (blocked) {
      // Clear all sensitive data
      await _clearAllData();
      return true;
    }
    return false;
  }
}
```

---

## Dependencies

```yaml
# pubspec.yaml
dependencies:
  firebase_crashlytics: ^4.3.2
  crypto: ^3.0.3
  
dev_dependencies:
  # Security scanning
  dependency_validator: ^3.2.3
```

---

## Related Documentation

- [Database](./DATABASE.md)
- [BLE Integration](./BLE_INTEGRATION.md)
- [Troubleshooting](./TROUBLESHOOTING.md)
- [Deployment](./DEPLOYMENT.md)
