import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/userController.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // child: StreamBuilder(
      //   stream: prosRefrence.child(userAuthentication.userID).onValue,
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     Map prosData = snapshot.data.snapshot.value;
      child: ListView(
        children: <Widget>[
          Container(
            height: 190.0,
            child: DrawerHeader(
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                Color(0xFF141a1e),
                Color(0xFF141a1e),
                Color(0xFF141a1e),
                Color(0xFF141a1e),
                Color(0xFF141a1e),
              ])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    // Material(
                    //   borderRadius:
                    //       BorderRadius.all(Radius.circular(50.0)),
                    //   color: kBlackColour,
                    //   // elevation: 10,
                    //   // child: Padding(
                    //   // padding: EdgeInsets.all(8.0),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: kBlackColour,
                      backgroundImage: AssetImage('images/person.png'),
                    ),
                    // ),
                    SizedBox(height: 10),
                    // ),
                    // Padding(
                    // padding: EdgeInsets.all(8.0),
                    Obx(() {
                      return Text(
                          'HI, ' +
                              Get.find<UserController>()
                                  .user[0]
                                  .userName
                                  .toUpperCase(),
                          style: GoogleFonts.maitree(
                              fontSize: 16, color: Colors.white70));
                    }),
                    // )
                  ],
                ),
              ),
            ),
          ),
          CustomListTile(Icons.person_outline, 'Profile', () => {}),
          CustomListTile(Icons.info_outline, 'About', () => {}),
          CustomListTile(Icons.help_outline, 'Help', () => {}),
          CustomListTile(Icons.lock_outline, 'Sign Out', () => {}),
        ],
      ),
      // },
      // ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.grey[700],
            onTap: onTap,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: kBlackColour,
                        child: Center(
                          child: Icon(
                            icon,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          text,
                          style: GoogleFonts.mada(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: kBlackColour,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
