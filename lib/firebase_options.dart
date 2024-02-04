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
    apiKey: 'AIzaSyAtON2PhaTtLSLDuawH7fNYDg7CPIyz2xo',
    appId: '1:155656307072:web:44151850d5793818044165',
    databaseURL: "https://chat-app-5d601-default-rtdb.asia-southeast1.firebasedatabase.app",
    messagingSenderId: '155656307072',
    projectId: 'chat-app-5d601',
    authDomain: 'chat-app-5d601.firebaseapp.com',
    storageBucket: 'chat-app-5d601.appspot.com',
    measurementId: 'G-CSK1PJWHLQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANr3MNTGaGfhfrPt6uohyp26gZQ-_ilcU',
    appId: '1:155656307072:android:1694286354f70c80044165',
    databaseURL: "https://chat-app-5d601-default-rtdb.asia-southeast1.firebasedatabase.app",
    messagingSenderId: '155656307072',
    projectId: 'chat-app-5d601',
    storageBucket: 'chat-app-5d601.appspot.com',
  );
}
