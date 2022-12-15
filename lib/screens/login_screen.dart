import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth.dart';
// import 'successful_screen.dart';
import 'package:sms/screens/successful_screen.dart';

// import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final Auth authService = Auth();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Login')),
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
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
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
            fit: BoxFit.fill,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 250),
                    userInput(
                        emailController, 'Email', TextInputType.emailAddress),
                    userInput(passwordController, 'Password',
                        TextInputType.visiblePassword),
                    Container(
                      height: 55,
                      padding:
                          const EdgeInsets.only(top: 5, left: 70, right: 70),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () async {
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
                                    builder: (ctx) => SuccessfulScreen()));
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text('Forgot password ?',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )),
                    ),
                    /*
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          login(Icons.add),
                          login(Icons.book_online),
                        ],
                      ),
                    ),
                    Divider(thickness: 0, color: Colors.white),
                  */
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
