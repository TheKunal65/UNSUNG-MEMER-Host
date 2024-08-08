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
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
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
    apiKey: 'AIzaSyBXPh7TRmtuZ1ty8rtb0KBFPFQS6QWV35Y',
    appId: '1:1086104036676:web:b982b7cb78fe7b6c756311',
    messagingSenderId: '1086104036676',
    projectId: 'unsung-memer-ed337',
    authDomain: 'unsung-memer-ed337.firebaseapp.com',
    storageBucket: 'unsung-memer-ed337.appspot.com',
    measurementId: 'G-31B64R9EYD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_VCeWWePG6WrnX6pbd2vl8xgVwQxBMPA',
    appId: '1:1086104036676:android:1d8191b2fa86c53f756311',
    messagingSenderId: '1086104036676',
    projectId: 'unsung-memer-ed337',
    storageBucket: 'unsung-memer-ed337.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6XD_ON8jzaks8kLHvLpMsbgGhKjskKU0',
    appId: '1:1086104036676:ios:3c98723e37e2e786756311',
    messagingSenderId: '1086104036676',
    projectId: 'unsung-memer-ed337',
    storageBucket: 'unsung-memer-ed337.appspot.com',
    iosBundleId: 'com.example.unsungMemerHost',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6XD_ON8jzaks8kLHvLpMsbgGhKjskKU0',
    appId: '1:1086104036676:ios:3c98723e37e2e786756311',
    messagingSenderId: '1086104036676',
    projectId: 'unsung-memer-ed337',
    storageBucket: 'unsung-memer-ed337.appspot.com',
    iosBundleId: 'com.example.unsungMemerHost',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXPh7TRmtuZ1ty8rtb0KBFPFQS6QWV35Y',
    appId: '1:1086104036676:web:8651d04a7ffef5bd756311',
    messagingSenderId: '1086104036676',
    projectId: 'unsung-memer-ed337',
    authDomain: 'unsung-memer-ed337.firebaseapp.com',
    storageBucket: 'unsung-memer-ed337.appspot.com',
    measurementId: 'G-XGT4Q6CKXL',
  );
}
