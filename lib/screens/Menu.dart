// import 'package:banking_prokit/main.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sms/screens/login_screen.dart';
import 'package:sms/screens/screen_notification_1.dart';
import 'package:sms/screens/welcome_screen.dart';
import 'package:sms/utils/constants.dart' as contants;
import '../models/chat.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';

class SMSMenu extends StatefulWidget {
  static var tag = "/SMSMenu";

  @override
  _SMSMenuState createState() => _SMSMenuState();
}

class _SMSMenuState extends State<SMSMenu> {
  get height => MediaQuery.of(context).size.height;
  get width => MediaQuery.of(context).size.width;
  dynamic user;

  static UserDetails userData = UserDetails();

  AuthService authservice = AuthService();

  @override
  void initState() {
    super.initState();
    getuserDetails();
  }

  Future<void> getuserDetails() async {
    try {
      String token = await authservice.getPrefs();
      String accessToken = await authservice.getAccessToken();
      dynamic url;
      user = await authservice.getUserDetails(token);
      userData = UserDetails.fromJson(user);
      setState(() {});
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Color(0x44000000),
      //     leading: BackButton(color: Colors.black)),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              10.height,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 0),
                child: Text("Profile", style: boldTextStyle(size: 32)),
              ),
              10.height,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: (userData.data != null &&
                                userData.data!.image != null)
                            ? NetworkImage(
                                contants.urlLogin + userData.data!.image!)
                            : const AssetImage("assets/logo/two.jpg")
                                as ImageProvider,
                        radius: 40),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        5.height,
                        Text(
                            userData.data != null
                                ? userData.data!.firstName! +
                                    " " +
                                    userData.data!.lastName!
                                : "",
                            style: boldTextStyle(size: 18)),
                        5.height,
                        Text(userData.data != null ? userData.data!.email! : "",
                            style: secondaryTextStyle(size: 16)),
                        5.height,
                        Text(
                            userData.data != null
                                ? userData.data!.company!.companyName! +
                                    " \n" +
                                    userData.data!.company!.contactPhone!
                                : "",
                            style:
                                boldTextStyle(color: Colors.orange, size: 16)),
                      ],
                    ).expand()
                  ],
                ),
              ),
              16.height,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('assets/logo/two.jpg',
                                  height: 20, width: 20),
                              16.width,
                              Text("Settings", style: primaryTextStyle()),
                            ],
                          ).expand(),
                          const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('assets/logo/two.jpg',
                                  // color: Color(0xFFE7586A),
                                  height: 20,
                                  width: 20),
                              16.width,
                              Text("Change Password",
                                  style: primaryTextStyle()),
                            ],
                          ).expand(),
                          const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black),
                        ],
                      ),
                    ).onTap(() {}),
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('assets/logo/two.jpg',
                                  // color: Color(0xFFE7586A),
                                  height: 20,
                                  width: 20),
                              16.width,
                              Text("Notification Screen",
                                  style: primaryTextStyle()),
                            ],
                          ).expand(),
                          const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black),
                        ],
                      ),
                    ).onTap(() {
                      (Theme.of(context).platform == TargetPlatform.android ||
                              Theme.of(context).platform == TargetPlatform.iOS)
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NotifyScreen()))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                behavior: SnackBarBehavior.floating,
                                content: Row(
                                  children: <Widget>[
                                    Image(
                                        width: width * .1,
                                        height: height * .1,
                                        image: const AssetImage(
                                            "assets/logo/two.jpg")),
                                    const Text(
                                        'Under Construction, Please Wait'),
                                  ],
                                ),
                                action: SnackBarAction(
                                  textColor: Colors.pink,
                                  label: 'okay',
                                  onPressed: () {},
                                ),
                              ),
                            );
                    }),
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('assets/logo/two.jpg',
                                  // color: Color(0xFFE7586A),
                                  height: 20,
                                  width: 20),
                              16.width,
                              Text("Extra Login / Signup Screen",
                                  style: primaryTextStyle()),
                            ],
                          ).expand(),
                          const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black),
                        ],
                      ),
                    ).onTap(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                      );
                    }),
                  ],
                ),
              ),
              16.height,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('assets/logo/two.jpg',
                                  // color: Color(0xFFE7586A),
                                  height: 20,
                                  width: 20),
                              16.width,
                              Text("Logout", style: primaryTextStyle()),
                            ],
                          ).expand(),
                          const Icon(Icons.keyboard_arrow_right,
                              color: Colors.black),
                        ],
                      ),
                    ).onTap(
                      () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.pink,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> removePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('accessToken');
    if (Constants.websocket != null) {
      Constants.websocket!.sink.close();
    }
    Constants.websocketconnection = false;
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.pink[100],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        const BoxShadow(
            color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        16.height,
        Text("Confirm Log Out ?", style: primaryTextStyle(size: 18)).onTap(() {
          finish(context);
        }).paddingOnly(top: 8, bottom: 8),
        const Divider(height: 10, thickness: 1.0, color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Cancel", style: primaryTextStyle(size: 18)).onTap(
              () {
                finish(context);
              },
            ).paddingRight(16),
            Container(width: 1.0, height: 40, color: Colors.orange).center(),
            Text("Logout",
                    style: primaryTextStyle(size: 18, color: Colors.pink))
                .onTap(
              () {
                removePrefs();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ).paddingLeft(16)
          ],
        ),
        16.height,
      ],
    ),
  );
}
