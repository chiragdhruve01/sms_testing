import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/extra/login_screen2.dart';
import 'package:sms/screens/chatPageApiWorking.dart';
import 'package:sms/screens/signup_screen.dart';
import '../models/auth.dart';
// import 'successful_screen.dart';
import 'package:sms/extra/successful_screen.dart';
import 'package:flutter/gestures.dart';

// import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Auth authService = Auth();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  var defaultponbool = true;
  Widget login(IconData icon, String name, sad) {
    return Container(
      height: 50,
      width: 165,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => sad));
              },
              child: Text(name,
                  style: TextStyle(color: Color.fromARGB(255, 19, 19, 19)))),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: userInput,
          autocorrect: false,
          obscureText: hintTitle == 'Password' ? defaultponbool : false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration(
            hintText: hintTitle,
            suffixIcon: hintTitle == 'Email'
                ? Icon(
                    Icons.email,
                  )
                : defaultponbool
                    ? IconButton(
                        splashColor: Colors.redAccent,
                        splashRadius: 5.0,
                        icon: Icon(
                          Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            defaultponbool = false;
                          });
                        },
                      )
                    : IconButton(
                        splashColor: Colors.orange,
                        splashRadius: 5.0,
                        icon: Icon(
                          Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            defaultponbool = true;
                          });
                        },
                      ),
            hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Future<void> savePrefs(String token, String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('accessToken', accessToken);
  }

  Future<String> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')!;
  }

  Future<String> getaccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://images.unsplash.com/photo-1453306458620-5bbef13a5bca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              // width: double.infinity,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        'assets/logo/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    userInput(
                        emailController, 'Email', TextInputType.emailAddress),
                    userInput(passwordController, 'Password',
                        TextInputType.visiblePassword),
                    Container(
                      height: MediaQuery.of(context).size.height * .1,
                      padding:
                          const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () async {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            emailController.text.isEmpty
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Email is Required'),
                                        backgroundColor: Colors.red))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Password is Required'),
                                        backgroundColor: Colors.red));
                            return;
                          }
                          var res = await authService.login(
                              emailController.text, passwordController.text);
                          // print("res" + res.toString());
                          print(jsonDecode(res.body));
                          // var ress = await authService.getLoginUser();
                          switch (res.statusCode) {
                            case 200:
                              var data = jsonDecode(res.body);
                              print(data['error']);
                              print(data['success']);
                              print('API Token = ' + data['data']['uuid']);
                              await savePrefs(data['data']['uuid'],
                                  data['data']['accessToken']);
                              String token = await getPrefs();
                              print('Pref Token = ' + token);
                              if (data.runtimeType == String) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(data),
                                        backgroundColor: Colors.red));
                                break;
                              }
                              // print("data['error'] :: ${data?['error'] ?? ''}");
                              if (data['error'] != '' &&
                                  data['error'] != null) {
                                print("error");
                                var ans = data?['error'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(ans),
                                        backgroundColor: Colors.red[800]));
                              } else {
                                var daa = data!['data'];
                                print('login :: ${daa}');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Login Successfully ${daa['firstName']} ${daa['lastName']}"),
                                  backgroundColor: Colors.deepOrange,
                                ));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ChatPage()));
                              }
                              break;
                            case 201:
                              print("stattus code" + res.statusCode.toString());
                              var data = jsonDecode(res.body);
                              print("error" + data['error']);
                              print("success" + data['success']);
                              if (data['error'] != '' &&
                                  data['error'] != null) {
                                var ans = data?['error'];
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(ans),
                                        backgroundColor: Colors.red[800]));
                              }
                              break;
                            default:
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Wrong email or password!"),
                                      backgroundColor: Colors.red));
                              break;
                          }
                        },

                        // onPressed: () async {
                        //   print(emailController.text);
                        //   print(passwordController.text);
                        //   var res = await authService.login(
                        //       emailController.text, passwordController.text);
                        //   print("res" + res.toString());
                        //   // Provider.of<Auth>(context, listen: false).login(
                        //   //     emailController.text, passwordController.text);
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (ctx) => SuccessfulScreen()));
                        // },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // Center(
                    //   child: Text.rich(
                    //     TextSpan(text: 'Forgot password ? \n', children: [
                    //       TextSpan(
                    //         text: 'Login ',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 15,
                    //             color: Color(0xffEE7B23)),
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () => Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) => LoginTestScreen())),
                    //       ),
                    //       TextSpan(
                    //         text: 'Signup',
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () => Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) => SignupScreen())),
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.w700,
                    //           color: Color(0xffEE7B23),
                    //         ),
                    //       ),
                    //     ]),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          login(Icons.add, 'Sign Up', SignupScreen()),
                          login(Icons.book_online, 'Forget Password', Second()),
                        ],
                      ),
                    ),
                    // Divider(thickness: 0, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
