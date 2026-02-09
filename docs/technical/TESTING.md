# Testing Guide

Comprehensive testing strategies for HatoFit Flutter application.

**Level**: Intermediate  
**Audience**: QA Engineers, Developers  
**Last Updated**: February 2026

---

## Overview

HatoFit employs a multi-layered testing strategy:

1. **Unit Tests**: Domain and data layer logic
2. **Widget Tests**: UI components
3. **Integration Tests**: End-to-end flows
4. **Bloc Tests**: State management logic

---

## Test Structure

```
test/
├── domain/                    # Domain layer tests
│   ├── usecases/
│   │   └── login_test.dart
│   └── entities/
├── data/                      # Data layer tests
│   ├── repositories/
│   └── datasources/
├── cubits/                    # Bloc/Cubit tests
│   ├── auth_cubit_test.dart
│   └── workout_cubit_test.dart
└── widgets/                   # Widget tests
    ├── login_view_test.dart
    └── workout_card_test.dart
```

---

## Unit Tests

### Use Case Test

```dart
void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockRepository;
  
  setUp(() {
    mockRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockRepository);
  });
  
  test('should return user when login succeeds', () async {
    // Arrange
    final user = UserEntity(
      id: 'test_id',
      email: 'test@example.com',
      name: 'Test User',
    );
    
    when(mockRepository.login(any))
        .thenAnswer((_) async => Right(user));
    
    // Act
    final result = await loginUseCase(
      LoginParams(email: 'test@example.com', password: 'password'),
    );
    
    // Assert
    expect(result, equals(Right(user)));
    verify(mockRepository.login(any)).called(1);
  });
  
  test('should return failure when login fails', () async {
    // Arrange
    when(mockRepository.login(any))
        .thenAnswer((_) async => Left(InvalidCredentialsFailure()));
    
    // Act
    final result = await loginUseCase(
      LoginParams(email: 'test@example.com', password: 'wrong'),
    );
    
    // Assert
    expect(result.isLeft(), true);
  });
}
```

---

## Bloc Tests

```dart
void main() {
  late AuthCubit authCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockGetCurrentUserUseCase mockGetUserUseCase;
  
  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockGetUserUseCase = MockGetCurrentUserUseCase();
    
    authCubit = AuthCubit(
      mockLoginUseCase,
      mockLogoutUseCase,
      mockGetUserUseCase,
    );
  });
  
  tearDown(() {
    authCubit.close();
  });
  
  test('initial state is AuthInitial', () {
    expect(authCubit.state, equals(AuthState.initial()));
  });
  
  blocTest<AuthCubit, AuthState>(
    'emits [loading, authenticated] on successful login',
    build: () => authCubit,
    act: (cubit) => cubit.login('test@example.com', 'password'),
    expect: () => [
      AuthState.loading(),
      AuthState.authenticated(testUser),
    ],
  );
  
  blocTest<AuthCubit, AuthState>(
    'emits [loading, error] on failed login',
    build: () => authCubit,
    act: (cubit) => cubit.login('invalid@example.com', 'wrong'),
    expect: () => [
      AuthState.loading(),
      AuthState.error('Invalid credentials'),
    ],
  );
}
```

---

## Widget Tests

```dart
void main() {
  testWidgets('login form validates email', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: LoginView(),
      ),
    );
    
    // Find the email field
    final emailField = find.byType(TextFormField).first;
    
    // Enter invalid email
    await tester.enterText(emailField, 'invalid-email');
    
    // Trigger validation
    await tester.pump();
    
    // Check for error text
    expect(find.text('Enter a valid email'), findsOneWidget);
  });
  
  testWidgets('login button is disabled when loading',
      (WidgetTester tester) async {
    // Build with mocked cubit
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => AuthCubit(
            MockLoginUseCase(),
            MockLogoutUseCase(),
            MockGetCurrentUserUseCase(),
          )..emit(AuthState.loading()),
          child: LoginView(),
        ),
      ),
    );
    
    // Find and check button state
    final loginButton = find.byType(ElevatedButton);
    final button = tester.widget<ElevatedButton>(loginButton);
    
    expect(button.enabled, isFalse);
  });
}
```

---

## Integration Tests

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Authentication Flow', () {
    testWidgets('complete login flow', (WidgetTester tester) async {
      // Launch app
      app.main();
      await tester.pumpAndSettle();
      
      // Navigate to login
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      
      // Enter credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      
      // Submit form
      await tester.tap(find.byKey(const Key('login_button')));
      
      // Wait for navigation to home
      await tester.pumpAndSettle(const Duration(seconds: 5));
      
      // Verify home screen
      expect(find.text('Welcome to HatoFit'), findsOneWidget);
    });
  });
}
```

---

## Test Coverage

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html

# View report
open coverage/html/index.html
```

### Coverage Requirements

| Component | Minimum Coverage |
|-----------|-----------------|
| Domain Layer | 90% |
| Data Layer | 80% |
| Cubits | 85% |
| UI Widgets | 60% |

---

## Best Practices

### DO

- Write tests before fixing bugs
- Use descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)
- Mock external dependencies
- Test error states, not just success

### DON'T

- Test framework code
- Make tests depend on execution order
- Leave commented-out test code
- Use real APIs in integration tests

---

## Related Documentation

- [Architecture Overview](ARCHITECTURE.md)
- [Code Style Guide](../contributing/CODE_STYLE.md)