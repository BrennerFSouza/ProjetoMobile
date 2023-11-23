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
    apiKey: 'AIzaSyC6srq2AoQj2GPiFvgWfrKxXQKCu5Ns4Yw',
    appId: '1:285489012367:web:44829ce1d86683462f5afa',
    messagingSenderId: '285489012367',
    projectId: 'nutrifit-d4c91',
    authDomain: 'nutrifit-d4c91.firebaseapp.com',
    storageBucket: 'nutrifit-d4c91.appspot.com',
    measurementId: 'G-4ZNHXYXV6X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDJW_7OsX8LX91FBK9-GnVDfyuU63k_Tk',
    appId: '1:285489012367:android:cee3503cdc604eb22f5afa',
    messagingSenderId: '285489012367',
    projectId: 'nutrifit-d4c91',
    storageBucket: 'nutrifit-d4c91.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArzWIFVl0qBaWSUGVAybdO_cXI9QZ6pA8',
    appId: '1:285489012367:ios:7da0a7b84112533b2f5afa',
    messagingSenderId: '285489012367',
    projectId: 'nutrifit-d4c91',
    storageBucket: 'nutrifit-d4c91.appspot.com',
    iosBundleId: 'com.example.projetomobile',
  );
}
