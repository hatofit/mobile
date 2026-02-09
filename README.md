# HatoFit Mobile

A comprehensive cross-platform fitness tracking application built with Flutter.

---

## About

HatoFit is a mobile fitness tracking application that helps users:
- Track workouts with guided exercise routines
- Monitor heart rate in real-time via Bluetooth devices
- View progress through detailed analytics and reports
- Connect with fitness partners and gyms

## Features

- **Workout Tracking**: Guided workouts with video instructions
- **Heart Rate Monitoring**: Real-time HR tracking with Polar devices
- **Progress Analytics**: Detailed workout statistics and trends
- **Exercise Library**: Browse exercises by company and difficulty
- **Offline Mode**: Core features work without internet
- **Multi-language**: English and Bahasa Indonesia support

## Tech Stack

- **Framework**: Flutter 3.6.1+ (Dart)
- **Architecture**: Clean Architecture with BLoC/Cubit
- **Backend**: Firebase + REST API
- **Local Storage**: Hive NoSQL database
- **BLE**: Flutter Blue Plus + Polar SDK

## Quick Start

### Prerequisites

- Flutter SDK 3.6.1+
- Dart 3.6.0+
- Android Studio / VS Code
- Firebase project setup

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/hatofit-mobile.git

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build

# Run the app
flutter run
```

### Firebase Setup

1. Create Firebase project
2. Add Android/iOS apps
3. Download config files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

## Documentation

### For Users

- [Getting Started](docs/guides/GETTING_STARTED.md)
- [User Guide](docs/guides/USER_GUIDE.md)
- [Bluetooth Setup](docs/guides/BLUETOOTH_SETUP.md)
- [Workout Guide](docs/guides/WORKOUT_GUIDE.md)
- [FAQ](docs/guides/FAQ.md)

### For Developers

- [Architecture](docs/technical/ARCHITECTURE.md)
- [Setup Guide](docs/technical/SETUP.md)
- [API Documentation](docs/technical/API.md)
- [Database Guide](docs/technical/DATABASE.md)
- [State Management](docs/technical/STATE_MANAGEMENT.md)
- [BLE Integration](docs/technical/BLE_INTEGRATION.md)
- [Security](docs/technical/SECURITY.md)
- [Testing](docs/technical/TESTING.md)
- [Deployment](docs/technical/DEPLOYMENT.md)
- [Codebase Guide](docs/technical/CODEBASE_GUIDE.md)
- [Troubleshooting](docs/technical/TROUBLESHOOTING.md)

### For Product & Stakeholders

- [Product Overview](docs/product/PRODUCT_OVERVIEW.md)
- [Features](docs/product/FEATURES.md)
- [User Journeys](docs/product/USER_JOURNEYS.md)
- [Business Logic](docs/product/BUSINESS_LOGIC.md)
- [Roadmap](docs/product/ROADMAP.md)
- [Analytics](docs/product/ANALYTICS.md)

### For Contributors

- [Contributing](docs/contributing/CONTRIBUTING.md)
- [Code of Conduct](docs/contributing/CODE_OF_CONDUCT.md)
- [Code Style](docs/contributing/CODE_STYLE.md)
- [PR Template](docs/contributing/PULL_REQUEST_TEMPLATE.md)
- [Issue Template](docs/contributing/ISSUE_TEMPLATE.md)

### Meta

- [Changelog](docs/meta/CHANGELOG.md)
- [License](docs/meta/LICENSE.md)
- [Dependencies](docs/meta/DEPENDENCIES.md)
- [Glossary](docs/meta/GLOSSARY.md)

## Project Structure

```
hatofit-mobile/
├── android/                    # Android-specific
├── ios/                       # iOS-specific
├── lib/                       # Flutter source
│   ├── core/                  # Core utilities
│   ├── data/                  # Data layer
│   ├── domain/                 # Domain layer
│   ├── ui/                     # Presentation layer
│   └── utils/                 # Utilities
├── docs/                      # Full documentation
├── test/                      # Unit tests
└── pubspec.yaml              # Dependencies
```

## Supported Platforms

| Platform | Version | Status |
|----------|---------|--------|
| Android | 7.0+ (API 24) | ✅ Supported |
| iOS | 12.0+ | ✅ Supported |

## Supported Devices

- Polar H10, H9, OH1, Verity Sense
- Generic BLE heart rate monitors

## Version

Current version: **1.1.1+11**

See [Changelog](docs/meta/CHANGELOG.md) for release history.

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](docs/contributing/CONTRIBUTING.md) before submitting PRs.

## License

This project is proprietary software. See [License](docs/meta/LICENSE.md) for details.

## Support

- **Email**: support@hatofit.com
- **Documentation**: docs/README.md
- **Issues**: GitHub Issues

---

Built with 💪 for fitness enthusiasts everywhere
