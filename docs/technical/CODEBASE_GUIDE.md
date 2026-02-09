# Codebase Guide

Guide for navigating and understanding the HatoFit codebase structure.

**Level**: Beginner  
**Audience**: New developers, Contributors  
**Last Updated**: February 2026

---

## Directory Structure

```
mobile/
├── android/                    # Android-specific code
│   ├── app/
│   └── build.gradle
├── assets/                     # Static resources
│   ├── fonts/
│   ├── images/
│   └── videos/
├── ios/                       # iOS-specific code
├── lib/                       # Main Flutter code
│   ├── core/                  # Shared utilities
│   ├── data/                  # Data layer
│   ├── domain/                # Domain layer
│   ├── ui/                    # Presentation layer
│   ├── utils/                 # Utilities
│   ├── main.dart              # Entry point
│   ├── my_app.dart            # Root widget
│   └── service_locator.dart    # DI configuration
├── test/                      # Unit tests
├── docs/                      # Documentation
├── pubspec.yaml               # Dependencies
└── analysis_options.yaml      # Linting rules
```

---

## Finding Things

| What | Where |
|------|-------|
| Authentication logic | `lib/domain/usecases/auth/` |
| Workout screens | `lib/ui/views/workout/` |
| Heart rate monitoring | `lib/data/datasources/ble/` |
| API client | `lib/core/network/` |
| Theme configuration | `lib/core/theme/` |
| Constants | `lib/core/constant/` |

---

## Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point |
| `lib/my_app.dart` | Root widget configuration |
| `lib/service_locator.dart` | Dependency injection setup |
| `lib/core/config/` | App configuration |
| `lib/core/navigation/` | Navigation/routing |

---

## Naming Conventions

### Files

- **Camel case**: `login_view.dart`
- **Freezed models**: `user_model.dart`
- **Cubits**: `auth_cubit.dart`
- **Use cases**: `login_usecase.dart`

### Classes

- **Entities**: `UserEntity`
- **Models**: `UserModel`
- **Cubits**: `AuthCubit`
- **Views**: `LoginView`
- **Widgets**: `PrimaryButton`

---

## Common Patterns

### Adding a New Screen

1. Create use case in `lib/domain/usecases/`
2. Create repository implementation in `lib/data/repositories/`
3. Create cubit in `lib/ui/cubits/`
4. Create view in `lib/ui/views/`
5. Add route in router configuration
6. Register in `service_locator.dart`

---

## Entry Points

### App Startup

```
main.dart
  ↓
my_app.dart
  ↓
AppWidget (theme, routing)
  ↓
SplashView → AuthCheck → [LoginView | HomeView]
```

---

## Related Documentation

- [Architecture Overview](ARCHITECTURE.md)
- [Setup Guide](SETUP.md)
- [Code Style Guide](../contributing/CODE_STYLE.md)