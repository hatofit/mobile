# Development Setup Guide

Complete guide for setting up the HatoFit development environment.

**Level**: Beginner  
**Audience**: New developers joining the project  
**Last Updated**: February 2026

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Environment Setup](#environment-setup)
3. [Project Installation](#project-installation)
4. [Firebase Configuration](#firebase-configuration)
5. [Running the App](#running-the-app)
6. [Development Tools](#development-tools)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software

| Software | Version | Purpose | Download |
|----------|---------|---------|----------|
| **Flutter SDK** | 3.6.1+ | Framework | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| **Dart SDK** | 3.6.0+ | Language | Bundled with Flutter |
| **Android Studio** | Latest | Android IDE | [developer.android.com](https://developer.android.com/studio) |
| **Xcode** | 14.0+ | iOS IDE | Mac App Store |
| **Git** | 2.30+ | Version control | [git-scm.com](https://git-scm.com/) |

### System Requirements

**macOS (Recommended)**
- macOS 12.0 (Monterey) or later
- 8GB RAM minimum (16GB recommended)
- 20GB free disk space

**Windows**
- Windows 10 or later (64-bit)
- 8GB RAM minimum (16GB recommended)
- 20GB free disk space

**Linux**
- 64-bit Linux distribution
- 8GB RAM minimum (16GB recommended)
- 20GB free disk space

---

## Environment Setup

### Step 1: Install Flutter

```bash
# macOS (using Homebrew)
brew install flutter

# Or download manually
# 1. Download from https://flutter.dev/docs/get-started/install
# 2. Extract to ~/development/flutter
# 3. Add to PATH

# Verify installation
flutter doctor
```

**Expected Output:**
```
[✓] Flutter (Channel stable, 3.6.1, ...)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio
[✓] Connected device (2 available)
```

### Step 2: Configure PATH

**macOS/Linux:**
```bash
# Add to ~/.zshrc or ~/.bashrc
export PATH="$PATH:$HOME/development/flutter/bin"

# Apply changes
source ~/.zshrc
```

**Windows:**
```powershell
# Add to System Environment Variables
# Path: C:\Users\<username>\flutter\bin
```

### Step 3: Install Android Studio

1. Download from [developer.android.com](https://developer.android.com/studio)
2. Install Flutter and Dart plugins:
   - Open Android Studio
   - Preferences → Plugins
   - Search for "Flutter" and install
   - Restart Android Studio

### Step 4: Install Xcode (macOS only)

```bash
# Install from App Store, then run:
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# Accept license
sudo xcodebuild -license
```

### Step 5: Install Additional Tools

```bash
# CocoaPods (macOS)
sudo gem install cocoapods

# Git (if not installed)
# macOS: brew install git
# Windows: Download from git-scm.com
```

---

## Project Installation

### Step 1: Clone the Repository

```bash
# Clone the project
git clone https://github.com/your-org/hatofit-mobile.git
cd hatofit-mobile

# Verify you're on the correct branch
git branch
# Should show: * main
```

### Step 2: Install Dependencies

```bash
# Get Flutter packages
flutter pub get

# This will download all dependencies listed in pubspec.yaml
```

### Step 3: Generate Code

```bash
# Generate Hive adapters, freezed classes, and DI code
flutter pub run build_runner build --delete-conflicting-outputs

# For continuous generation during development:
flutter pub run build_runner watch
```

### Step 4: Verify Setup

```bash
# Check for any issues
flutter doctor

# Verify project builds
flutter analyze
```

---

## Firebase Configuration

### Step 1: Install Firebase CLI

```bash
# Install Node.js first if not installed
# Then install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login
```

### Step 2: Setup Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing
3. Note your **Project ID**: `hatofit-0001`

### Step 3: Configure Android

```bash
# Place your google-services.json in:
android/app/google-services.json

# The file should look like:
{
  "project_info": {
    "project_number": "...",
    "project_id": "hatofit-0001",
    "storage_bucket": "hatofit-0001.appspot.com"
  },
  "client": [{
    "client_info": {
      "mobilesdk_app_id": "...",
      "android_client_info": {
        "package_name": "com.hatofit.app"
      }
    }
  }]
}
```

### Step 4: Configure iOS

```bash
# Place your GoogleService-Info.plist in:
io/Runner/GoogleService-Info.plist

# Then run:
cd ios
pod install
```

### Step 5: Environment Variables

Create a `.env` file in the project root:

```env
# API Configuration
API_BASE_URL=https://api.hatofit.com
API_VERSION=v1

# Firebase
FIREBASE_PROJECT_ID=hatofit-0001

# Feature Flags
ENABLE_ANALYTICS=true
ENABLE_CRASHLYTICS=true
ENABLE_REMOTE_CONFIG=true

# Third-party Services
POLAR_SDK_KEY=your_key_here
SYNC_FUSION_LICENSE=your_license_here
```

**Note:** Never commit `.env` to version control. It's already in `.gitignore`.

---

## Running the App

### Development Mode

```bash
# List available devices
flutter devices

# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d <device_id>

# Run in debug mode with hot reload
flutter run --debug

# Run in profile mode (performance testing)
flutter run --profile

# Run in release mode
flutter run --release
```

### Platform-Specific Commands

**Android:**
```bash
# Run on Android emulator
cd android && ./gradlew clean
flutter run

# Build APK
flutter build apk --debug
flutter build apk --release
```

**iOS:**
```bash
# Run on iOS simulator
flutter run -d ios

# Build for device (requires signing)
flutter build ios --debug

# Build for release
flutter build ios --release
```

### Hot Reload & Hot Restart

```bash
# While app is running, press:
r  # Hot reload (keeps state)
R  # Hot restart (restarts app)
q  # Quit
```

---

## Development Tools

### IDE Setup

**VS Code (Recommended):**

1. Install extensions:
   - Flutter
   - Dart
   - Error Lens
   - GitLens
   - Bracket Pair Colorizer

2. Configure settings (`.vscode/settings.json`):
```json
{
  "dart.flutterSdkPath": "/path/to/flutter",
  "dart.openDevTools": "flutter",
  "editor.formatOnSave": true,
  "editor.rulers": [80, 120]
}
```

**Android Studio:**

1. Enable format on save:
   - Preferences → Editor → General → Auto Import
   - Check "Optimize imports on the fly"

2. Configure Dart SDK:
   - Preferences → Languages & Frameworks → Dart
   - Set Dart SDK path

### Debugging

```bash
# Open DevTools
flutter pub global activate devtools
flutter pub global run devtools

# Run with DevTools
flutter run --observatory-port=9200

# Then open: http://localhost:9100
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/domain/usecases/login_test.dart

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Code Generation

```bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate on file changes)
flutter pub run build_runner watch

# Clean generated files
flutter pub run build_runner clean
```

---

## Common Development Tasks

### Adding a New Feature

1. **Domain Layer:**
   ```bash
   # Create entity
   lib/domain/entities/new_feature_entity.dart
   
   # Create use case
   lib/domain/usecases/new_feature_usecase.dart
   
   # Create repository interface
   lib/domain/repositories/new_feature_repository.dart
   ```

2. **Data Layer:**
   ```bash
   # Create models
   lib/data/models/new_feature_model.dart
   
   # Create data sources
   lib/data/datasources/remote/new_feature_remote_datasource.dart
   
   # Implement repository
   lib/data/repositories/new_feature_repository_impl.dart
   ```

3. **Presentation Layer:**
   ```bash
   # Create cubit
   lib/ui/cubits/new_feature/new_feature_cubit.dart
   
   # Create view
   lib/ui/views/new_feature/new_feature_view.dart
   
   # Create widgets
   lib/ui/views/new_feature/widgets/
   ```

4. **Register Dependencies:**
   ```dart
   // service_locator.dart
   sl.registerLazySingleton(() => NewFeatureRepositoryImpl(sl()));
   sl.registerFactory(() => NewFeatureCubit(sl()));
   ```

5. **Add Route:**
   ```dart
   // router.dart
   GoRoute(
     path: '/new-feature',
     builder: (context, state) => NewFeatureView(),
   ),
   ```

6. **Generate Code:**
   ```bash
   flutter pub run build_runner build
   ```

### Adding Dependencies

```bash
# Add to pubspec.yaml
dependencies:
  new_package: ^1.0.0

# Then run
flutter pub get

# Don't forget to update docs/meta/DEPENDENCIES.md
```

---

## Troubleshooting

### Common Issues

**1. Flutter Command Not Found**
```bash
# Solution: Check PATH configuration
echo $PATH
# Should include: /path/to/flutter/bin
```

**2. Cocoapods Issues (iOS)**
```bash
# Solution: Update Cocoapods
cd ios
pod deintegrate
pod install --repo-update
```

**3. Gradle Build Failures (Android)**
```bash
# Solution: Clean and rebuild
cd android
./gradlew clean
./gradlew build
cd ..
flutter clean
flutter pub get
```

**4. Build Runner Issues**
```bash
# Solution: Clean and regenerate
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

**5. Firebase Configuration Errors**
```bash
# Verify files exist
ls android/app/google-services.json
ls ios/Runner/GoogleService-Info.plist

# Reconfigure if needed
flutter clean
flutter pub get
cd ios && pod install && cd ..
```

**6. Dart/Flutter Version Mismatch**
```bash
# Check versions
flutter --version
dart --version

# Update Flutter
flutter upgrade

# If using FVM (Flutter Version Management)
fvm use 3.6.1
fvm flutter run
```

### Getting Help

1. **Flutter Doctor:**
   ```bash
   flutter doctor -v
   ```

2. **Verbose Output:**
   ```bash
   flutter run -v
   ```

3. **Check Logs:**
   ```bash
   # iOS
   flutter logs
   
   # Android
   adb logcat
   ```

4. **Community Resources:**
   - [Flutter Documentation](https://docs.flutter.dev/)
   - [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
   - [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

---

## Development Workflow

### Daily Development

```bash
# 1. Pull latest changes
git pull origin main

# 2. Install dependencies (if needed)
flutter pub get

# 3. Generate code
flutter pub run build_runner build

# 4. Run the app
flutter run

# 5. Run tests before committing
flutter test

# 6. Analyze code
flutter analyze

# 7. Format code
dart format .
```

### Before Committing

```bash
# Run all checks
flutter analyze
flutter test
dart format --set-exit-if-changed .

# Build for both platforms
flutter build apk --debug
flutter build ios --debug --simulator
```

---

## Next Steps

After setup is complete:

1. Read the [Architecture Overview](ARCHITECTURE.md)
2. Explore the [Codebase Guide](CODEBASE_GUIDE.md)
3. Review [Code Style Guidelines](../contributing/CODE_STYLE.md)
4. Check out [Troubleshooting](TROUBLESHOOTING.md) if you encounter issues

---

**Questions?** Check the [Glossary](../meta/GLOSSARY.md) or contact the development team.