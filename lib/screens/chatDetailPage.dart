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
    getRoomUserMessages(this.room);
    super.initState();
    if (this.room.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Hello msg came" + this.room),
          backgroundColor: Colors.deepOrange,
        ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Hello no msg"),
        backgroundColor: Colors.deepOrange,
      ));
    }
  }

  getRoomUserMessages(room) async {
    final url = Uri.http(urlLogindomain, '${usergetroommsg}${room}');
    // print("url getRoomUserMessages" + url.toString());
    final response = await http.get(url);
    // print("response" + response.body.toString());
    // final json = "[" + response.body + "]";

    final jsonData = jsonDecode(response.body);
    print("response.body" + jsonData[0]);
    print("response.body" + jsonData.length.toString());
    messages = [jsonData];
    // print("jsonData" + jsonData['chats']);
    // print("jsonData"+jsonData.chats);
    // print("jsonData" + jsonData.toString());
    // print('DATA ==== ' + chatUsers!.length.toString());
    setState(() {});
  }

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
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages?.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              print("messages!.length" + messages!.length.toString());
              // print("index" + index.toString());
              // print("messages![index]." + messages![index]['chats'][index]['text'].toString());
              // print("messages![index]." + messages![index]['chats'].toString());
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  // alignment: (messages[index].messageType == "receiver"
                  //     ? Alignment.topLeft
                  //     : Alignment.topRight),
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[200],
                      // color: (messages[index].messageType == "receiver"
                      //     ? Colors.grey.shade200
                      //     : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages![index]['chats'][index]['text']!,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
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
      ),
    );
  }
}
