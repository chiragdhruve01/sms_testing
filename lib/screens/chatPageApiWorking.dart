import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms/screens/Menu.dart';
import 'package:sms/utils/constants.dart';
import 'package:intl/intl.dart';

// import '../models/chatusersmodels.dart';
import '../models/chat.dart';
import '../widgets/conversationList.dart';
import '../widgets/conversationListAPI.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Future<List<Countuser>> countuser;
  List<Countuser>? chatUsers = [];
  dynamic newtoken = "";

  @override
  void initState() {
    super.initState();
    // countuser = getEmployeeList();
    getEmployeeList();
  }

  Future<String> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey('token');
    var token = "";
    if (CheckValue == true) {
      token = prefs.getString('token')!;
    }
    return token;
  }

  getEmployeeList() async {
    String token = await getPrefs();
    final url = Uri.http(urlLogindomain, '${usergetmsg}${token}');
    final response = await http.get(url);

    // final response = await http.Client().get(Uri.https(url));
    final jsonData = jsonDecode(response.body);
    final chatData = Chat.fromJson(jsonData);
    chatUsers = chatData.countuser!;
    print('DATA ==== ' + chatUsers!.length.toString());
    setState(() {});
  }

  // List<dynamic> chatUsers = [
  //   {
  //     "name": "Jane Russel",
  //     "messageText": "Awesome Setup",
  //     "imageURL": "",
  //     "time": "Now"
  //   },
  //   {
  //     "name": "maniel Russel",
  //     "messageText": "Awesome Setup",
  //     "imageURL": "",
  //     "time": "Now"
  //   },
  //   // {
  //   //   "name": "donald Russel",
  //   //   "messageText": "Awesome Setup",
  //   //   "imageURL":
  //   //       "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg",
  //   //   "time": "Now"
  //   // }
  // ];

  // List<ChatUsers> chatUsers = [
  //   ChatUsers(
  //       name: "Jane Russel",
  //       messageText: "Awesome Setup",
  //       imageURL: "",
  //       time: "Now"),
  //   ChatUsers(
  //       name: "Glady's Murphy",
  //       messageText: "That's Great",
  //       imageURL: "",
  //       time: "Yesterday"),
  //   ChatUsers(
  //       name: "Jorge Henry",
  //       messageText: "Hey where are you?",
  //       imageURL:
  //           "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg",
  //       time: "31 Mar"),
  //   ChatUsers(
  //       name: "Philip Fox",
  //       messageText: "Busy! Call me in 20 mins",
  //       imageURL:
  //           "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg",
  //       time: "28 Mar"),
  //   ChatUsers(
  //       name: "Debra Hawkins",
  //       messageText: "Thankyou, It's awesome",
  //       imageURL:
  //           "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg",
  //       time: "23 Mar"),
  //   ChatUsers(
  //       name: "Jacob Pena",
  //       messageText: "will update you in evening",
  //       imageURL:
  //           "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg",
  //       time: "17 Mar"),
  //   ChatUsers(
  //       name: "Andrey Jones",
  //       messageText: "Can you please share the file?",
  //       imageURL:
  //           "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg",
  //       time: "24 Feb"),
  //   ChatUsers(
  //       name: "John Wick",
  //       messageText: "How are you?",
  //       imageURL:
  //           "https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg",
  //       time: "18 Feb"),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SingleChildScrollView(
      //   child: Center(child: Text("Chat")),
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SMSMenu()));
                            },
                            child: Text(
                              "Add New",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
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
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
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
                return ConversationAPIList(
                  contact: chatUsers![index].contact,
                  date: DateFormat('E, d MMM, yyyy')
                      .format(chatUsers![index].date!),
// chatUsers![index].date!.toString(),
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
