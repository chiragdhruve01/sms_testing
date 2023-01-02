import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Colors
const kBackgroundColor = Color(0xFFD2FFF4);
const kPrimaryColor = Color(0xFF2D5D70);
const kSecondaryColor = Color(0xFF265DAB);
// TODO Implement this library.
const urlAuth = "hello";
const localurlLogin = "http://172.31.199.45:8000";
const urlLogin = "http://172.31.199.45:8000";
const urlLogindomain = "172.31.199.45:8000";

// const urlLogin = "http://10.0.2.2:8000";
// const urlLogin = "http://localhost:8000";
const apiKey = "hello";

// routes
const usergetmsg = "/getuserMsg/";
const superAdminMsg = "/superAdminMsg/";
const accTokenuser = "/user/getUserAppDetails/";
const usergetroommsg = "/getRoomChats/";
const websocket = "/getRoomChats/";
const wsprotocol = "ws";
const wsdomain = "172.31.199.45:8000";
const wsurlchat = "/ws/chat/";
const wsurlnotify = "/ws/notify/";

class Constants {
  static String userid = '';
  static String roomid = '';
  static String companyid = '';
  static WebSocketChannel? websocket;
  static String accessToken = '';
  static const String profile = '/user/getUserAppDetails/';
  static String updateProfile = '/user/AppEditUser';
  static var websocketconnection = false;
  static var websocketController = BehaviorSubject<dynamic>();
}
