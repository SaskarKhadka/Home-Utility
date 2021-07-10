import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customButton.dart';
import 'package:home_utility/components/displayField.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/userController.dart';
import 'package:home_utility/screens/tabPages/profile/editProfile.dart';

class UserProfile extends StatelessWidget {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    //    double screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff141a1e),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              // textDirection: TextDirection.ltr,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(25.0),
                    //   child: CircleAvatar(
                    //     radius: 65.0,
                    //     backgroundColor: Colors.white,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Obx(() {
                        if (userController.user[0].profileUrl == null ||
                            userController.user[0].profileUrl.isEmpty) {
                          return CircleAvatar(
                            radius: 65,
                            backgroundColor: kWhiteColour,
                            backgroundImage: AssetImage('images/person.png'),
                          );
                        }

                        return CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.black,
                          backgroundImage: Image.network(
                            userController.user[0].profileUrl,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return CircularProgressIndicator(
                                color: kWhiteColour,
                              );
                            },
                          ).image,
                        );
                        // return CircleAvatar(
                        //   radius: 55,
                        //   backgroundColor: Colors.black,
                        //   backgroundImage: NetworkImage(
                        //     proController.pro[0].profileUrl,
                        //   ),
                        // );
                      }),
                    ),
                    Obx(
                      () {
                        if (userController.user.isEmpty)
                          return Text(
                            'Username',
                            // userData['userName'],
                            style: GoogleFonts.castoro(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        return Text(
                          userController.user[0].userName,
                          // userData['userName'],
                          style: GoogleFonts.castoro(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Obx(
                      () {
                        if (userController.user.isEmpty)
                          return Text(
                            'User ID',
                            style: GoogleFonts.shortStack(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        return Text(
                          'UserID: ' + userController.user[0].userID,
                          style: GoogleFonts.shortStack(
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),

                    SizedBox(
                      width: 200.0,
                      child: Divider(
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.022,
                    ),

                    // DisplayField(
                    //   icon: Icons.perm_identity_outlined,
                    //   iconSize: 20.0,
                    //   iconColour: Color(0xFF1163FB),
                    //   borderRadius: 50.0,
                    //   text: userController.user[0].userID,
                    //   displaytext: 'Id',
                    //   textColour: Colors.black,
                    //   marginHorizontal: 25.0,
                    //   marginVertical: 10.0,
                    //   boxColor: Colors.white,
                    // ),
                    DisplayField(
                      icon: EvaIcons.phone,
                      iconSize: 20.0,
                      iconColour: Colors.teal,
                      borderRadius: 50.0,
                      text: '+977-${userController.user[0].userPhoneNo}',
                      displaytext: 'Phone Number',
                      textColour: Colors.black,
                      marginHorizontal: 25.0,
                      marginVertical: 10.0,
                      boxColor: Colors.white,
                    ),
                    DisplayField(
                      icon: EvaIcons.email,
                      iconSize: 20.0,
                      iconColour: Color(0xfffbbf11),
                      borderRadius: 50.0,
                      text: userController.user[0].userEmail,
                      displaytext: 'Email',
                      textColour: Colors.black,
                      marginHorizontal: 25.0,
                      marginVertical: 10.0,
                      boxColor: Colors.white,
                    ),

                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()),
                              );
                            },
                            buttonHeight: 45.0,
                            primaryColour: kPrimaryColor,
                            shadowColour: kSecondaryColor,
                            borderRadius: 8.0,
                            borderSideWidth: 0.5,
                            borderSideColour: kSecondaryColor,
                            buttonText: 'Edit Profile',
                            textColour: kSecondaryColor,
                          ),
                        ),
                        Expanded(
                          child: ProfileButton(
                            onPressed: () {},
                            buttonHeight: 45.0,
                            primaryColour: kPrimaryColor,
                            shadowColour: kSecondaryColor,
                            borderRadius: 8.0,
                            borderSideWidth: 0.5,
                            borderSideColour: kSecondaryColor,
                            buttonText: 'Sign Out',
                            textColour: kSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
