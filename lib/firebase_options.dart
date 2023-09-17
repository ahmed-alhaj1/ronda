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
        return macos;
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
    apiKey: 'AIzaSyA5g7fCY1CER_WvKAdoUxlfzpTInsLyW44',
    appId: '1:111328722946:web:faaa7163f2bf632881271b',
    messagingSenderId: '111328722946',
    projectId: 'ronda-190d0',
    authDomain: 'ronda-190d0.firebaseapp.com',
    storageBucket: 'ronda-190d0.appspot.com',
    measurementId: 'G-8Z7CLQ2MH5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCY78KzBKO0ghxoBduR0roilNVEmOw8Cm0',
    appId: '1:111328722946:android:0871485cc7f515f581271b',
    messagingSenderId: '111328722946',
    projectId: 'ronda-190d0',
    storageBucket: 'ronda-190d0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-wVeBvvkUwzqSeFyGxOP11R0s3USExMQ',
    appId: '1:111328722946:ios:91cbc12745f8a53281271b',
    messagingSenderId: '111328722946',
    projectId: 'ronda-190d0',
    storageBucket: 'ronda-190d0.appspot.com',
    iosClientId: '111328722946-jk1fqjc9h1sha18k3npn089f0knsog2k.apps.googleusercontent.com',
    iosBundleId: 'com.example.ronda',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-wVeBvvkUwzqSeFyGxOP11R0s3USExMQ',
    appId: '1:111328722946:ios:91cbc12745f8a53281271b',
    messagingSenderId: '111328722946',
    projectId: 'ronda-190d0',
    storageBucket: 'ronda-190d0.appspot.com',
    iosClientId: '111328722946-jk1fqjc9h1sha18k3npn089f0knsog2k.apps.googleusercontent.com',
    iosBundleId: 'com.example.ronda',
  );
}