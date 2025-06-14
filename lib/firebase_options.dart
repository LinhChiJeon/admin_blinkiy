// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDhcTCfrEflyknE2cxDcUW6a9qShgXtjGo',
    appId: '1:1017123463180:web:17f2c579dacc49463d4e29',
    messagingSenderId: '1017123463180',
    projectId: 'mobile-79dd3',
    authDomain: 'mobile-79dd3.firebaseapp.com',
    storageBucket: 'mobile-79dd3.firebasestorage.app',
    measurementId: 'G-FK78CNT6XZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDclf6lBhPlxcaz4K7qkicrYM_IlgFVLho',
    appId: '1:1017123463180:android:8efcead080d16acb3d4e29',
    messagingSenderId: '1017123463180',
    projectId: 'mobile-79dd3',
    storageBucket: 'mobile-79dd3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLpptGRCtMZEeA58s3UQ1VQba8P3PgeAQ',
    appId: '1:1017123463180:ios:80182ecf60742f7c3d4e29',
    messagingSenderId: '1017123463180',
    projectId: 'mobile-79dd3',
    storageBucket: 'mobile-79dd3.firebasestorage.app',
    androidClientId: '1017123463180-blovqep0q02inosfcipohl499kgjh5km.apps.googleusercontent.com',
    iosClientId: '1017123463180-nfash12tve98078lbiaevksn5djv2obd.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminBlinkiy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLpptGRCtMZEeA58s3UQ1VQba8P3PgeAQ',
    appId: '1:1017123463180:ios:80182ecf60742f7c3d4e29',
    messagingSenderId: '1017123463180',
    projectId: 'mobile-79dd3',
    storageBucket: 'mobile-79dd3.firebasestorage.app',
    androidClientId: '1017123463180-blovqep0q02inosfcipohl499kgjh5km.apps.googleusercontent.com',
    iosClientId: '1017123463180-nfash12tve98078lbiaevksn5djv2obd.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminBlinkiy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDhcTCfrEflyknE2cxDcUW6a9qShgXtjGo',
    appId: '1:1017123463180:web:3aa70ab10962e3c43d4e29',
    messagingSenderId: '1017123463180',
    projectId: 'mobile-79dd3',
    authDomain: 'mobile-79dd3.firebaseapp.com',
    storageBucket: 'mobile-79dd3.firebasestorage.app',
    measurementId: 'G-W881ZZ1JHJ',
  );
}
