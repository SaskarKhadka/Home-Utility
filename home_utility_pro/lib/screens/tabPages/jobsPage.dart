import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/getUsersInfo.dart';
import 'package:home_utility_pro/controllers/userController.dart';
import 'package:home_utility_pro/location/userLocation.dart';
import 'package:home_utility_pro/model/userData.dart';
import 'package:home_utility_pro/screens/chatScreen.dart';
import 'package:home_utility_pro/screens/logInScreen.dart';
import 'package:home_utility_pro/screens/tabPages/popUpMenuPages/about.dart';
import 'package:home_utility_pro/screens/tabPages/popUpMenuPages/help.dart';
import '../../constants.dart';
import '../../main.dart';
import '../googleMapsScreen.dart';

class Jobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // drawer: DrawerItems(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 67,
          elevation: 2,
          shadowColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              left: 16.0,
            ),
            child: Text(
              'My Jobs',
              style: GoogleFonts.montserrat(
                // color: Color(0xff131313),
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 20.0,
                right: 15.0,
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                  textTheme: TextTheme().apply(bodyColor: Colors.black),
                  dividerColor: Colors.black,
                  iconTheme: IconThemeData(color: Colors.white)),
              child: PopupMenuButton<int>(
                color: Colors.white,
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      "About us",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        "Help",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          letterSpacing: 1.8,
                        ),
                      )),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Sign Out",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              letterSpacing: 1.8,
                            ),
                          )
                        ],
                      )),
                ],
                onSelected: (item) => SelectedItem(context, item),
                offset: Offset(0, 70),
              ),
            ),
          ],
        ),
        body: Scrollbar(
          child: AcceptedRequestsStream(),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Future<void> SelectedItem(BuildContext context, int item) async {
  switch (item) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutPage()),
      );
      // Get.toNamed(AboutPage.id);
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HelpPage()),
      );
      // Get.toNamed(HelpPage.id);
      break;
    case 2:
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (context) => DialogBox(
      //     title: 'Signing Out',
      //   ),
      // );
      await userAuthentication.signOut();
      Get.offAndToNamed(LogInScreen.id);

      break;
  }
}

class AcceptedRequestsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: database.acceptedRequestStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.snapshot.value == null) {
          print('WHATATATTATA');
          return Center(
            child: Text(
              'You have no requests',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          );
        }
        // print(snapshot.data.snapshot.value);
        Map acceptedRequests = snapshot.data.snapshot.value;

        List<String> requestKeys = [];
        acceptedRequests.forEach((key, value) {
          requestKeys.add(value['requestKey'] as String);
        });
        return Container(
          // height: 200, //TODO: manage
          child: ListView.builder(
            // controller: scrollController,
            shrinkWrap: true,
            itemCount: requestKeys.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              // Map requestMap = snapshot.value;

              return StreamBuilder(
                stream:
                    database.requestDataStream(requestKey: requestKeys[index]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.data.snapshot.value == null) {
                    return Container();
                  }
                  Map requestData = snapshot.data.snapshot.value;

                  String value = requestData['dateTime'];
                  List dateTime = value.split(' ');
                  List date = dateTime[0].split('-');
                  List time = dateTime[1].split(':');

                  DateTime requestDateTime = DateTime(
                    int.parse(date[0]),
                    int.parse(date[1]),
                    int.parse(date[2]),
                    int.parse(time[0]),
                    int.parse(time[1]),
                    // int.parse(time[2]),
                  );
                  DateTime now = DateTime.now();
                  if (now.isAfter(requestDateTime)) {
                    database.deleteJob(requestKey: requestData['requestKey']);
                  }
                  return Container(
                    // height: size.height * 0.285,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 20.0,
                      bottom: 15.0,
                      right: 15.0,
                      left: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF18171A),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          16.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        // top: size.height * 0.007,
                        left: 6.0,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18.0, top: 18.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      GetUsersInfo(
                                          userID: requestData['requestedBy']
                                              ['userID']),

                                      // barrierColor:
                                      //     kWhiteColour.withOpacity(0.1),
                                    );
                                  },
                                  child: GetX<UserController>(
                                    init: UserController(
                                        requestData['requestedBy']['userID']),
                                    builder: (userController) {
                                      if (userController == null ||
                                          userController.user.isEmpty) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              color: kBlackColour,
                                              backgroundColor: Colors.white,
                                            ),
                                          ],
                                        );
                                      }

                                      List<UserData> userData =
                                          userController.user;
                                      return CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: Colors.teal,
                                        backgroundImage: NetworkImage(
                                            userData[0].profileUrl),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GetX<UserController>(
                                        init: UserController(
                                            requestData['requestedBy']
                                                ['userID']),
                                        builder: (userController) {
                                          if (userController == null ||
                                              userController.user.isEmpty) {
                                            return Text(
                                              'username',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                          return Text(
                                            userController.user[0].userName,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      requestData['service'],
                                      style: GoogleFonts.shortStack(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: size.width * 0.05),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 38.0, right: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Date:\n' + requestData['date'],
                                  style: GoogleFonts.shortStack(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: size.height * 0.07,
                                ),
                                Text(
                                  'Time:\n' + requestData['time'],
                                  style: GoogleFonts.shortStack(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  Get.to(ChatScreen(
                                      userID: requestData['requestedBy']
                                          ['userID']));
                                },
                                child: Container(
                                  height: 40,
                                  width: size.width * 0.19,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF59C0DA),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        16.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        EvaIcons.messageCircleOutline,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Chat',
                                        style: GoogleFonts.roboto(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: (context),
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        backgroundColor: Colors.black,
                                        elevation: 25.0,
                                        insetPadding: EdgeInsets.symmetric(
                                          vertical: 25.0,
                                          horizontal: 25.0,
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.all(1),
                                          width: size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 18.0,
                                                  left: 8.0,
                                                  right: 8.0,
                                                ),
                                                child: Text(
                                                  'Job\'s Description',
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 26,
                                                    letterSpacing: 2.0,
                                                    wordSpacing: 2.0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 250.0,
                                                child: Divider(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 18.0,
                                                  left: 20.0,
                                                  right: 18.0,
                                                  bottom: 18.0,
                                                ),
                                                child: Text(
                                                  requestData['jobDescription'] ==
                                                          null
                                                      ? 'The customer has not provided any description'
                                                      : requestData[
                                                          'jobDescription'],
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                    letterSpacing: 2.0,
                                                    wordSpacing: 2.0,
                                                    // fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Get.back(),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 20.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  // width: 40,
                                  width: size.width * 0.19,

                                  decoration: BoxDecoration(
                                    color: Color(0xFF5962DA),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        16.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.description,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Info',
                                        style: GoogleFonts.roboto(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () async {
                                    Position position =
                                        await UserLocation().getLocation();
                                    print(position);
                                    Map userPosition =
                                        await database.getUserLocation(
                                            userID: requestData['requestedBy']
                                                ['userID']);

                                    // print(userPosition);
                                    Get.to(
                                      GoogleMapScreen(
                                        position: position,
                                        userPosition: userPosition,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: size.width * 0.19,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFAA4F4F),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          16.0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            EvaIcons.mapOutline,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Map',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
    // });
  }
}
