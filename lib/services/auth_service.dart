// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sms/utils/constants.dart';

class Album {
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  const Album({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'] ?? "",
    );
  }
}

class AuthService {
  var baseUrl = "http://172.31.199.45:8000/";
  var avdbaseUrl = "http://10.0.2.2:8000/";
  var liveUrl =
      "https://messaging.care/getuserMsg/d1c2b97e-e9b2-40ef-8de9-179c987651bd";
  // var client = http.Client();

  Future<Response> login(String username, String password) async {
    var res = await post(Uri.parse('${baseUrl}user/userlogin'),
        body: {"email": username, "password": password});
    return res;
  }

  Future<Album> getLoggedInUser(String token) async {
    try {
      if (token != "") {
        var res = await get(Uri.parse('${avdbaseUrl}accTokengwm/$token'));
        if (res.statusCode == 200) {
          return Album.fromJson(jsonDecode(res.body));
        } else {
          return Future.error("server error");
        }
      } else {
        return Future.error("no token");
      }
    } catch (e) {
      return Future.error(e);
    }
    // var res = await get(Uri.parse('${avdbaseUrl}accTokengi/$token'));
    // return Album.fromJson(jsonDecode(res.body));
    // return res.body;
  }

  Future<List> getUserRoomChats(String token) async {
    try {
      var res = await get(Uri.parse('${avdbaseUrl}accTokengwm/$token'));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> getUsers() async {
    try {
      var response = await get(Uri.parse('${liveUrl}'));
      var data = jsonDecode(response.body);
      // print("response ${data['serializer']}");
      if (response.statusCode == 200) {
        return data['serializer'];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  getUserDetails(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('accessToken')!;
      var response = await get(Uri.parse('${urlLogin}${accTokenuser}$token'),
          headers: {'Authorization': 'Bearer $accessToken'});

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  // Future<Response> login(String username, String password) async {
  //   try {
  //     var response = await post(Uri.parse("http://localhost:8000/gilogin"),
  //         body: {"email": username, "password": password});
  //     print("response ${response.statusCode}");
  //     print("response ${response.body}");
  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body);
  //     } else {
  //       return Future.error("server error");
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    bool CheckValue = prefs.containsKey('accessToken');
    var accessToken = "";
    if (CheckValue == true) {
      accessToken = prefs.getString('accessToken')!;
    }
    return accessToken;
  }

  Future<String> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    bool CheckValue = prefs.containsKey('token');
    var token = "";
    if (CheckValue == true) {
      token = prefs.getString('token')!;
    }
    return token;
  }

  Future register(data) async {
    var res = await post(Uri.parse('${avdbaseUrl}gwmsignup'), body: data);
    return res;
  }
}
