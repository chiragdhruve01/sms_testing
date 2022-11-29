import 'package:http/http.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

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
      print("response ${data}");
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

  Future register(data) async {
    var res = await post(Uri.parse('${avdbaseUrl}gwmsignup'), body: data);
    return res;
  }
}
