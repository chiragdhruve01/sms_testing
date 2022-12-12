// import 'package:banking_prokit/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sms/screens/login_screen.dart';

class SMSMenu extends StatefulWidget {
  static var tag = "/SMSMenu";

  @override
  _SMSMenuState createState() => _SMSMenuState();
}

class _SMSMenuState extends State<SMSMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0x44000000),
          leading: BackButton(color: Colors.black)),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              10.height,
              Text("Profile", style: boldTextStyle(size: 32)),
              16.height,
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage("assets/logo/two.jpg"),
                        radius: 40),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        5.height,
                        Text("Chirag D", style: boldTextStyle(size: 18)),
                        5.height,
                        Text("(132) 451-1548",
                            style: primaryTextStyle(color: Colors.orange)),
                        5.height,
                        Text("Gateway MD", style: secondaryTextStyle()),
                      ],
                    ).expand()
                  ],
                ),
              ),
              16.height,
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
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
                          Icon(Icons.keyboard_arrow_right, color: Colors.black),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
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
                          Icon(Icons.keyboard_arrow_right, color: Colors.black),
                        ],
                      ),
                    ).onTap(() {}),
                  ],
                ),
              ),
              16.height,
              Container(
                padding: EdgeInsets.all(8),
                decoration: boxDecorationWithShadow(
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: context.cardColor,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
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
                          Icon(Icons.keyboard_arrow_right, color: Colors.black),
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
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.pink[100],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        16.height,
        Text("Confirm Log Out ?", style: primaryTextStyle(size: 18)).onTap(() {
          finish(context);
        }).paddingOnly(top: 8, bottom: 8),
        Divider(height: 10, thickness: 1.0, color: Colors.grey),
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
