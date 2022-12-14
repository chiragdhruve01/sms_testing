// import 'package:flutter/material.dart';
// import 'package:sms/screens/homePage.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SMS',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sms/screens/homePage.dart';
import 'package:sms/screens/login_screen.dart';
import 'package:sms/screens/splash.dart';
import 'utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '../services/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FCMPushNotifications().init();

// await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        // textTheme: Theme.of(context).textTheme.apply(
        //       bodyColor: kPrimaryColor,
        //       fontFamily: 'Montserrat',
        //     ),
      ),
      home: Splash(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:sms/Screens/login_screen.dart';
// import './Screens/signup_screen.dart';
// import './Screens/welcome_screen.dart';
// import './Models/auth.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: WelcomeScreen(),
//       routes: {
//         WelcomeScreen.routeName: (context) => WelcomeScreen(),
//         SignupScreen.routeName: (context) => SignupScreen(),
//         LoginScreen.routeName: (context) => LoginScreen(),
//       },
//     );
//   }
// }
