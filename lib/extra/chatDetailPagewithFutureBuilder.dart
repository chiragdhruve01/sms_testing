import 'dart:convert';
// ignore: unused_import
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sms/utils/constants.dart';
import '../models/chatmessagemodel.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key, required this.room}) : super(key: key);
  final String room;
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(room: room);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<dynamic>? messages = [];

  @override
  void initState() {
    // getRoomUserMessages(this.room);
    super.initState();
    if (this.room.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Welcome Chats for " + this.room),
          backgroundColor: Colors.deepOrange,
        ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No Data Found"),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }

  Future<List> getRoomUserMessages(room) async {
    try {
      final url = Uri.http(urlLogindomain, '${usergetroommsg}${room}');
      final response = await http.get(url);
      var data = jsonDecode(response.body);
      return data['chats'];
    } catch (e) {
      return Future.error(e);
    }
  }

  // getRoomUserMessages(room) async {
  //   final url = Uri.http(urlLogindomain, '${usergetroommsg}${room}');
  //   final response = await http.get(url);
  //   final jsonData = jsonDecode(response.body);
  //   messages = [jsonData];
  //   setState(() {});
  // }

  // getRoomUserMessages();
  _ChatDetailPageState({required this.room});
  final String room;
  // print(room);
  // List<ChatMessage> messages = [
  //   ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  //   ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  //   ChatMessage(
  //       messageContent: "Hey Kriss, I am doing fine dude. wbu?",
  //       messageType: "sender"),
  //   ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   ChatMessage(
  //       messageContent: "Is there any thing wrong?", messageType: "sender"),
  // ];
  // late Uint8List _bytes = base64Decode(imsf.split(',').last);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  // backgroundImage: MemoryImage(_bytes),
                  backgroundImage: NetworkImage(
                      "http://172.31.199.45:8000/media/user/pexels4.jpg"),
                  backgroundColor: Colors.transparent,
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kriss Benwat",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List>(
                  future: getRoomUserMessages(this.room),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                                tileColor: Colors.grey[300],
                                title: Text(
                                  (snapshot.data![i]['contact']['firstName'] !=
                                          null)
                                      ? snapshot.data![i]['contact']
                                              ['firstName'] +
                                          " " +
                                          snapshot.data![i]['contact']
                                              ['lastName']
                                      : snapshot.data![i]['contact']
                                              ['contactPhone'] +
                                          " " +
                                          snapshot.data![i]['contact']
                                              ['formatcontact'],
                                ),
                                subtitle: Text(
                                  snapshot.data![i]['text'],
                                  style: const TextStyle(
                                      backgroundColor: Colors.orange,
                                      color: Colors.white),
                                ),
                                trailing: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: snapshot.data![i]['sender'] == null ||
                                          (snapshot.data![i]['sender']
                                                      ['image'] ==
                                                  "" ||
                                              snapshot.data![i]['sender']
                                                      ['image'] ==
                                                  null)
                                      ? const Image(
                                          image:
                                              AssetImage('assets/logo/two.jpg'),
                                        )
                                      : Image(
                                          image: NetworkImage(
                                            'http://172.31.199.45:8000' +
                                                snapshot.data![i]['sender']
                                                    ['image'],
                                          ),
                                        ),
                                )),
                          );
                        },
                      );
                    } else {
                      return const Center(
                          child: ListTile(
                              title: Text('',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0,
                                    fontFamily: 'Roboto',
                                  )),
                              leading: SizedBox(
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )));
                    }
                  }),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
