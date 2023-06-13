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
    apiKey: 'AIzaSyBh7qIyfN5vtgnizoWHgpO5BbTPj9JUh2E',
    appId: '1:603881904129:android:43fe8835f0036f2fa60800',
    messagingSenderId: '603881904129',
    projectId: 'historyplace-e9252',
    databaseURL: 'https://historyplace-e9252-default-rtdb.firebaseio.com',
    storageBucket: 'historyplace-e9252.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYZmdtw0PkKmbyV3V8f75puJ9uCFygDJE',
    appId: '1:603881904129:ios:97effc4ffccc9e8ba60800',
    messagingSenderId: '603881904129',
    projectId: 'historyplace-e9252',
    databaseURL: 'https://historyplace-e9252-default-rtdb.firebaseio.com',
    storageBucket: 'historyplace-e9252.appspot.com',
    iosClientId:
        '603881904129-v8452hgvd6hqgdqk378krvs5fkq86no8.apps.googleusercontent.com',
    iosBundleId: 'com.example.diplomFlutter',
  );
}
