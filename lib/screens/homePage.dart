import 'package:flutter/material.dart';

// import 'chatPage.dart';
import 'chatPageApiWorking.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   child: const Center(child: Text("Chats")),
      // ),
      body: ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        backgroundColor: Color.fromARGB(255, 221, 195, 203),
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
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
    );
  }
}
