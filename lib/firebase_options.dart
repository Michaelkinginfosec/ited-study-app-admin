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
    apiKey: 'AIzaSyC62iP0YIH_tngUs6Y9TkZ-_aosjx11IZo',
    appId: '1:426048874487:web:60297e5311cc610f00f0f2',
    messagingSenderId: '426048874487',
    projectId: 'ited-admin',
    authDomain: 'ited-admin.firebaseapp.com',
    storageBucket: 'ited-admin.appspot.com',
    measurementId: 'G-JDWW908VKF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjXg9phhabMcnm-8EsD-PHAdkz8vkZrYY',
    appId: '1:426048874487:android:4a5b6cd1833d99e200f0f2',
    messagingSenderId: '426048874487',
    projectId: 'ited-admin',
    storageBucket: 'ited-admin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2qaMvKN62rKtd6flBXXe54g7wr9_2xfE',
    appId: '1:426048874487:ios:5a721c2c5015967000f0f2',
    messagingSenderId: '426048874487',
    projectId: 'ited-admin',
    storageBucket: 'ited-admin.appspot.com',
    iosBundleId: 'com.example.itedStudyAppAdmin',
  );
}