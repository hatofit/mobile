# Troubleshooting Guide

Common issues and their solutions for HatoFit development.

**Level**: All Levels  
**Audience**: All Developers  
**Last Updated**: February 2026

---

## Flutter Issues

### Flutter Doctor Shows Errors

```bash
# Run verbose diagnostic
flutter doctor -v

# Common solutions:
# 1. Update Flutter
flutter upgrade

# 2. Install missing dependencies
flutter doctor --android-licenses

# 3. Reinstall Xcode command line tools
sudo xcode-select --install

# 4. Set Android SDK path
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### Build Failures

**Android Build Fails:**

```bash
# Clean and rebuild
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter build apk --release
```

**iOS Build Fails:**

```bash
# Update CocoaPods
cd ios
pod deintegrate
pod install --repo-update
cd ..
flutter clean
flutter pub get
flutter build ios --release
```

### Hot Reload Not Working

- Save all files
- Check console for errors
- Run `flutter analyze`
- Try "Hot Restart" (R key)

---

## Dependency Issues

### Version Conflicts

```bash
# Check outdated dependencies
flutter pub outdated

# Update all
flutter pub upgrade

# Resolve conflicts manually by editing pubspec.yaml
# Then run
flutter pub get
```

### Build Runner Issues

```bash
# Clean generated files
flutter pub run build_runner clean

# Regenerate
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Firebase Issues

### Firebase Not Initializing

```bash
# Verify configuration files exist
ls android/app/google-services.json
ls ios/Runner/GoogleService-Info.plist

# Check Firebase initialization code
# Ensure FirebaseApp.initializeApp() is called
```

### Auth Token Issues

```bash
# Clear app data
flutter clean
flutter pub get

# Reset simulators
# iOS: iOS Simulator → Device → Erase All Content
# Android: Settings → Apps → HatoFit → Clear Storage
```

---

## Bluetooth Issues

### Device Not Found

1. Enable Bluetooth on device
2. Ensure device is nearby and charged
3. Check location permission (Android)
4. Try scanning again

### Connection Drops

- Reduce distance between devices
- Check for Bluetooth interference
- Restart Bluetooth on phone
- Re-pair device

---

## Performance Issues

### Slow Build Times

```bash
# Enable build cache
export FLUTTER_BUILD_CACHE_DIR=~/.flutter/build_cache

# Use --no-pub when rebuilding
flutter build apk --release --no-pub
```

### Large APK Size

```bash
# Analyze APK
flutter build apk --analyze-size

# Enable R8 minification
# In android/app/build.gradle:
buildTypes {
  release {
    minifyEnabled true
    shrinkResources true
  }
}
```

---

## IDE Issues

### VS Code Extensions Not Working

1. Reload VS Code: Ctrl+Shift+P → "Reload Window"
2. Reinstall extensions
3. Check Dart Analysis Server output

### Android Studio Issues

1. Invalidate caches: File → Invalidate Caches
2. Restart IDE
3. Flutter doctor in terminal

---

## Error Message Quick Reference

| Error | Solution |
|-------|----------|
| `Target of URI doesn't exist` | Run `flutter pub get` |
| `No Firebase App has been created` | Initialize Firebase first |
| `The method isn't defined for the type` | Run build_runner |
| `Invalid configuration` | Check pubspec.yaml |
| `Connection refused` | Check API URL, network |

---

## Getting Help

1. Check existing issues on GitHub
2. Search Flutter documentation
3. Ask in #help Discord channel
4. Contact tech lead

---

## Related Documentation

- [Setup Guide](SETUP.md)
- [Deployment Guide](DEPLOYMENT.md)