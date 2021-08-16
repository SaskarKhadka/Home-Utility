import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import 'tabPages/userRequestsPage.dart';
import 'tabPages/userProfile.dart';
import 'tabPages/servicePage.dart';
import 'package:home_utility/reusableTypes.dart';
import 'package:home_utility/notificationHandler.dart';

class MainScreen extends StatefulWidget {
  static const id = '/mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // FirebaseMessaging.onMessage.listen((message) {
    //   print(message.notification.title);
    // });

    super.initState();
    tabController = TabController(length: 3, vsync: this);
    notificationHandler.onMessageHandler();
    resolveToken();
  }

  resolveToken() async {
    try {
      String token = await database.getMyToken();
      String deviceToken = await FirebaseMessaging.instance.getToken();

      if (token == null || token == '' || token != deviceToken) {
        // String token = await FirebaseMessaging.instance.getToken();
        database.saveToken(deviceToken);
        print(deviceToken);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // final ServiceHandler serviceHandler = ServiceHandler();

  @override
  Widget build(BuildContext context) {
    // Get.put(TextController());
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        // dragStartBehavior: DragStartBehavior.start,
        controller: tabController,
        children: [
          ServicePage(),
          UserRequestsPage(),
          UserProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xffd17842),
        unselectedItemColor: Color(0xff4d4f52),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_from_queue), label: "Requests"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            tabController.index = _selectedIndex;
          });
        },
      ),
    );
  }
}
