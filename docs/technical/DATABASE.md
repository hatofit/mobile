# HatoFit Database Documentation

## Overview

HatoFit uses **Hive** as its primary local storage solution. Hive is a lightweight, high-performance key-value database written in pure Dart, optimized for Flutter applications.

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Hive Configuration](#hive-configuration)
3. [Data Models](#data-models)
4. [Box Structure](#box-structure)
5. [Local Data Sources](#local-data-sources)
6. [Caching Strategies](#caching-strategies)
7. [Best Practices](#best-practices)

---

## Architecture Overview

The database layer follows **Clean Architecture** principles with clear separation between:

```
┌─────────────────────────────────────────────────────────────┐
│                      UI Layer (Cubits)                       │
├─────────────────────────────────────────────────────────────┤
│                   Domain Layer (UseCases)                    │
├─────────────────────────────────────────────────────────────┤
│  Repository Layer  │  Local Data Source  │  Remote Source   │
├─────────────────────────────────────────────────────────────┤
│                    BoxClient (Hive)                          │
└─────────────────────────────────────────────────────────────┘
```

### Key Components

| Component | Description | File |
|-----------|-------------|------|
| `BoxClient` | Central Hive client managing all boxes | `lib/core/sources/local/box_client.dart` |
| `BoxKeys` | Enum for box identification | `lib/core/sources/local/box_client.dart` |
| Type Adapters | Hive type adapters for complex objects | `lib/core/sources/local/box_type_id.dart` |
| Local Data Sources | CRUD operations for each entity | `lib/data/sources/local/` |

---

## Hive Configuration

### Initialization

Hive is initialized in `main.dart` via `service_locator.dart`:

```dart
// lib/service_locator.dart
Future<void> _initHiveBoxes() async {
  await BoxClient.initHive();
  di.registerSingleton<BoxClient>(BoxClient());
}

// lib/main.dart
void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await mainInjection(); // Initializes Hive
    // ...
  }, (error, stack) async {
    await FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
```

### Box Initialization

```dart
// lib/core/sources/local/box_client.dart
class BoxClient with FirebaseCrashLogger {
  static late Box _appConfigBox;
  static late Box _userBox;
  static late Box<ExerciseEntity> _exerciseBox;
  static late Box<SessionEntity> _sessionBox;
  static late Box<ReportEntity> _reportBox;
  static late Box<CompanyEntity> _companyBox;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    registAdapter();

    _appConfigBox = await Hive.openBox(BoxKeys.appConfig.name);
    _userBox = await Hive.openBox(BoxKeys.user.name);
    _exerciseBox = await Hive.openBox<ExerciseEntity>(BoxKeys.exercise.name);
    // ... other boxes
  }
}
```

---

## Data Models

### Entity Registration

All entities must be registered with Hive before use:

```dart
// lib/core/sources/local/box_client.dart
static void registAdapter() {
  regisTheme();
  regisUser();
  regisExercise();
  regisSession();
  regisReport();
  regisCompany();
}
```

### Type IDs

Defined in `lib/core/sources/local/box_type_id.dart`:

```dart
class BoxTypeId {
  static const int user = 0;
  static const int exercise = 1;
  static const int session = 2;
  static const int report = 3;
  static const int company = 4;
  static const int activeTheme = 5;
  static const int userMetricUnits = 6;
  static const int bleEntity = 7;
  // ...
}
```

### Entity Example: UserEntity

```dart
// lib/domain/entities/user/user_entity.dart
@HiveType(typeId: BoxTypeId.user)
class UserEntity with _$UserEntity {
  const factory UserEntity({
    @HiveField(0) String? id,
    @HiveField(1) String? firstName,
    @HiveField(2) String? lastName,
    @HiveField(3) String? gender,
    @HiveField(4) String? email,
    @HiveField(5) DateTime? dateOfBirth,
    @HiveField(6) String? photo,
    @HiveField(7) UserMetricUnitsEntity? metricUnits,
    @HiveField(8) int? height,
    @HiveField(9) int? weight,
  }) = _UserEntity;
}
```

---

## Box Structure

### Box Keys Enum

```dart
enum BoxKeys {
  appConfig,   // App settings (theme, language, offline mode)
  user,        // User data, token, mood
  exercise,    // Cached exercises
  session,     // Workout sessions
  report,     // Activity reports
  company,    // Company data
}
```

### Box Configuration

| Box | Type | Purpose | Persistence |
|-----|------|---------|-------------|
| `appConfigBox` | `Box` | Theme, language, offline mode | Permanent |
| `userBox` | `Box` | User profile, auth token | Permanent |
| `exerciseBox` | `Box<ExerciseEntity>` | Cached exercises | Cache |
| `sessionBox` | `Box<SessionEntity>` | Workout history | Permanent |
| `reportBox` | `Box<ReportEntity>` | Activity reports | Permanent |
| `companyBox` | `Box<CompanyEntity>` | Company data | Cache |

---

## Local Data Sources

### Pattern Structure

Each entity has a corresponding local data source:

```dart
abstract class UserLocalDataSource {
  Either<Failure, UserEntity> readUser();
  Future<Either<Failure, UserEntity>> upsertUser(UserEntity user);
  Future<Either<Failure, void>> deleteUser();
  
  Either<Failure, String> readToken();
  Future<Either<Failure, String>> upsertToken(String token);
  // ...
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final BoxClient _client;
  
  @override
  Either<Failure, UserEntity> readUser() {
    try {
      final UserEntity? res = _client.userBox.get(UserBoxKeys.user.name);
      if (res == null) return const Left(CacheFailure("User not found"));
      return Right(res);
    } catch (error, stackTrace) {
      nonFatalError(error: error, stackTrace: stackTrace);
      return Left(CacheFailure(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> upsertUser(UserEntity user) async {
    try {
      await _client.userBox.put(UserBoxKeys.user.name, user);
      return readUser();
    } catch (error, stackTrace) {
      nonFatalError(error: error, stackTrace: stackTrace);
      return Left(CacheFailure(error.toString()));
    }
  }
}
```

### Available Local Data Sources

| Data Source | Location | Entities Managed |
|-------------|----------|------------------|
| `AppConfigLocalDataSource` | `app_config_local_data_source.dart` | Theme, language, offline mode |
| `UserLocalDataSource` | `user_local_data_source.dart` | User, token, mood |
| `ExerciseLocalDataSource` | `exercise_local_data_source.dart` | Exercises |
| `SessionLocalDataSource` | `session_local_data_source.dart` | Sessions |
| `ReportLocalDataSource` | `report_local_data_source.dart` | Reports |
| `CompanyLocalDataSource` | `company_local_data_source.dart` | Companies |

---

## Caching Strategies

### 1. Authentication Cache

User data and tokens are cached locally for offline access:

```dart
// After successful login
await _local.upsertToken(entity.token ?? "");
await _local.upsertUser(entity.user ?? const UserEntity());
```

### 2. Exercise Cache

Exercises are cached to reduce server load:

```dart
// Fetch from cache first, then server
Future<Either<Failure, List<ExerciseEntity>>> getExercises() async {
  // Try local first
  final local = await _local.getExercises();
  if (local.isRight()) return local;
  
  // Fetch from remote
  final remote = await _remote.getExercises();
  remote.fold(
    (l) => null,
    (r) => _local.cacheExercises(r), // Update cache
  );
  return remote;
}
```

### 3. Session Persistence

Workout sessions are stored locally before sync:

```dart
// Store session locally
await _sessionLocalDataSource.saveSession(session);

// Sync when online
Future<void> syncPendingSessions() async {
  final pending = await _sessionLocalDataSource.getPendingSessions();
  for (final session in pending) {
    final result = await _remote.createSession(session);
    result.fold(
      (l) => null, // Keep pending on failure
      (r) => _sessionLocalDataSource.markSynced(session.id),
    );
  }
}
```

### 4. Offline Mode

```dart
class AppConfigLocalDataSourceImpl implements AppConfigLocalDataSource {
  @override
  Either<Failure, bool> readOfflineMode() {
    final bool? offlineMode = _client.appConfigBox.get(
      AppConfigKeys.offlineMode.name
    );
    return Right(offlineMode ?? false);
  }
}
```

---

## Best Practices

### 1. Error Handling

Always wrap Hive operations in try-catch with Crashlytics logging:

```dart
try {
  await _client.userBox.put(key, value);
} catch (error, stackTrace) {
  nonFatalError(error: error, stackTrace: stackTrace);
  return Left(CacheFailure(error.toString()));
}
```

### 2. Key Management

Use enums for keys to prevent typos:

```dart
enum UserBoxKeys {
  user,
  token,
  todayMood,
}
```

### 3. Type Safety

Always specify generic types for typed boxes:

```dart
// Good
late Box<ExerciseEntity> _exerciseBox;

// Avoid
late Box _exerciseBox; // Untyped
```

### 4. Migration Strategy

When updating models, increment type IDs or use migration scripts:

```dart
// In BoxClient
static const int dbVersion = 1;

static Future<void> migrate() async {
  final currentVersion = _appConfigBox.get('dbVersion') ?? 0;
  if (currentVersion < dbVersion) {
    // Perform migrations
    await _migrateV1ToV2();
    await _appConfigBox.put('dbVersion', dbVersion);
  }
}
```

### 5. Data Cleanup

Implement cleanup for old data:

```dart
Future<void> cleanupOldSessions() async {
  final cutoff = DateTime.now().subtract(const Duration(days: 90));
  final sessions = _sessionBox.values.where(
    (s) => s.createdAt.isBefore(cutoff)
  );
  for (final session in sessions) {
    await _sessionBox.delete(session.id);
  }
}
```

---

## Dependencies

```yaml
# pubspec.yaml
dependencies:
  hive_flutter: ^1.1.0
  
dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.14
```

---

## Related Documentation

- [State Management](./STATE_MANAGEMENT.md)
- [Codebase Guide](./CODEBASE_GUIDE.md)
- [Troubleshooting](./TROUBLESHOOTING.md)
