# Dependencies

This document lists all third-party dependencies used in the HatoFit mobile application, including their licenses and usage.

---

## Core Dependencies

### Flutter Framework
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| flutter | 3.6.1 | BSD-3-Clause | Core framework |
| dart | >=3.6.0 <4.0.0 | BSD-3-Clause | Programming language |

### State Management
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| flutter_bloc | ^9.0.0 | MIT | BLoC/Cubit state management |
| bloc | ^9.0.0 | MIT | Core BLoC library |
| equatable | ^2.0.7 | MIT | Value equality |

### Navigation
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| go_router | ^14.7.2 | BSD-3-Clause | Declarative routing |

### Dependency Injection
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| get_it | ^8.0.3 | MIT | Service locator |
| injectable | ^2.5.0 | MIT | Code generation for DI |

---

## Networking

### HTTP Client
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| dio | ^5.8.0+1 | MIT | HTTP client |
| dio_smart_retry | ^7.0.1 | MIT | Request retry logic |
| pretty_dio_logger | ^1.4.0 | MIT | Request/response logging |

---

## Firebase Services

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| firebase_core | ^3.11.0 | BSD-3-Clause | Firebase core integration |
| firebase_analytics | ^11.4.2 | BSD-3-Clause | Usage analytics |
| firebase_crashlytics | ^4.3.2 | BSD-3-Clause | Crash reporting |
| firebase_remote_config | ^5.4.0 | BSD-3-Clause | Remote configuration |
| cloud_firestore | ^5.6.3 | BSD-3-Clause | Cloud database |

---

## Bluetooth Low Energy (BLE)

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| flutter_blue_plus | ^1.35.2 | Apache-2.0 | BLE operations |
| polar | ^7.5.1 | Commercial | Polar device SDK |

---

## Local Storage

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| hive | ^2.2.3 | Apache-2.0 | NoSQL database |
| hive_flutter | ^1.1.0 | Apache-2.0 | Flutter Hive integration |
| path_provider | ^2.1.5 | BSD-3-Clause | File system access |
| path | ^1.9.0 | BSD-3-Clause | Path manipulation |

---

## Authentication

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| google_sign_in | ^6.2.2 | BSD-3-Clause | Google OAuth |
| pinput | ^5.0.1 | MIT | PIN input widget |
| local_auth | ^2.3.0 | BSD-3-Clause | Biometric authentication |
| crypto | ^3.0.6 | BSD-3-Clause | Encryption utilities |

---

## Data Models & Serialization

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| freezed | ^2.5.7 | MIT | Immutable data classes |
| freezed_annotation | ^2.4.4 | MIT | Freezed annotations |
| json_serializable | ^6.9.0 | BSD-3-Clause | JSON serialization |
| json_annotation | ^4.9.0 | BSD-3-Clause | JSON annotations |
| dartz | ^0.10.1 | MIT | Functional programming |

---

## UI Components

### Layout & Responsive
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| flutter_screenutil | ^5.9.3 | MIT | Responsive UI |
| flutter_staggered_grid_view | ^0.7.0 | MIT | Staggered grid layout |

### Charts & Visualization
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| syncfusion_flutter_charts | ^28.2.4+1 | Commercial | Data charts |
| syncfusion_flutter_gauges | ^28.2.4 | Commercial | Gauge widgets |

### Animations
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| liquid_swipe | ^3.1.0 | MIT | Onboarding animations |
| lottie | ^3.3.1 | Apache-2.0 | Lottie animations |
| shimmer | ^3.0.0 | BSD-3-Clause | Loading shimmer effect |

### Media & Images
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| cached_network_image | ^3.4.1 | MIT | Image caching |
| flutter_svg | ^2.0.17 | MIT | SVG support |
| image_picker | ^1.1.2 | Apache-2.0 | Camera/gallery access |
| image_cropper | ^9.0.0 | Apache-2.0 | Image cropping |

### Video
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| video_player | ^2.9.2 | BSD-3-Clause | Video playback |
| better_player_plus | ^1.0.8 | MIT | Advanced video player |
| youtube_explode_dart | ^2.3.9 | MIT | YouTube video access |

### Input & Forms
| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| flutter_form_builder | ^9.7.0 | MIT | Form building |
| form_builder_validators | ^11.1.2 | MIT | Form validation |
| flutter_typeahead | ^5.2.0 | BSD-3-Clause | Typeahead input |

---

## Utilities

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| logger | ^2.5.0 | MIT | Logging utility |
| oktoast | ^3.4.0 | MIT | Toast notifications |
| url_launcher | ^6.3.1 | BSD-3-Clause | URL launching |
| share_plus | ^10.1.4 | BSD-3-Clause | Content sharing |
| package_info_plus | ^8.2.0 | BSD-3-Clause | App version info |
| device_info_plus | ^11.3.0 | BSD-3-Clause | Device information |
| permission_handler | ^11.3.1 | MIT | Runtime permissions |
| connectivity_plus | ^6.1.2 | BSD-3-Clause | Network connectivity |
| keep_screen_on | ^4.0.0 | MIT | Prevent screen sleep |
| vibration | ^3.1.2 | BSD-3-Clause | Haptic feedback |
| intl | ^0.19.0 | BSD-3-Clause | Internationalization |
| collection | ^1.19.0 | BSD-3-Clause | Collection utilities |
| uuid | ^4.5.1 | BSD-3-Clause | UUID generation |

---

## Testing

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| flutter_test | SDK | BSD-3-Clause | Flutter testing |
| bloc_test | ^10.0.0 | MIT | BLoC testing |
| mockito | ^5.4.5 | Apache-2.0 | Mocking framework |
| build_runner | ^2.4.14 | BSD-3-Clause | Code generation |

---

## Code Generation

| Package | Version | License | Purpose |
|---------|---------|---------|---------|
| injectable_generator | ^2.6.2 | MIT | DI code generation |
| hive_generator | ^2.0.1 | Apache-2.0 | Hive code generation |
| freezed | ^2.5.7 | MIT | Data class generation |
| json_serializable | ^6.9.0 | BSD-3-Clause | JSON serialization |

---

## License Summary

| License | Count | Packages |
|---------|-------|----------|
| MIT | 35 | Most UI and utility packages |
| BSD-3-Clause | 28 | Flutter ecosystem packages |
| Apache-2.0 | 12 | Firebase, BLE, storage |
| Commercial | 3 | Polar SDK, Syncfusion |

---

## Security Considerations

### High-Priority Dependencies
These dependencies handle sensitive operations and should be kept up to date:

1. **firebase_core** & Firebase services - Security patches for backend
2. **local_auth** - Biometric authentication
3. **crypto** - Encryption operations
4. **dio** - Network security
5. **hive** - Local data storage

### Permission Dependencies
The following require runtime permissions:
- `permission_handler` - Camera, location, Bluetooth
- `image_picker` - Photo library, camera
- `local_auth` - Biometric hardware

---

## Updating Dependencies

### Check for Updates
```bash
flutter pub outdated
```

### Update All Dependencies
```bash
flutter pub upgrade
```

### Update Specific Package
```bash
flutter pub upgrade <package_name>
```

### Lock File
After updating, ensure `pubspec.lock` is committed to version control for reproducible builds.

---

## Dependency Vulnerabilities

Monitor for security vulnerabilities:

```bash
# Using dart
flutter pub deps

# Check for known vulnerabilities
flutter pub audit
```

---

## License Compliance

### Commercial Components

#### Syncfusion
- **License**: Community License (free for individuals/small companies)
- **Requirements**: Must display attribution
- **Website**: https://www.syncfusion.com/

#### Polar SDK
- **License**: Commercial license required for production
- **Contact**: Polar Electro Oy
- **Website**: https://www.polar.com/

### Open Source Attribution
All open source licenses are included in the app's About screen and in the `LICENSE` file.

---

## Adding New Dependencies

When adding a new dependency:

1. Check the license (prefer MIT or BSD-3-Clause)
2. Verify compatibility with existing packages
3. Update this document
4. Run `flutter pub get`
5. Test thoroughly
6. Update CHANGELOG.md

### Example
```yaml
dependencies:
  new_package: ^1.0.0
```

---

**Last Updated**: February 2026

For questions about licenses or dependencies, contact the development team.