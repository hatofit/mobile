// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhUfTI3XOWTVTCBiC9JLh-xZmW055LPJY',
    appId: '1:123499973842:android:4b7e5e0f9a30d3931db10b',
    messagingSenderId: '123499973842',
    projectId: 'hatofit-0001',
    storageBucket: 'hatofit-0001.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1-kgU0ecIEYpavE5GOw-l4lpp3EvQoSI',
    appId: '1:123499973842:ios:bfcb43e0171bf9521db10b',
    messagingSenderId: '123499973842',
    projectId: 'hatofit-0001',
    storageBucket: 'hatofit-0001.appspot.com',
    androidClientId: '123499973842-1mlmtengb12esa08rm3hk9fu6b18a8a1.apps.googleusercontent.com',
    iosClientId: '123499973842-8ttoase65eifgikit86i6ku39kgc95ou.apps.googleusercontent.com',
    iosBundleId: 'com.hatofit.hatofit',
  );
}
