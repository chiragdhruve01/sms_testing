import 'package:flutter/material.dart';

import '../screens/chatDetailPage.dart';

class ConversationAPIList extends StatefulWidget {
  int? unread;
  int? total;
  String? contact;
  String? firstName;
  String? lastName;
  String? image;
  String? date;
  int? id;
  String? room;

  ConversationAPIList({
    @required this.unread,
    @required this.total,
    @required this.contact,
    @required this.firstName,
    @required this.lastName,
    @required this.image,
    @required this.date,
    @required this.id,
    @required this.room,
  });
  @override
  _ConversationAPIList createState() => _ConversationAPIList();
}

class _ConversationAPIList extends State<ConversationAPIList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // var room = context;
        // print("value" + context);
        print(widget.room);
        print(widget.contact);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(room: widget.room!);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: widget.image != ""
                        ? NetworkImage(
                            "http://172.31.199.45:8000" + widget.image!)
                        : NetworkImage(
                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.firstName!.isEmpty || widget.lastName!.isEmpty
                              ? Text(
                                  widget.contact!,
                                  style: TextStyle(fontSize: 16),
                                )
                              : Text(
                                  widget.firstName! + ' ' + widget.lastName!,
                                  style: TextStyle(fontSize: 16),
                                ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.total!.toString(),
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.date!,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
