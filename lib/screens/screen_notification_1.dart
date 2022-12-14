import 'package:flutter/material.dart';
import 'package:sms/screens/screen_notification_2.dart';
import 'package:sms/services/notifications.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  late final NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
    super.initState();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        print("payload" + payload.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MySecondScreen(payload: payload)));
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.red, Colors.blue],
            ),
          ),
        ),
        title: const Text("JustWater"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xffe16b5c),
              Color(0xffffb56b),
              Color(0xfff39060),
              Color(0xffffb56b),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Image.asset("assets/logo/3.jpg", scale: 0.6),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await notificationService.showLocalNotification(
                          id: 0,
                          title: "Drink Water",
                          body: "Time to drink some water!",
                          payload: "You just took water! Huurray!");
                    },
                    child: const Text("Drink Now")),
                ElevatedButton(
                    onPressed: () async {
                      await notificationService.showScheduledLocalNotification(
                          id: 1,
                          title: "Drink Water",
                          body: "Time to drink some water!",
                          payload: "You just took water! Huurray!",
                          seconds: 2);
                    },
                    child: const Text("Schedule Drink "))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await notificationService.showGroupedNotifications(
                          title: "Drink Water");
                    },
                    child: const Text("Drink grouped")),
                ElevatedButton(
                  onPressed: () {
                    notificationService.cancelAllNotifications();
                  },
                  child: const Text(
                    "Cancel All Drinks",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
