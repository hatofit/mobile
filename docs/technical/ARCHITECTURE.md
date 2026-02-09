# Architecture Overview

This document describes the architectural design and patterns used in the HatoFit mobile application.

**Level**: Intermediate  
**Audience**: Developers, Technical Architects  
**Last Updated**: February 2026

---

## Table of Contents

1. [Architecture Philosophy](#architecture-philosophy)
2. [Clean Architecture Layers](#clean-architecture-layers)
3. [Data Flow](#data-flow)
4. [Project Structure](#project-structure)
5. [Key Components](#key-components)
6. [State Management](#state-management)
7. [Dependency Injection](#dependency-injection)
8. [Error Handling](#error-handling)
9. [Navigation](#navigation)
10. [Data Persistence](#data-persistence)

---

## Architecture Philosophy

HatoFit follows **Clean Architecture** principles as described by Robert C. Martin (Uncle Bob). This approach ensures:

- **Separation of Concerns**: Each layer has a single responsibility
- **Testability**: Business logic is isolated and easily testable
- **Independence**: UI, database, and external frameworks can be changed independently
- **Maintainability**: Clear boundaries make the codebase easier to understand and modify

### The Dependency Rule

Dependencies only point inward. Outer layers can depend on inner layers, but never the other way around.

```
Presentation Layer → Domain Layer → Data Layer
     (UI)              (Business)      (Storage)
```

---

## Clean Architecture Layers

### 1. Domain Layer (Innermost)

The heart of the application containing pure business logic.

```
lib/domain/
├── entities/          # Core business objects
├── repositories/      # Abstract repository interfaces
└── usecases/          # Business logic operations
```

**Entities**
- Represent core business objects
- No dependencies on external frameworks
- Example: `UserEntity`, `WorkoutEntity`, `ExerciseEntity`

**Repository Interfaces**
- Define contracts for data operations
- Abstract away data source implementations
- Example: `AuthRepository`, `WorkoutRepository`

**Use Cases**
- Encapsulate specific business operations
- Single responsibility - one use case = one action
- Example: `LoginUseCase`, `StartWorkoutUseCase`

```dart
// Example: Use Case
class GetWorkoutHistoryUseCase {
  final WorkoutRepository repository;
  
  GetWorkoutHistoryUseCase(this.repository);
  
  Future<Either<Failure, List<WorkoutEntity>>> call() async {
    return await repository.getWorkoutHistory();
  }
}
```

### 2. Data Layer

Handles data operations and external communication.

```
lib/data/
├── datasources/       # Data source implementations
├── models/            # Data models (DTOs)
└── repositories/      # Repository implementations
```

**Data Sources**
- Remote: API calls via Dio
- Local: Hive database operations

```dart
// Example: Remote Data Source
class WorkoutRemoteDataSource {
  final Dio dio;
  
  Future<WorkoutModel> getWorkout(String id) async {
    final response = await dio.get('/workouts/$id');
    return WorkoutModel.fromJson(response.data);
  }
}
```

**Models**
- Extend entities with serialization logic
- Handle JSON conversion
- Example: `UserModel extends UserEntity`

**Repository Implementations**
- Implement domain repository interfaces
- Coordinate between multiple data sources
- Handle caching strategies

```dart
// Example: Repository Implementation
class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDataSource remote;
  final WorkoutLocalDataSource local;
  
  @override
  Future<Either<Failure, WorkoutEntity>> getWorkout(String id) async {
    try {
      // Try cache first
      final cached = await local.getWorkout(id);
      if (cached != null) return Right(cached);
      
      // Fetch from remote
      final workout = await remote.getWorkout(id);
      await local.cacheWorkout(workout);
      return Right(workout);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
```

### 3. Presentation Layer (Outermost)

Handles UI and user interactions.

```
lib/ui/
├── cubits/            # State management (BLoC/Cubit)
├── views/             # Screen widgets
└── widgets/           # Reusable UI components
```

**Cubits**
- Manage UI state
- Handle user actions
- Call use cases from domain layer

```dart
// Example: Cubit
class WorkoutCubit extends Cubit<WorkoutState> {
  final GetWorkoutHistoryUseCase getHistory;
  
  WorkoutCubit(this.getHistory) : super(WorkoutInitial());
  
  Future<void> loadHistory() async {
    emit(WorkoutLoading());
    
    final result = await getHistory();
    result.fold(
      (failure) => emit(WorkoutError(failure.message)),
      (workouts) => emit(WorkoutLoaded(workouts)),
    );
  }
}
```

**Views**
- Screen-level widgets
- Connect Cubits to UI
- Handle navigation

```dart
// Example: View
class WorkoutHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WorkoutCubit>()..loadHistory(),
      child: Scaffold(
        body: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutLoading) {
              return LoadingWidget();
            } else if (state is WorkoutLoaded) {
              return WorkoutList(workouts: state.workouts);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
```

---

## Data Flow

### Typical Flow: Loading Workout History

```
┌─────────────┐
│     UI      │  User opens history screen
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    Cubit    │  Emits loading state
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Use Case   │  Business logic
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Repository │  Coordinates data sources
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ Data Source │  Fetch from API or cache
└─────────────┘
```

### Data Flow with Error Handling

```dart
// Error handling at each layer
1. Data Source: Catches DioError → throws exception
2. Repository: Catches exception → returns Either<Failure, Data>
3. Use Case: No error handling (pure business logic)
4. Cubit: Handles Either → emits Error state
5. UI: Displays error message based on state
```

---

## Project Structure

```
lib/
├── core/                          # Core utilities & constants
│   ├── constant/                  # App constants
│   ├── error/                     # Error handling
│   ├── network/                   # Network utilities
│   ├── theme/                     # Theme definitions
│   └── widgets/                   # Shared widgets
│
├── data/                          # Data layer
│   ├── datasources/
│   │   ├── local/                 # Hive data sources
│   │   └── remote/                # API data sources
│   ├── models/                    # Data models
│   └── repositories/              # Repository implementations
│
├── domain/                        # Domain layer
│   ├── entities/                  # Business entities
│   ├── repositories/              # Repository interfaces
│   └── usecases/                  # Business logic
│
├── ui/                            # Presentation layer
│   ├── cubits/                    # State management
│   ├── views/                     # Screens
│   └── widgets/                   # UI components
│
├── utils/                         # Utilities
│   ├── extensions/                # Dart extensions
│   └── helpers/                   # Helper functions
│
├── main.dart                      # Entry point
├── my_app.dart                    # App configuration
└── service_locator.dart           # DI configuration
```

---

## Key Components

### Core Module

**Constants**
```dart
// lib/core/constant/
- api_constant.dart        # API endpoints
- app_constant.dart        # App-wide constants
- color_constant.dart      # Color definitions
- storage_constant.dart    # Storage keys
```

**Error Handling**
```dart
// lib/core/error/
- exceptions.dart          # Custom exceptions
- failures.dart            # Failure classes
```

### Service Locator

Centralized dependency injection configuration:

```dart
// service_locator.dart
final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Hive);
  
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  
  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  
  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  
  // Cubits
  sl.registerFactory(() => AuthCubit(sl(), sl()));
}
```

---

## State Management

### BLoC Pattern

HatoFit uses the **BLoC (Business Logic Component)** pattern via `flutter_bloc`:

**States**
- Immutable representations of UI state
- Use `freezed` for code generation

```dart
@freezed
class WorkoutState with _$WorkoutState {
  const factory WorkoutState.initial() = _Initial;
  const factory WorkoutState.loading() = _Loading;
  const factory WorkoutState.loaded(List<WorkoutEntity> workouts) = _Loaded;
  const factory WorkoutState.error(String message) = _Error;
}
```

**Events (Cubits use methods instead)**

```dart
class WorkoutCubit extends Cubit<WorkoutState> {
  // Methods act as events
  Future<void> loadWorkouts() async { ... }
  Future<void> startWorkout(String id) async { ... }
  Future<void> completeWorkout() async { ... }
}
```

### Reactive Streams

For real-time data like heart rate monitoring:

```dart
class BluetoothCubit extends Cubit<BluetoothState> {
  StreamSubscription? _hrSubscription;
  
  void startMonitoring(String deviceId) {
    _hrSubscription = polar.heartRateStream(deviceId).listen(
      (hrData) => emit(BluetoothState.heartRateReceived(hrData)),
    );
  }
  
  @override
  Future<void> close() {
    _hrSubscription?.cancel();
    return super.close();
  }
}
```

---

## Dependency Injection

HatoFit uses **GetIt** combined with **Injectable** for dependency injection.

### Registration Types

**Lazy Singleton**
```dart
@lazySingleton
class AuthRepositoryImpl implements AuthRepository { }
// Created on first use, reused thereafter
```

**Factory**
```dart
@injectable
class AuthCubit extends Cubit<AuthState> { }
// New instance every time
```

**Singleton**
```dart
@singleton
class ApiClient { }
// Created immediately, reused throughout
```

### Injectable Code Generation

```bash
# Generate DI code
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Error Handling

### Failure Classes

```dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('Server error occurred');
}

class CacheFailure extends Failure {
  CacheFailure() : super('Cache error occurred');
}

class NetworkFailure extends Failure {
  NetworkFailure() : super('No internet connection');
}
```

### Either Type

Using `dartz` package for functional error handling:

```dart
// Repository returns Either<Failure, Success>
Future<Either<Failure, UserEntity>> login(LoginParams params);

// Cubit handles the result
final result = await loginUseCase(params);
result.fold(
  (failure) => emit(AuthError(failure.message)),
  (user) => emit(AuthAuthenticated(user)),
);
```

### Exception to Failure Mapping

```dart
try {
  final response = await dio.get('/user');
  return Right(UserModel.fromJson(response.data));
} on DioError catch (e) {
  if (e.type == DioErrorType.connectTimeout) {
    return Left(NetworkFailure());
  }
  return Left(ServerFailure());
} catch (e) {
  return Left(UnknownFailure());
}
```

---

## Navigation

HatoFit uses **GoRouter** for declarative navigation.

### Router Configuration

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: '/workout/:id',
      builder: (context, state) {
        final id = state.params['id']!;
        return WorkoutDetailView(workoutId: id);
      },
    ),
  ],
);
```

### Navigation Helpers

```dart
// Navigate to route
context.go('/workout/123');

// Navigate with push
context.push('/profile');

// Pop current route
context.pop();

// Replace current route
context.replace('/home');
```

---

## Data Persistence

### Local Storage: Hive

Hive is used for fast, lightweight local storage.

**Box Types**
```dart
- userBox: User profile data
- settingsBox: App settings (theme, language)
- workoutsBox: Cached workout data
- authBox: Authentication tokens
```

**Example Model**
```dart
@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String email;
}
```

**Code Generation**
```bash
flutter pub run build_runner build
```

### Remote Storage

Firebase Firestore for cloud data:
- User profiles
- Workout history
- Exercise libraries

REST API for:
- Authentication
- Real-time workout sessions
- Analytics

---

## Architecture Benefits

### Testability

Each layer can be tested independently:

```dart
// Test Use Case without UI or Database
void main() {
  test('should return user when login succeeds', () async {
    final mockRepo = MockAuthRepository();
    when(mockRepo.login(any)).thenAnswer((_) async => Right(testUser));
    
    final useCase = LoginUseCase(mockRepo);
    final result = await useCase(testParams);
    
    expect(result, Right(testUser));
  });
}
```

### Maintainability

- Clear separation makes code easier to understand
- Changes in one layer don't affect others
- New features follow established patterns

### Scalability

- Easy to add new data sources
- New features follow consistent structure
- State management scales with complexity

---

## Best Practices

### DO
- Keep domain layer pure (no Flutter dependencies)
- Use Either for error handling
- Write unit tests for use cases
- Keep Cubits focused on a single feature
- Use dependency injection for all dependencies

### DON'T
- Import Flutter packages in domain layer
- Call repositories directly from UI
- Mix business logic with UI code
- Use mutable state in entities
- Ignore error cases

---

## Related Documentation

- [Setup Guide](SETUP.md) - Environment configuration
- [State Management](STATE_MANAGEMENT.md) - Detailed BLoC patterns
- [Database Guide](DATABASE.md) - Data persistence details
- [Code Style](../contributing/CODE_STYLE.md) - Coding standards

---

**Questions?** Refer to the [Glossary](../meta/GLOSSARY.md) or contact the development team.