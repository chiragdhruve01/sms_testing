import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/utils.dart';

class FCMPushNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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

  Future<void> init({bool initScheduled = false}) async {
    var androidInitialize =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOSInitialize = IOSInitializationSettings();
    var initializeSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onSelectNotification: notificationSelected);
    await flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onSelectNotification: (payload) async {});
  }

  Future<void> notificationSelected(String? payload) async {
    onNotifications(payload);
  }
}
