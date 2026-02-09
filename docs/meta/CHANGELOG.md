# Changelog

All notable changes to the HatoFit mobile application will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planned
- Integration with additional fitness devices (Garmin, Apple Watch)
- Social features (friend challenges, leaderboards)
- AI-powered workout recommendations
- Nutrition tracking integration

---

## [1.1.1] - 2026-02-09

### Added
- Enhanced heart rate zone visualization with Syncfusion gauges
- Improved Bluetooth device discovery with better error handling
- Added vibration feedback for workout milestones
- Support for offline workout mode
- Multi-language improvements (Bahasa Indonesia translations)

### Changed
- Updated Flutter to version 3.6.1
- Migrated to latest Firebase SDK versions
- Optimized video player performance with better caching
- Improved app startup time by 25%

### Fixed
- Fixed Bluetooth connection drops during workouts
- Resolved memory leak in workout history screen
- Fixed crash when switching themes rapidly
- Corrected calorie calculation for certain exercise types

### Security
- Updated dependencies to address security vulnerabilities
- Enhanced data encryption for local storage

---

## [1.1.0] - 2025-12-15

### Added
- Polar heart rate monitor integration (H10, H9, OH1)
- Real-time heart rate display during workouts
- Workout intensity zones (Warm-up, Fat Burn, Cardio, Peak)
- Heart rate-based workout recommendations
- Device connection management screen
- Support for generic BLE heart rate monitors

### Changed
- Redesigned workout player UI with real-time metrics
- Updated exercise video player to better-player-plus
- Improved Bluetooth scanning performance
- Enhanced error messages for device connection failures

### Fixed
- Fixed issue where workout timer would pause unexpectedly
- Corrected heart rate zone calculations for different age groups
- Fixed UI alignment issues on smaller devices
- Resolved Firebase Remote Config caching issues

---

## [1.0.5] - 2025-11-20

### Added
- Activity history with detailed workout reports
- Workout summary statistics (duration, calories, avg HR)
- Exercise completion tracking
- Export workout data to CSV

### Changed
- Improved workout completion flow
- Enhanced data visualization with Syncfusion charts
- Updated onboarding experience with liquid swipe animations

### Fixed
- Fixed login issues with Google Sign-In on iOS
- Resolved memory issues on low-end devices
- Fixed date formatting in activity history

---

## [1.0.4] - 2025-10-30

### Added
- Dark mode / Light mode toggle
- Theme persistence across app sessions
- Auto theme detection based on system settings

### Changed
- Refactored theming system for better maintainability
- Improved contrast ratios for accessibility
- Updated color palette for better visual consistency

### Fixed
- Fixed text visibility issues in dark mode
- Corrected button colors in various themes

---

## [1.0.3] - 2025-10-10

### Added
- User profile management
- Avatar upload with image cropping
- Personal metrics tracking (height, weight, BMI)
- Account settings and preferences

### Changed
- Updated user registration flow
- Improved form validation and error messages

### Fixed
- Fixed profile image caching issues
- Resolved keyboard overlapping input fields

---

## [1.0.2] - 2025-09-25

### Added
- Fitness companies directory
- Exercise library with filtering by company
- Exercise difficulty levels
- Video-based exercise instructions
- YouTube video integration for premium content

### Changed
- Redesigned exercise browsing experience
- Improved video loading and buffering

### Fixed
- Fixed video playback issues on Android 14
- Resolved navigation stack issues

---

## [1.0.1] - 2025-09-10

### Added
- PIN-based login as alternative to password
- Biometric authentication (fingerprint/face)
- Session management and security
- Automatic logout after inactivity

### Changed
- Enhanced authentication security
- Improved login UX with better animations

### Fixed
- Fixed auto-login issues
- Resolved token refresh problems

---

## [1.0.0] - 2025-09-01

### Added
- Initial release of HatoFit mobile application
- Email/password authentication
- Google Sign-In integration
- User onboarding with guided tour
- Basic workout tracking functionality
- Exercise library with video content
- Multi-language support (English, Bahasa Indonesia)
- Firebase Analytics integration
- Firebase Crashlytics for error tracking
- Remote configuration for feature flags

### Technical
- Clean Architecture implementation
- BLoC pattern for state management
- Hive for local data persistence
- Dio for HTTP requests
- Flutter Blue Plus for BLE connectivity
- GetIt for dependency injection

---

## Migration Guides

### Migrating from 1.0.x to 1.1.x

#### Database Migration
```dart
// Automatic migration is handled by Hive
// No manual action required
```

#### Breaking Changes
- **API Response Format**: Workout session response now includes `heartRateData` field
- **Bluetooth Permissions**: Additional `BLUETOOTH_CONNECT` permission required for Android 12+

#### Deprecations
- `oldWorkoutModel` is deprecated, use `WorkoutSessionEntity` instead

---

## Versioning Strategy

### Version Number Format
```
MAJOR.MINOR.PATCH+BUILD

Example: 1.1.1+11
```

- **MAJOR**: Breaking changes that require user action
- **MINOR**: New features, backwards compatible
- **PATCH**: Bug fixes and minor improvements
- **BUILD**: Build number (increments with each CI/CD run)

### Release Schedule
- **Major releases**: Every 6-12 months
- **Minor releases**: Every 2-3 months
- **Patch releases**: As needed for critical fixes

---

## How to Update

### For Users
1. Check your app store for updates
2. Download and install the latest version
3. Data will be preserved automatically

### For Developers
```bash
# Pull latest changes
git pull origin main

# Get dependencies
flutter pub get

# Run code generation (if needed)
flutter pub run build_runner build --delete-conflicting-outputs

# Build the app
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

---

## Contributing to Changelog

When submitting a PR, please add your changes to the `[Unreleased]` section:

```markdown
### Added
- Description of new feature

### Changed
- Description of change

### Fixed
- Description of bug fix

### Removed
- Description of removed feature

### Security
- Description of security improvement
```

---

For a complete list of commits, see the [Git history](../../commits/main).