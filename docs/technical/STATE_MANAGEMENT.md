# State Management Guide

Comprehensive guide to state management patterns used in HatoFit using BLoC/Cubit.

**Level**: Advanced  
**Audience**: Flutter developers  
**Last Updated**: February 2026

---

## Overview

HatoFit uses the **BLoC (Business Logic Component)** pattern with Cubit for state management.

### Key Principles

1. **Single Responsibility**: Each Cubit manages one feature's state
2. **Unidirectional Data Flow**: UI → Cubit → State → UI
3. **Immutable States**: States are immutable using freezed
4. **Separation of Concerns**: Business logic in use cases, not Cubits

---

## State Design

### State Classes

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  
  const factory AuthState.loading() = _Loading;
  
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  
  const factory AuthState.unauthenticated() = _Unauthenticated;
  
  const factory AuthState.error(String message) = _Error;
}
```

### Cubit Implementation

```dart
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  
  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
  ) : super(AuthState.initial());
  
  Future<void> login(String email, String password) async {
    emit(AuthState.loading());
    
    final result = await _loginUseCase(LoginParams(email, password));
    
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }
  
  Future<void> logout() async {
    emit(AuthState.loading());
    await _logoutUseCase();
    emit(AuthState.unauthenticated());
  }
  
  void checkAuthStatus() async {
    final user = await _getCurrentUserUseCase();
    if (user != null) {
      emit(AuthState.authenticated(user));
    } else {
      emit(AuthState.unauthenticated());
    }
  }
}
```

---

## Reactive Patterns

### Stream-Based State

For real-time features like heart rate monitoring:

```dart
class HeartRateCubit extends Cubit<HeartRateState> {
  StreamSubscription? _hrSubscription;
  final PolarService _polarService;
  
  HeartRateCubit(this._polarService) : super(HeartRateState.initial());
  
  void startMonitoring(String deviceId) {
    _hrSubscription = _polarService.heartRateStream(deviceId).listen(
      (reading) => emit(HeartRateState.realtime(reading)),
    );
  }
  
  void stopMonitoring() {
    _hrSubscription?.cancel();
    _hrSubscription = null;
    emit(HeartRateState.stopped());
  }
  
  @override
  Future<void> close() {
    _hrSubscription?.cancel();
    return super.close();
  }
}
```

---

## Bloc Usage in Views

```dart
class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>()..checkAuthStatus(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthState.authenticated) {
              context.go('/home');
            }
            if (state is AuthState.error) {
              showErrorSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthState.loading) {
              return const LoadingWidget();
            }
            return LoginForm();
          },
        ),
      ),
    );
  }
}
```

---

## Error Handling

### Centralized Error Handling

```dart
class GlobalErrorHandler {
  static void handle(BuildContext context, dynamic error) {
    if (error is NetworkException) {
      showError(context, 'No internet connection');
    } else if (error is ServerException) {
      showError(context, 'Server error: ${error.message}');
    } else if (error is ValidationException) {
      showValidationErrors(context, error.errors);
    } else {
      showError(context, 'An unexpected error occurred');
    }
  }
}
```

---

## Testing States

```dart
void main() {
  late AuthCubit authCubit;
  late MockLoginUseCase mockLoginUseCase;
  
  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    authCubit = AuthCubit(
      mockLoginUseCase,
      MockLogoutUseCase(),
      MockGetCurrentUserUseCase(),
    );
  });
  
  test('initial state should be AuthState.initial()', () {
    expect(authCubit.state, equals(AuthState.initial()));
  });
  
  test('login success should emit Authenticated state', () async {
    // Arrange
    when(mockLoginUseCase(any))
        .thenAnswer((_) async => Right(testUser));
    
    // Act
    await authCubit.login('test@example.com', 'password');
    
    // Assert
    expectLater(
      authCubit.stream,
      emits(AuthState.authenticated(testUser)),
    );
  });
}
```

---

## Related Documentation

- [Architecture Overview](ARCHITECTURE.md)
- [Testing Guide](TESTING.md)