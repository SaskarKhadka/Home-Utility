import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'tabPages/servicesPage.dart';
import 'tabPages/userRequestsPage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
    tabController = TabController(length: 2, vsync: this);
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
        dragStartBehavior: DragStartBehavior.start,
        // physics: Physics,
        controller: tabController,
        children: [
          ServicesPage(),
          UserRequestsPage(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        selectedColorOpacity: 0.3,
        unselectedItemColor: Colors.grey.shade600,
        selectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            tabController.index = _selectedIndex;
          });
        },
        items: [
          /// Services
          SalomonBottomBarItem(
            icon: Icon(EvaIcons.questionMark),
            title: Text('Services'),
          ),

          /// My Requests
          SalomonBottomBarItem(
            icon: Icon(EvaIcons.personOutline),
            title: Text('My Requests'),
          ),

          /// 3
          SalomonBottomBarItem(
            icon: Icon(EvaIcons.personOutline),
            title: Text('3'),
          ),
        ],
      ),
    );
  }
}

//  BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         elevation: 5,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.black87,
//         selectedFontSize: 15,
//         unselectedFontSize: 13,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             tabController.index = _selectedIndex;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(EvaIcons.questionMark),
//             label: 'Services',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(EvaIcons.personOutline),
//             label: 'My Requests',
//           ),
//         ],
//       ),
