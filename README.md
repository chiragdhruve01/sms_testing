# sms

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Add firebase to project

dart pub global activate flutterfire_cli
flutterfire configure --project=learning-e8937

add this lines in main.dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

## For using firebase in web use in we/index.html

  <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>

create firebase-messaging-sw.js file in same folder and paste below code
importScripts('https://www.gstatic.com/firebasejs/9.1.3/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.1.3/firebase-messaging-compat.js');
firebase.initializeApp({
    apiKey: "",
    authDomain: "learning-e8937.firebaseapp.com",
    projectId: "learning-e8937",
    storageBucket: "learning-e8937.appspot.com",
    messagingSenderId: "103180974870",
    appId: "1:103180974870:web:b6b447f9616569505a6e37",
    measurementId: "G-ZX1TRPPCER"
    });
const messaging = firebase.messaging();

https://firebase.flutter.dev/docs/manual-installation/web/

## to get device token
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging fcm = FirebaseMessaging.instance;


Future<String> getDeviceToken() async {
    final deviceId = await fcm.getToken();
    return deviceId!;
}

code to call that device token
websocket() async {
    String? deviceToken = await FCMPushNotifications().getDeviceToken();
    print("deviceToken" + deviceToken.toString());
}
