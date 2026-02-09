# 📚 HatoFit Documentation

Welcome to the comprehensive HatoFit Mobile documentation. This documentation covers everything from technical architecture to user guides.

![HatoFit Logo](../assets/images/logo.png)

## 🎯 Quick Navigation

### 👨‍💻 Technical Documentation
*For developers, engineers, and technical stakeholders*

| Document | Description | Level |
|----------|-------------|-------|
| [Architecture](technical/ARCHITECTURE.md) | System design, Clean Architecture, data flow | Intermediate |
| [Setup Guide](technical/SETUP.md) | Development environment, Firebase configuration | Beginner |
| [API Reference](technical/API.md) | REST endpoints, request/response schemas | Intermediate |
| [Database](technical/DATABASE.md) | Data models, persistence, migrations | Intermediate |
| [State Management](technical/STATE_MANAGEMENT.md) | BLoC/Cubit patterns, reactive programming | Advanced |
| [BLE Integration](technical/BLE_INTEGRATION.md) | Bluetooth device integration | Advanced |
| [Security](technical/SECURITY.md) | Authentication, data encryption, compliance | Intermediate |
| [Testing](technical/TESTING.md) | Testing strategies, coverage, CI/CD | Intermediate |
| [Deployment](technical/DEPLOYMENT.md) | Build pipelines, app store submission | Intermediate |
| [Codebase Guide](technical/CODEBASE_GUIDE.md) | Navigating the codebase, file organization | Beginner |
| [Troubleshooting](technical/TROUBLESHOOTING.md) | Common issues, debugging, solutions | All Levels |

### 👔 Product Documentation
*For stakeholders, product managers, and business analysts*

| Document | Description | Audience |
|----------|-------------|----------|
| [Product Overview](product/PRODUCT_OVERVIEW.md) | Vision, value proposition, target users | Executives, Investors |
| [Features](product/FEATURES.md) | Feature list, descriptions, current status | Product Managers |
| [User Journeys](product/USER_JOURNEYS.md) | End-to-end user flows and interactions | UX Designers |
| [Business Logic](product/BUSINESS_LOGIC.md) | Domain rules, calculations, requirements | Business Analysts |
| [Roadmap](product/ROADMAP.md) | Current features, upcoming releases | Stakeholders |
| [Analytics](product/ANALYTICS.md) | Metrics, KPIs, success tracking | Data Analysts |

### 📖 User Guides
*For end users and support teams*

| Document | Description | Audience |
|----------|-------------|----------|
| [Getting Started](guides/GETTING_STARTED.md) | Account creation, first workout | New Users |
| [User Guide](guides/USER_GUIDE.md) | Complete app walkthrough | All Users |
| [Bluetooth Setup](guides/BLUETOOTH_SETUP.md) | Connecting heart rate monitors | Device Users |
| [Workout Guide](guides/WORKOUT_GUIDE.md) | Using workout features effectively | Fitness Users |
| [FAQ](guides/FAQ.md) | Frequently asked questions | Support & Users |

### 🤝 Contributing
*For contributors and team members*

| Document | Description | Audience |
|----------|-------------|----------|
| [Contributing Guidelines](contributing/CONTRIBUTING.md) | How to contribute, workflow | External Contributors |
| [Code of Conduct](contributing/CODE_OF_CONDUCT.md) | Community standards | All Contributors |
| [Code Style](contributing/CODE_STYLE.md) | Coding standards, linting | Developers |
| [PR Template](contributing/PULL_REQUEST_TEMPLATE.md) | Pull request format | Contributors |
| [Issue Template](contributing/ISSUE_TEMPLATE.md) | Bug report format | Reporters |

### 📋 Project Meta
*Project information and references*

| Document | Description |
|----------|-------------|
| [Changelog](meta/CHANGELOG.md) | Version history, breaking changes |
| [License](meta/LICENSE.md) | Software license terms |
| [Dependencies](meta/DEPENDENCIES.md) | Third-party packages and licenses |
| [Glossary](meta/GLOSSARY.md) | Terminology and abbreviations |

---

## 📱 About HatoFit

**HatoFit** is a comprehensive mobile fitness tracking application built with Flutter that helps users track their workouts, monitor heart rate through Bluetooth devices, and achieve their fitness goals.

### Key Features
- 🔐 Secure authentication (Email, Google Sign-In)
- 💪 Guided workouts with video instructions
- ❤️ Real-time heart rate monitoring via BLE devices
- 📊 Activity history and detailed analytics
- 🏢 Fitness company partnerships
- 🌍 Multi-language support (English, Bahasa Indonesia)
- 🌙 Dark/Light theme support

### Supported Platforms
- **Android**: API 24+ (Android 7.0+)
- **iOS**: iOS 12+

### Supported Devices
- Polar H10, H9, OH1 heart rate monitors
- Generic BLE heart rate monitors

---

## 🚀 Getting Started

### For Developers
1. Start with the [Setup Guide](technical/SETUP.md)
2. Read the [Architecture Overview](technical/ARCHITECTURE.md)
3. Explore the [Codebase Guide](technical/CODEBASE_GUIDE.md)

### For Product Managers
1. Review the [Product Overview](product/PRODUCT_OVERVIEW.md)
2. Check the [Features List](product/FEATURES.md)
3. Understand [User Journeys](product/USER_JOURNEYS.md)

### For End Users
1. Read the [Getting Started Guide](guides/GETTING_STARTED.md)
2. Follow the [User Guide](guides/USER_GUIDE.md)
3. Check the [FAQ](guides/FAQ.md) for common questions

---

## 🏗️ Architecture Overview

HatoFit follows **Clean Architecture** principles with three main layers:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│    (UI, Cubits, Views, Widgets)     │
├─────────────────────────────────────┤
│          Domain Layer               │
│   (Entities, Use Cases, Interfaces) │
├─────────────────────────────────────┤
│           Data Layer                │
│ (Repositories, Models, Data Sources)│
└─────────────────────────────────────┘
```

**State Management**: BLoC/Cubit pattern with reactive programming
**Dependency Injection**: GetIt service locator
**Local Storage**: Hive NoSQL database
**Backend**: REST API with Firebase integration

For detailed architecture information, see [Architecture Documentation](technical/ARCHITECTURE.md).

---

## 📊 Project Statistics

- **Platform**: Flutter (Dart)
- **Architecture**: Clean Architecture
- **State Management**: flutter_bloc (Cubit)
- **Total Files**: 415+ Dart files
- **Languages**: English, Bahasa Indonesia
- **Current Version**: 1.1.1+11

---

## 🔗 External Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Polar SDK Documentation](https://github.com/polarofficial/polar-ble-sdk)

---

## 💬 Support

- **Technical Issues**: See [Troubleshooting Guide](technical/TROUBLESHOOTING.md)
- **Feature Requests**: See [Contributing Guidelines](contributing/CONTRIBUTING.md)
- **User Support**: See [FAQ](guides/FAQ.md)

---

## 📄 License

This project is proprietary software. See [License](meta/LICENSE.md) for details.

---

## 🔄 Last Updated

Last updated: **February 2026**

---

<p align="center">
  Made with 💪 for fitness enthusiasts everywhere
</p>