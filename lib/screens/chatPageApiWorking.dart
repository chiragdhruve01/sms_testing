import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:sms/services/auth_service.dart';
import 'package:sms/utils/constants.dart';
import 'package:intl/intl.dart';

// import '../models/chatusersmodels.dart';
import '../models/chat.dart';
// ignore: unused_import
import '../services/notification.dart';
import '../widgets/conversationListAPI.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<Countuser>> countuser;
  List<Countuser>? chatUsers = [];
  dynamic newtoken = "";
  dynamic user;
  static UserDetails userDetails = UserDetails();
  final _channel = WebSocketChannel.connect(
    Uri.parse(wsprotocol + '://' + wsdomain + wsurlchat + "3/1/"),
  );
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    // countuser = getEmployeeList();
    getEmployeeList();
    websocket();
    // Constants.websocketController.listen((latestEvent) {
    // use latestEvent data here.
    // });
    // getDeviceToken();
  }

  getDeviceToken() async {
    String? deviceToken = await FCMPushNotifications().getDeviceToken();
    print("deviceToken" + deviceToken.toString());
  }

  websocket() async {
    if (Constants.websocketconnection == false) {
      print("Web Socket Connected");
      Constants.websocket = _channel;
      _channel.stream.listen((message) {
        var msg = jsonDecode(message);
        if (Constants.roomid != '') {
          Constants.websocketController.add(msg);
        } else {
          print("okay msg received" + msg.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.pink[200],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              content: Row(
                children: <Widget>[
                  const Image(
                      width: 100,
                      height: 100,
                      image: AssetImage("assets/logo/two.jpg")),
                  SizedBox(width: 20),
                  Text(msg['message']),
                ],
              ),
              action: SnackBarAction(
                textColor: Colors.orange,
                label: 'okay',
                onPressed: () {},
              ),
            ),
          );
          getEmployeeList();
        }
      });
      Constants.websocketconnection = true;
    }
  }

  @override
  void dispose() {
    print("********** close connenction **********");
    Constants.websocketController.close();
    _channel.sink.close();
    super.dispose();
  }

  getEmployeeList() async {
    String token = await authService.getPrefs();
    String accessToken = await authService.getAccessToken();
    dynamic url;
    user = await authService.getUserDetails(token);
    userDetails = UserDetails.fromJson(user);
    if (userDetails.data!.userType == 'superadmin') {
      url = Uri.http(urlLogindomain, '${superAdminMsg}${token}');
    } else {
      url = Uri.http(urlLogindomain, '${usergetmsg}${token}');
    }
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $accessToken'});
    final jsonData = jsonDecode(response.body);
    final chatData = Chat.fromJson(jsonData);
    chatUsers = chatData.countuser!;
    print('DATA ==== ' + chatUsers!.length.toString());
    setState(() {
      chatUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //  if (snapshot.hasData) {
            //       final data = jsonDecode(snapshot.data);
            //       print("data" + data.toString());
            //       return Text(data['message'].toString());
            //     } else {
            //       return Text('');
            //     }
            //   },
            // ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.60,
                      child: Text(
                        userDetails.data != null
                            ? userDetails.data!.company!.companyName! +
                                " \n" +
                                userDetails.data!.company!.contactPhone!
                            : "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          // fontSize: width * 0.025,
                          fontSize: kIsWeb ? width * 0.019 : width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(width * 0.01),
                      // height: height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            onTap: () => (Theme.of(context).platform ==
                                        TargetPlatform.android ||
                                    Theme.of(context).platform ==
                                        TargetPlatform.iOS)
                                ? FCMPushNotifications().showNotification(
                                    title: 'Death',
                                    body: 'Beautiful',
                                  )
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.orange,
                                      behavior: SnackBarBehavior.floating,
                                      content: Row(
                                        children: <Widget>[
                                          Image(
                                              width: width * .1,
                                              height: height * .1,
                                              image: AssetImage(
                                                  "assets/logo/two.jpg")),
                                          Text('toast' + ". " + 'message'),
                                        ],
                                      ),
                                      action: SnackBarAction(
                                        label: 'Action',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SMSMenu()));

                            child: Text(
                              "Add New",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(2),
                // padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
            ),
            //  FutureBuilder<List<Autogenerated>>(
            //     future: countuser,
            //     builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
            //         ? CircularProgressIndicator()
            //         : snapshot.hasData
            //             ? ListView.builder(
            //   itemCount: snapshot.data!.length,
            //   shrinkWrap: true,
            //   padding: EdgeInsets.only(top: 16),
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) {
            //     // return ConversationAPIList(
            //     //   contact: snapshot.data![index].contact,
            //     //   messageText: countuser[index]['messageText'],
            //     //   image: context.image!,
            //     //   time: countuser[index]['time'],
            //     //   isMessageRead: (index == 0 || index == 3) ? true : false,
            //     // );
            //   },
            // ),
            //             : Container(
            //                 // empty widget
            //                 ),

            // ),
            ListView.builder(
              itemCount: chatUsers!.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // return ListTile(
                //     title: Text(
                //   chatUsers![index].contact!.toString(),
                // ));
                dynamic test = chatUsers![index].date!.toLocal();
                return ConversationAPIList(
                  contact: chatUsers![index].contact,
                  date: DateFormat('E, d MMM, yyyy \n h:mm a').format(test),
                  firstName: chatUsers![index].firstName != null
                      ? chatUsers![index].firstName!
                      : '',
                  id: chatUsers![index].id,
                  image: chatUsers![index].image,
                  lastName: chatUsers![index].lastName != null
                      ? chatUsers![index].lastName!
                      : '',
                  room: chatUsers![index].room,
                  total: chatUsers![index].total,
                  unread: chatUsers![index].unread,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
