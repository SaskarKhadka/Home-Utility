import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';
import 'package:home_utility_pro/controllers/proController.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 190.0,
            child: DrawerHeader(
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(16.0),
                  //   bottomRight: Radius.circular(16.0),
                  // ),
                  gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF141a1e),
                  Color(0xFF141a1e),
                  Color(0xFF141a1e),
                  Color(0xFF141a1e),
                  Color(0xFF141a1e),
                ],
              )),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                )),
                child: Column(
                  children: <Widget>[
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
                              Get.find<ProController>()
                                  .pro[0]
                                  .prosName
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

// ignore: must_be_immutable
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
