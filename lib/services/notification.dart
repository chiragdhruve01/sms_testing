import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils/utils.dart';

class FCMPushNotifications {
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String> getDeviceToken() async {
    final deviceId = await fcm.getToken();
    return deviceId!;
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    final largeImagePath = await Utils.downloadFile(
        'https://images.unsplash.com/photo-1668102228964-ebc7ca0866b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
        'largeImage');

    final profilePicPath = await Utils.downloadFile(
        'https://images.unsplash.com/photo-1668102228964-ebc7ca0866b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
        'profilePic');

    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(largeImagePath!),
      largeIcon: FilePathAndroidBitmap(profilePicPath!),
      contentTitle: title,
      summaryText: "Heaven",
      htmlFormatSummaryText: true,
      htmlFormatContent: true,
    );

    AndroidNotificationDetails? androidDetails = AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      styleInformation: styleInformation,
    );
    var iOSDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      generalNotificationDetails,
      payload: payload,
    );
    log(
      body!,
      name: 'FCM',
    );
  }

  Future<void> onNotifications(String? payload) async {
    if (payload != null) {}
  }

  void showxNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    print("message.notification" + message.notification!.body.toString());
    AndroidNotification? android = message.notification?.android;
    print("android" + android!.imageUrl.toString());
    print("android" + android.link.toString());
    if (notification != null && android != null) {
      final largeImagePath = await Utils.downloadFile(
          'https://images.unsplash.com/photo-1668102228964-ebc7ca0866b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
          'largeImage');

      final profilePicPath = await Utils.downloadFile(
          'https://images.unsplash.com/photo-1668102228964-ebc7ca0866b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
          'profilePic');

      final styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(largeImagePath!),
        largeIcon: FilePathAndroidBitmap(profilePicPath!),
        contentTitle: notification.title,
        summaryText: notification.title,
        htmlFormatSummaryText: true,
        htmlFormatContent: true,
      );

      AndroidNotificationDetails? androidDetails = AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'Channel Description',
        importance: Importance.max,
        styleInformation: styleInformation,
      );
      var iOSDetails = IOSNotificationDetails();
      var generalNotificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      );
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        generalNotificationDetails,
        payload: "",
      );
    }
  }

  Future<void> init({bool initScheduled = false}) async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOSInitialize = IOSInitializationSettings();
    var initializeSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message also contained a notification: ${message.notification}');
      print('Message also contained a title: ${message.notification!.title}');
      print('Message also contained a body: ${message.notification!.body}');
      ;
      showxNotification(message);
    });

    flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onSelectNotification: notificationSelected);
    await flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onSelectNotification: (payload) async {});
  }

  Future<void> notificationSelected(String? payload) async {
    onNotifications(payload);
  }
}
