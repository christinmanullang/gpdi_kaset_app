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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAlLyqTmmUR90vmfS7Yx-7F85cvPMv7jjg',
    appId: '1:320260101838:web:5ce1d0b9811bc53b83e29f',
    messagingSenderId: '320260101838',
    projectId: 'gpdi-kaset-apps',
    authDomain: 'gpdi-kaset-apps.firebaseapp.com',
    storageBucket: 'gpdi-kaset-apps.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLs2qPeEJJdG4UfA4JZ_4bT0H8F6R_ASU',
    appId: '1:320260101838:android:c7c11ab8da3815e583e29f',
    messagingSenderId: '320260101838',
    projectId: 'gpdi-kaset-apps',
    storageBucket: 'gpdi-kaset-apps.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAlLyqTmmUR90vmfS7Yx-7F85cvPMv7jjg',
    appId: '1:320260101838:web:513a6692afbfcc5f83e29f',
    messagingSenderId: '320260101838',
    projectId: 'gpdi-kaset-apps',
    authDomain: 'gpdi-kaset-apps.firebaseapp.com',
    storageBucket: 'gpdi-kaset-apps.appspot.com',
  );

}