# Deployment Guide

Complete guide for building, testing, and deploying HatoFit to app stores.

**Level**: Intermediate  
**Audience**: DevOps, Release Managers, Developers  
**Last Updated**: February 2026

---

## Overview

This guide covers the complete deployment process for:

- **Android**: Google Play Store
- **iOS**: Apple App Store

---

## Pre-Deployment Checklist

### Code Quality

```bash
# Run static analysis
flutter analyze

# Run tests
flutter test

# Format code
dart format .

# Build verification
flutter build apk --debug
flutter build ios --debug --simulator
```

### Version Management

Update `pubspec.yaml`:

```yaml
version: 1.1.1+11

# Version format: MAJOR.MINOR.PATCH+BUILD_NUMBER
```

Update `android/local.properties`:

```properties
flutter.versionName=1.1.1
flutter.versionCode=11
```

---

## Android Deployment

### Build Commands

```bash
# Debug build
flutter build apk --debug

# Release build (unsigned)
flutter build apk --release

# App Bundle (recommended for Play Store)
flutter build appbundle --release
```

### Keystore Configuration

1. Generate keystore (one-time):

```bash
keytool -genkeypair -v -storetype PKCS12 \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias hatofit \
  -keystore hatofit-release-key.jks
```

2. Configure `android/key.properties`:

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=hatofit
storeFile=hatofit-release-key.jks
```

3. Sign release build:

```bash
flutter build appbundle --release \
  --target-platform android-arm,android-arm64,android-x64
```

### Play Store Submission

1. Create release in Google Play Console
2. Upload `.aab` file
3. Complete store listing
4. Set release notes
5. Submit for review

---

## iOS Deployment

### Build Commands

```bash
# Build for simulator
flutter build ios --debug --simulator

# Build for device (requires signing)
flutter build ipa --release

# Archive via Xcode
open ios/Runner.xcworkspace
# Select Product → Archive
```

### Code Signing

1. Configure signing in Xcode:
   - Select Runner target
   - Signing & Capabilities
   - Select team
   - Enable "Automatically manage signing"

2. For App Store distribution:
   - Create App Store distribution certificate
   - Configure provisioning profile

### App Store Submission

1. Upload via Xcode or Transporter app
2. Complete App Store information
3. Set age rating
4. Add screenshots
5. Submit for review

---

## CI/CD Pipeline

### GitHub Actions Example

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.6.1'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Generate code
        run: flutter pub run build_runner build
      
      - name: Run tests
        run: flutter test
      
      - name: Analyze
        run: flutter analyze

  android-build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.6.1'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build Android
        run: flutter build appbundle --release
      
      - uses: actions/upload-artifact@v3
        with:
          name: app-release.aab
          path: build/app/outputs/bundle/release/

  ios-build:
    needs: test
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.6.1'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build iOS
        run: flutter build ipa --release
      
      - uses: actions/upload-artifact@v3
        with:
          name: hatofit.ipa
          path: build/ios/ipa/
```

---

## Environment Configuration

### Build Flavors

```dart
// lib/core/config/flavors.dart

enum AppFlavor {
  development,
  staging,
  production,
}

class AppConfig {
  final String baseUrl;
  final String apiKey;
  final bool enableAnalytics;
  final AppFlavor flavor;
  
  factory AppConfig.development() {
    return AppConfig(
      baseUrl: 'https://dev-api.hatofit.com',
      apiKey: 'dev_api_key',
      enableAnalytics: false,
      flavor: AppFlavor.development,
    );
  }
  
  factory AppConfig.production() {
    return AppConfig(
      baseUrl: 'https://api.hatofit.com',
      apiKey: 'prod_api_key',
      enableAnalytics: true,
      flavor: AppFlavor.production,
    );
  }
}
```

### Build Commands by Flavor

```bash
# Development
flutter build apk --debug --flavor development

# Staging
flutter build apk --release --flavor staging

# Production
flutter build appbundle --release --flavor production
```

---

## Release Procedures

### Version Bump

```bash
# Using a script
./scripts/bump_version.sh major  # 1.1.1 → 2.0.0
./scripts/bump_version.sh minor  # 1.1.1 → 1.2.0
./scripts/bump_version.sh patch # 1.1.1 → 1.1.2
```

### Changelog Update

Update `docs/meta/CHANGELOG.md` with:

- New features
- Bug fixes
- Known issues
- Breaking changes

### Release Notes Template

```markdown
## What's New in Version X.X.X

### New Features
- Feature 1 description
- Feature 2 description

### Improvements
- Performance improvements
- UI/UX enhancements

### Bug Fixes
- Fixed issue 1
- Fixed issue 2

### Known Issues
- Issue description (if any)
```

---

## Rollback Procedures

### Emergency Rollback

1. **Google Play Store**:
   - Open Play Console
   - Go to Release → Setup → Rollback
   - Select previous version

2. **App Store**:
   - Upload new build with incremented version
   - Expedited review request if critical

---

## Monitoring

### Firebase Crashlytics

Ensure Crashlytics is enabled:

```dart
// In main.dart
await Firebase.initializeApp();
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
```

### Performance Monitoring

```dart
// Add performance monitoring
FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
```

---

## Related Documentation

- [Setup Guide](SETUP.md)
- [Testing Guide](TESTING.md)
- [Changelog](../meta/CHANGELOG.md)