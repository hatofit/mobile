# Code Style Guide

Coding standards and conventions for HatoFit.

**Audience**: Developers, Contributors  
**Last Updated**: February 2026

---

## Dart Style

### Naming Conventions

| Component | Convention | Example |
|-----------|------------|---------|
| Classes | PascalCase | `WorkoutCubit` |
| Variables | camelCase | `workoutList` |
| Constants | camelCase | `maxDuration` |
| Enums | PascalCase | `WorkoutStatus` |
| Files | snake_case | `workout_cubit.dart` |

### File Structure

```
lib/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── ui/
    ├── cubits/
    ├── views/
    └── widgets/
```

---

## Flutter Specific

### Widget Building

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Title'),
    ),
    body: Center(
      child: ChildWidget(),
    ),
  );
}
```

### State Management

Use Cubit with freezed states:

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
}
```

---

## Code Organization

### Imports

```dart
// External packages
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

// Internal
import '../../../domain/entities/user.dart';
import '../../../core/error/failures.dart';
```

### Project Structure

Follow Clean Architecture:
- Domain layer: Pure business logic
- Data layer: Data operations
- UI layer: Presentation only

---

## Best Practices

### DO

- Use `const` constructors
- Prefer `final` for variables
- Handle all exceptions
- Write meaningful comments
- Follow single responsibility

### DON'T

- Use `var` without type inference
- Leave unused imports
- Mix concerns in one file
- Commit commented-out code
- Ignore lint warnings

---

## Linting

### Custom Rules

Configured in `analysis_options.yaml`:

```yaml
analyzer:
  exclude:
    - build/**
  errors:
    missing_return: error
    dead_code: warning
```

### Common Warnings

| Warning | Meaning | Action |
|---------|---------|--------|
| unused_import | Import not used | Remove |
| dead_code | Unreachable code | Remove |
| missing_return | Function may not return | Fix |

---

## Documentation

### Comments

```dart
/// Calculates heart rate zone based on current HR
/// and user's maximum heart rate
int calculateZone(int currentHr, int maxHr) {
  // Implementation
}
```

### Public APIs

All public methods must have documentation comments.

---

## Testing

### Test Naming

```dart
void main() {
  test('should return true when login succeeds', () {
    // Test
  });
  
  group('calculateZone', () {
    test('returns fat burn zone when HR is 120', () {
      // Test
    });
  });
}
```

---

## Related Documents

- [Contributing Guidelines](CONTRIBUTING.md)
- [Architecture](../technical/ARCHITECTURE.md)