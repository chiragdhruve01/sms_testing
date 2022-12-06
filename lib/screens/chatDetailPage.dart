import 'dart:convert';
// ignore: unused_import
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sms/screens/chatPageApiWorking.dart';
import 'package:sms/utils/constants.dart';
import '../models/chatmessagemodel.dart';
import 'package:sms/utils/constants.dart' as contants;

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key, required this.room}) : super(key: key);
  final String room;

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(room: room);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<dynamic>? messages = [];
  // late Map<String, dynamic> answer;

  @override
  void initState() {
    getRoomUserMessages(this.room);
    super.initState();
    if (this.room.isNotEmpty) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Welcome"),
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
      // answer = jsonDecode(response.body);
      messages = data['chats'];
      setState(() => messages = data['chats']);

      return data['chats'];
    } catch (e) {
      return Future.error(e);
    }
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                    // Navigator.pop(context);
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
                          '${contants.urlLogin}' +
                              messages![0]['contact']['image'],
                        )
                      : AssetImage('assets/logo/two.jpg') as ImageProvider,
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
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
                const Icon(
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
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: messages!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages![index]['sender'] != null
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages![index]['sender'] != null
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages![index]['text'],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
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
                      const Expanded(
                        child: TextField(
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
                        onPressed: () {},
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
