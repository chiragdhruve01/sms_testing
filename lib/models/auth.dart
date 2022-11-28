// import 'package:flutter/foundation.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../utils/constants.dart';

class Auth {
  // Future<Response> signup(String? email, String? password) async {
  //   final url = Uri.parse('$urlAuth' + '$apiKey');
  //   final response = await http.post(url,
  //       body: {
  //         'email': email,
  //         'password': password,
  //         'returnSecureToken': true,
  //       });
  //   print(json.decode(response.body));
  // }

  Future<Response> loginsl(String username, String password) async {
    var res = await post(Uri.parse('$urlLogin' + "/user/userlogin"),
        body: {"email": username, "password": password});
    return res;
  }

  Future<Response> login(String email, String password) async {
      // final url = Uri.http('172.31.199.45:8000',
      //   '/getuserMsg/b0343af1-587e-4084-b62e-4fd91ec4edbb');
    // final response = await http.get(url);
    final url = Uri.parse('$urlLogin' + "/user/userlogin");
    final response = await post(url,
        body: {
          'email': email,
          'password': password,
        });
    print(json.decode(response.body));
    return response;
  }

  Future<Response> getUsers() async {
    final url = Uri.parse('https://messaging.care/getuserMsg/d1c2b97e-e9b2-40ef-8de9-179c987651bd');
    final response = await get(url);
    print("response ${response}");

    return response;
    print(json.decode(response.body));
  }

  // Future<List> getUsers() async {
  //   try {
  //     var response = await get(Uri.parse(
  //         'https://messaging.care/getuserMsg/d1c2b97e-e9b2-40ef-8de9-179c987651bd'));
  //     print("response ${response}");
  //     var data = jsonDecode(response.body);
  //     print("response ${data}");
  //     // print("response ${data['serializer']}");
  //     if (response.statusCode == 200) {
  //       return data['serializer'];
  //     } else {
  //       return Future.error("server error");
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
}
