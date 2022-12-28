import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../extra/login_screen2.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';

  /*
  Widget routeButton(Color buttonColor, String title, Color textColor, BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: buttonColor,
        onPressed: () => context,
        child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor,),),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0x44000000),
          leading: BackButton(color: Colors.black)),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://raw.githubusercontent.com/tommybarral/Sign-in-up/master/images/original.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: Column(
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 6.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.indigo.shade800),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => LoginScreen())),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 90,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 6.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.indigo.shade800),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => SignupScreen())),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 90,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 6.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.indigo.shade800),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => LoginTestScreen())),
                        child: Text(
                          'Login Screen',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 90,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 6.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.indigo.shade800),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => SignupScreen())),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
