import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sms/screens/homePage.dart';
import 'package:sms/screens/login_screen.dart';
import 'dart:io' show Platform;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

Future<String> getPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  bool CheckValue = prefs.containsKey('token');
  print("CheckValue " + CheckValue.toString());
  var token = "";
  if (CheckValue == true) {
    token = prefs.getString('token')!;
    print("okay token " + prefs.getString('token')!);
  }
  print("token: " + token);
  return token;
}

class _SplashState extends State<Splash> {
  dynamic newtoken = "";

  void checkToken() async {
    print("check token");
    // if (Platform.isWindows) {
    // } else if (Platform.isIOS) {
    // }
    String tokens = await getPrefs();
    print("tokens" + tokens);
    // var tokens = await storage.read(key: "token");
    newtoken = tokens;
  }

  void initState() {
    super.initState();
    checkToken();
    startTime();
  }

  startTime() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    setState(
      () {
        print("newtoken" + newtoken);
        if (newtoken == null || newtoken == "") {
          LoginScreen().launch(context);
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePage()));
          // const HomeScreen(errMsg: '').launch(context);
          // Dashboard().launch(context);
        }
        // finish(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                // color: Colors.blue,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color(0xff1f005c),
                    Color(0xff5b0060),
                    Color(0xff870160),
                    Color(0xffac255e),
                    Color(0xffca485c),
                    Color(0xffe16b5c),
                    Color(0xfff39060),
                    Color(0xffffb56b),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    width: 250,
                    height: 250,
                    image: AssetImage('assets/logo/one.png'),
                  ),
                  // Text(gateway_app_Name,style:boldTextStyle(color: gateway_TextColorWhite, size: 30),).paddingOnly(bottom: spacing_standard),
                  Text('SMS',
                          style:
                              boldTextStyle(color: Colors.white, size: 14))
                      .paddingOnly(top: 20.00),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
