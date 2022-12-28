import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sms/screens/Menu.dart';
import 'package:sms/screens/chatDetailPage.dart';
import 'package:sms/screens/welcome_screen.dart';

// import 'chatPage.dart';
import 'chatPageApiWorking.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  var pages = [
    ChatPage(),
    SMSMenu(),
    WelcomeScreen(),
    // ChatDetailPage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  @override
  void dispose() {
    setStatusBarColor(white);
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Color(0xFFD2FFF4),
              // shape: new RoundedRectangleBorder(
              //   borderRadius: new BorderRadius.circular(25.0),
              // ),
              title: const Text(
                'Exit App',
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
              // content: const Text(
              //   'Do you want to exit an App?',
              //   style: TextStyle(
              //     color: Colors.pink,
              //   ),
              // ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[200],
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[200],
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Scaffold(
          // body: Center(
          //   child: pages[selectedIndex],
          // ),
          body: IndexedStack(
            index: selectedIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            backgroundColor: Color.fromARGB(255, 221, 195, 203),
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "Chats",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.group_work),
                label: "Channels",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                label: "Profile",
              ),
            ],
          ),
        ));
  }
}
