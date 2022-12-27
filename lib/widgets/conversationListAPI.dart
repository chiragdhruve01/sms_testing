import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms/utils/constants.dart';

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
  get width => MediaQuery.of(context).size.width;
  get height => MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // var room = context;
        // print("value" + context);
        print(widget.room);
        print(widget.contact);
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(room: widget.room!),
          ),
        )
            .then((_) {
          print("back called so refresh again");
          ChatDetailPage(room: widget.room!);
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return ChatDetailPage(room: widget.room!);
        // })
        // );
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
                        ? NetworkImage(urlLogin + widget.image!)
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
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 92, 178, 248)),
                                child: Center(
                                  child: Text(
                                    widget.total!.toString(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              widget.unread! != 0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red[300]),
                                      // alignment: Alignment.center,
                                      child: Text(
                                        widget.unread!.toString(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
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
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
