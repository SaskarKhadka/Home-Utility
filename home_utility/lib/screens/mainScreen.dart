import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'tabPages/servicesPage.dart';
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
  }

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
        dragStartBehavior: DragStartBehavior.down,
        controller: tabController,
        children: [
          ServicesPage(),
          UserRequestsPage(),
          UserProfile(),
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
            gap: 5,
            iconSize: 26,
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Color(0xff131313),
            backgroundColor: Color(0xff131313).withOpacity(0.7),
            // backgroundColor: Colors.transparent,
            textStyle: GoogleFonts.montserrat(
              fontSize: 16.0,
              color: Colors.white,
            ),
            tabs: [
              GButton(
                icon: LineIcons.handshakeAlt,
                text: 'Our Services',
              ),
              GButton(
                // icon: LineIcons.addressCard,
                icon: LineIcons.stickyNoteAlt,
                // iconActiveColor: Colors.white,
                text: 'My Requests',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
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
