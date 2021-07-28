import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_utility_pro/screens/tabPages/RequestsPage.dart';
import 'package:home_utility_pro/screens/tabPages/acceptedRequests.dart';
import 'package:home_utility_pro/screens/tabPages/jobsPage.dart';
import '../main.dart';
import 'tabPages/userRequestsPage.dart';
import 'tabPages/userProfile.dart';

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
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
                priority: Priority.high,
                importance: Importance.high,
                fullScreenIntent: true,
              ),
            ));
      }
    });
    resolveToken();
  }

  resolveToken() async {
    String token = await database.getMyToken();
    if (token == null || token == '') {
      String token = await FirebaseMessaging.instance.getToken();
      database.saveToken(token);
      print(token);
    }
  }

  // getToken() async {
  //   String token = await FirebaseMessaging.instance.getToken();
  //   userToken = token;
  //   print(userToken);
  // }

  // getToken() async {
  //   if (await database.getToken() == null) {
  //     print('hehhehe');
  // String token = await FirebaseMessaging.instance.getToken();
  //     database.saveToken(token);
  //     userToken = token;
  //   } else {
  //     userToken = await database.getToken();
  // print(userToken);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(TextController());
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        // dragStartBehavior: DragStartBehavior.down,
        controller: tabController,
        children: [
          RequestsPage(),
          Jobs(),
          ProsProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xffd17842),
        unselectedItemColor: Color(0xff4d4f52),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "My Requests"),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_from_queue), label: "My Jobs"),
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
