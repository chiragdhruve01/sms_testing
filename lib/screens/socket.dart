import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class SocketPage extends StatefulWidget {
  WebSocketChannel channel = IOWebSocketChannel.connect(
      "ws://172.31.199.45:8000/ws/notify/b0343af1-587e-4084-b62e-4fd91ec4edbb");
  WebSocketChannel newchannel =
      IOWebSocketChannel.connect("ws://172.31.199.45:8000/ws/chat/3/1/");

  @override
  SocketPageState createState() {
    return SocketPageState();
  }
}

class SocketPageState extends State<SocketPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Socket"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Send any message to the server"),
                    controller: _controller,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Send any message to the server2"),
                    controller: _controller1,
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        sendData();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text("Send Server 1",
                            style: Theme.of(context).textTheme.button),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        sendDataServer2();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text("Send Server 2",
                            style: Theme.of(context).textTheme.button),
                      ),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                print("snapshot.hasData" + snapshot.data.toString());
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      snapshot.hasData ? '${snapshot.data}' : '1st server'),
                );
              },
            ),
            StreamBuilder(
              stream: widget.newchannel.stream,
              builder: (context, snapshot) {
                print("snapshot.hasData" + snapshot.data.toString());
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      snapshot.hasData ? '${snapshot.data}' : '2nd server'),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: sendData,
      ),
    );
  }

  void sendData() {
    print("sendDataServer1");
    if (_controller.text.isNotEmpty) {
      var data = {
        "command": "new_message",
        "message": _controller.text,
        "from": "+154547878",
        "sender": "+4545454",
        "receiver": "+ASDASDd"
      };
      var jsonString = json.encode(data);
      print("data" + data.toString());
      widget.channel.sink.add(jsonString);
    }
  }

  void sendDataServer2() {
    print("sendDataServer2");
    if (_controller1.text.isNotEmpty) {
      var data = {
        "type": "chat_message",
        "userid": 3,
        "image": "",
        "message": _controller1.text,
        'phone': "2812416990",
        'contacts': "",
        "room": "34636828702812416990"
      };
      var jsonString = json.encode(data);
      widget.newchannel.sink.add(jsonString);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    widget.newchannel.sink.close();
    super.dispose();
  }
}
