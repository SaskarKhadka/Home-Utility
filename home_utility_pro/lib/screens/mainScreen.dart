import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:home_utility_pro/screens/tabPages/acceptedRequests.dart';
import 'package:line_icons/line_icons.dart';
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
    getToken();
  }

  getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    userToken = token;
    print(userToken);
  }

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
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  // final ServiceHandler serviceHandler = ServiceHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        // dragStartBehavior: DragStartBehavior.down,
        controller: tabController,
        children: [
          UserRequestsPage(),
          AcceptedRequests(),
          ProsProfile(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          // color: Color(0xff131313),
          // color: Colors.transparent,
          height: 65,
          child: GNav(
            tabBorderRadius: 30.0,
            // tabShadow: [],
            tabActiveBorder: Border.all(
              style: BorderStyle.none,
            ),
            tabMargin: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            tabBorder: Border.all(
              style: BorderStyle.none,
              color: Color(0xff131313),
              // width: 1.0,
            ),
            color: Color(0xff131313),
            curve: Curves.easeIn,

            activeColor: Colors.white,
            // activeColor: Colors.transparent,
            rippleColor: Color(0xff131313),
            hoverColor: Color(0xff131313).withOpacity(0.6),
            gap: 0,
            iconSize: 20,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 15.0,
            ),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Color(0xff131313),
            backgroundColor: Color(0xff131313).withOpacity(0.7),
            // backgroundColor: Colors.transparent,
            textStyle: GoogleFonts.montserrat(
              fontSize: 14.0,
              color: Colors.white,
            ),
            tabs: [
              GButton(
                icon: LineIcons.handshakeAlt,
                text: ' Requests',
              ),
              GButton(
                icon: LineIcons.handshakeAlt,
                text: ' My Jobs',
              ),
              GButton(
                icon: LineIcons.user,
                text: ' Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                tabController.index = _selectedIndex;
              });
            },
          ),
        ),
      ),
    );
  }
}
