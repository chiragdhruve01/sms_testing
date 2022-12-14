// ignore: file_names
import 'dart:async';
import 'dart:convert';
// ignore: unused_import
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sms/utils/constants.dart' as contants;
import '../services/auth_service.dart';
import '../utils/constants.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key, required this.room}) : super(key: key);
  final String room;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ChatDetailPageState createState() => _ChatDetailPageState(room: room);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<dynamic>? messages = [];
  var timer;
  final ScrollController scroll =
      ScrollController(initialScrollOffset: 500 * 100.0);
  bool showbtn = false;
  AuthService authservice = AuthService();
  final msgcontroller = TextEditingController();
  // late Map<String, dynamic> answer;
  _scrollToEnd() {
    setState(() {
      scroll.animateTo(
        scroll.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void initState() {
    getRoomUserMessages(room);
    super.initState();
    if (room.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Welcome"),
          backgroundColor: Colors.deepOrange,
        ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No Data Found"),
        backgroundColor: Colors.deepOrange,
      ));
    }
    Constants.websocketController.listen((latestEvent) {
      print("latestEvent for chat detail dart" + latestEvent.toString());
      print("web socket room " + latestEvent['room'].toString());
      print("current room " + room.toString());
      print("Constants.roomid in listener " + Constants.roomid.toString());
      if (latestEvent['room'] == Constants.roomid) {
        getRoomUserMessages(room);
      }
      // use latestEvent data here.
    });
    scroll.addListener(() {
      double showoffset = 10.0;
      if (scroll.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    print("********** close connenction **********");
    timer.cancel();
    timer; //clear the timer variable
    super.dispose();
  }

  Future<void> getRoomUserMessages(room) async {
    try {
      // Constants.roomid = room;
      String accessToken = await authservice.getAccessToken();
      // ignore: unnecessary_brace_in_string_interps
      final url = Uri.http(
          contants.urlLogindomain, '${contants.usergetroommsg}${room}');
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer $accessToken'});
      var data = jsonDecode(response.body);
      // answer = jsonDecode(response.body);
      messages = data['chats'];
      if (mounted) {
        setState(() {
          messages = data['chats'];
        });
      }

      // Future.delayed(Duration.zero, () {
      //   setState(() {
      //     if (scroll.hasClients) {
      //       scroll.animateTo(
      //         scroll.position.maxScrollExtent,
      //         duration: const Duration(
      //           milliseconds: 300,
      //         ),
      //         curve: Curves.easeOut,
      //       );
      //     }
      //   });
      // });

      timer = Timer(
          const Duration(
            seconds: 1,
          ), () {
        if (scroll.hasClients) {
          scroll.animateTo(
            scroll.position.maxScrollExtent + 200,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeOut,
          );
        }
      });

      // return data['chats'];
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> sendWebSocketMessage(String message) async {
    String token = await authservice.getPrefs();
    print("message" + message.toString());
    Constants.websocket!.sink.add(
      jsonEncode({
        'type': 'chat_message',
        'userid': token,
        'image': '',
        'imageName': '',
        'message': message,
        'phone': messages![0]['contact']['formatcontact'],
        'contacts': '',
        'room': room,
      }),
    );
    getRoomUserMessages(room);

    setState(() {});
  }

  _ChatDetailPageState({required this.room});
  final String room;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ChatPage()),
                    // );
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: messages!.isNotEmpty &&
                          messages![0]['contact']['image'] != null
                      ? NetworkImage(
                          contants.urlLogin + messages![0]['contact']['image'],
                        )
                      : const AssetImage('assets/logo/two.jpg')
                          as ImageProvider,
                  // backgroundImage: NetworkImage((messages!.isNotEmpty &&
                  //         messages![0]['contact']['image'] != null)
                  //     ? '${contants.urlLogin}' +
                  //         messages![0]['contact']['image']
                  //     : "http://172.31.199.45:8000/media/user/pexels4.jpg"),
                  backgroundColor: Colors.transparent,
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        messages!.isNotEmpty
                            ? (messages![0]['contact']['firstName'] == null ||
                                    messages![0]['contact']['lastName'] == null)
                                ? messages![0]['contact']['contactPhone']
                                : messages![0]['contact']['firstName'] +
                                    " " +
                                    messages![0]['contact']['lastName']
                            : "",
                        // messages!.isNotEmpty
                        //     ? messages![1]['receiver'] != null
                        //         ? "receiver not null"
                        //         : "receiver null"
                        //     : "is empty",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      // const SizedBox(
                      //   height: 6,
                      // ),
                      // Text(
                      //   "Online",
                      //   style: TextStyle(
                      //       color: Colors.grey.shade600, fontSize: 13),
                      // ),
                    ],
                  ),
                ),
                IconButton(
                  color: Colors.black54,
                  onPressed: () {
                    _scrollToEnd();
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(bottom: 60.0, left: 15),
            child: AnimatedOpacity(
              duration:
                  const Duration(milliseconds: 1000), //show/hide animation
              opacity:
                  showbtn ? 0.2 : 0.0, //set obacity to 1 on visible, or hide
              child: FloatingActionButton(
                heroTag: null,
                mini: true,
                tooltip: 'Scroll to top',
                onPressed: () {
                  scroll.animateTo(0,
                      duration: const Duration(
                          milliseconds: 500), //duration of scroll
                      curve: Curves.fastOutSlowIn //scroll type
                      );
                },
                child: const Icon(Icons.arrow_upward),
              ),
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(bottom: 60.0),
            child: AnimatedOpacity(
              duration:
                  const Duration(milliseconds: 1000), //show/hide animation
              opacity:
                  showbtn ? 0.2 : 0.0, //set obacity to 1 on visible, or hide
              child: FloatingActionButton(
                heroTag: null,
                mini: true,
                tooltip: 'Scroll to bottom',
                onPressed: () {
                  _scrollToEnd();
                },
                child: const Icon(Icons.arrow_drop_down),
                // backgroundColor: Colors.blue.shade100,
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  controller: scroll,
                  itemCount: messages!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    var date = DateTime.parse(messages![index]['created_at']);
                    var formattedDate =
                        DateFormat('E, d MMM h:mm a').format(date);
                    return Column(
                      children: [
                        Container(
                          padding: messages![index]['sender'] != null
                              ? const EdgeInsets.only(
                                  left: 14, right: 50, top: 10, bottom: 10)
                              : const EdgeInsets.only(
                                  left: 50, right: 14, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment:
                                messages![index]['sender'] != null
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                            children: [
                              messages![index]['sender'] != null
                                  ? CircleAvatar(
                                      backgroundImage: messages![index]
                                                      ['sender']
                                                  .isNotEmpty &&
                                              messages![index]['sender']
                                                      ['image'] !=
                                                  null
                                          ? NetworkImage(
                                              contants.urlLogin +
                                                  messages![index]['sender']
                                                      ['image'],
                                            )
                                          : const AssetImage(
                                                  'assets/logo/logo.png')
                                              as ImageProvider,
                                      backgroundColor: Colors.transparent,
                                      maxRadius: 20,
                                    )
                                  : Container(),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: (messages![index]['sender'] != null
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                                    borderRadius: messages![index]['sender'] !=
                                            null
                                        ? const BorderRadius.only(
                                            topRight: Radius.circular(18.0),
                                            bottomLeft: Radius.circular(18.0),
                                            bottomRight: Radius.circular(18.0),
                                          )
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18),
                                          ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        messages![index]['id'].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        messages![index]['text'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              // color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20),
                              //       color: (messages![index]['sender'] != null
                              //           ? Colors.grey.shade200
                              //           : Colors.blue[200]),
                              //     ),
                              //     padding: const EdgeInsets.all(16),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       mainAxisSize: MainAxisSize.max,
                              //       children: [
                              //         Text(
                              //           messages![index]['id'].toString(),
                              //           style: TextStyle(
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 15,
                              //           ),
                              //         ),
                              //         Text(
                              //           messages![index]['text'],
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontWeight: FontWeight.w400,
                              //             fontSize: 15,
                              //           ),
                              //         ),
                              //         Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.end,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.end,
                              //           mainAxisSize: MainAxisSize.max,
                              //           children: [
                              //             Text(
                              //               messages![index]['created_at'],
                              //               style: TextStyle(
                              //                 color: Colors.green,
                              //                 fontWeight: FontWeight.w500,
                              //                 fontSize: 15,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              messages![index]['sender'] == null
                                  ? CircleAvatar(
                                      backgroundImage: messages![index]
                                                      ['contact']
                                                  .isNotEmpty &&
                                              messages![index]['contact']
                                                      ['image'] !=
                                                  null
                                          ? NetworkImage(
                                              contants.urlLogin +
                                                  messages![index]['contact']
                                                      ['image'],
                                            )
                                          : const AssetImage(
                                                  'assets/logo/icon.png')
                                              as ImageProvider,
                                      backgroundColor: Colors.transparent,
                                      maxRadius: 20,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: msgcontroller,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          if (msgcontroller.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Message is Required'),
                                backgroundColor: Colors.orange));
                            return;
                          }
                          sendWebSocketMessage(msgcontroller.text);
                          msgcontroller.clear();
                        },
                        backgroundColor: Colors.blue,
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// CustomPaint(
//     painter: MessageBubble(
//     Colors.green,
//     ),
//     )

class MessageBubble extends CustomPainter {
  final Color bgColor;
  MessageBubble(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-10, 0);
    path.lineTo(0, 15);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
