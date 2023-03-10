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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAn0E7GecOng8Ncp797bzeTAHWGe-RnxK4',
    appId: '1:1041881133708:web:e9e68be2115f0947f4c1a9',
    messagingSenderId: '1041881133708',
    projectId: 'ecommerce-app-2fe57',
    authDomain: 'ecommerce-app-2fe57.firebaseapp.com',
    storageBucket: 'ecommerce-app-2fe57.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbOprlLCR9cAz0-9AB1lZOSKweF1zpAp8',
    appId: '1:1041881133708:android:88832401f7195f67f4c1a9',
    messagingSenderId: '1041881133708',
    projectId: 'ecommerce-app-2fe57',
    storageBucket: 'ecommerce-app-2fe57.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZajFT6UZt_sCXaOlTV1P-cq1TLSe5va4',
    appId: '1:1041881133708:ios:f3953c05fbd53657f4c1a9',
    messagingSenderId: '1041881133708',
    projectId: 'ecommerce-app-2fe57',
    storageBucket: 'ecommerce-app-2fe57.appspot.com',
    iosClientId: '1041881133708-q4q2ooq96cvd1gegq7fj5ino2q062om9.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceApp',
  );
}
