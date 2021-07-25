import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/controllers/userController.dart';
import 'package:home_utility_pro/location/userLocation.dart';
import 'package:home_utility_pro/model/userData.dart';
import 'package:home_utility_pro/screens/chatScreen.dart';
import 'package:home_utility_pro/screens/tabPages/userRequestsPage.dart';
import '../../constants.dart';
import '../../main.dart';
import '../googleMapsScreen.dart';

class AcceptedRequests extends StatelessWidget {
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
                fontSize: 30,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
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
                    height: size.height * 0.285,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 20.0,
                      bottom: 15.0,
                      right: 25.0,
                      left: 25.0,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white30,
                          offset: Offset(2, 5),
                          blurRadius: 10,
                        ),
                      ],
                      color: Color(0xff131313),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.025,
                        left: 15.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          // children: [
                          Text(
                            requestData['service'],
                            style: TextStyle(
                              fontSize: size.height * 0.03,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: size.height * 0.011,
                          ),
                          Text(
                            'Date: ' + requestData['date'],
                            style: TextStyle(
                              fontSize: size.height * 0.021,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: size.height * 0.011,
                          ),
                          Text(
                            'Time: ' + requestData['time'],
                            style: TextStyle(
                              fontSize: size.height * 0.021,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: size.height * 0.009,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: kWhiteColour,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white30,
                                        offset: Offset(2, 5),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        // isAccepted
                                        // ? EvaIcons.close :
                                        EvaIcons.questionMark,
                                        color: kBlackColour,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Text(
                                        // isAccepted ? 'Cancel' : 'Accept',
                                        'View Job Description',
                                        style: GoogleFonts.raleway(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColour,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              InkWell(
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: size.height * 0.009,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: kWhiteColour,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white30,
                                        offset: Offset(2, 5),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        EvaIcons.mapOutline,
                                        color: kBlackColour,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Text(
                                        // isAccepted ? 'Cancel' : 'Accept',
                                        'Map',
                                        style: GoogleFonts.raleway(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColour,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.011,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    GetX<UserController>(
                                        init: UserController(
                                            requestData['requestedBy']
                                                ['userID']),
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

                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            elevation: 10.0,
                                            backgroundColor: Colors.white,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: size.width,
                                                  padding: EdgeInsets.only(
                                                    top: 0.0,
                                                    bottom: 20.0,
                                                    left: 20.0,
                                                    right: 20.0,
                                                  ),
                                                  // margin:
                                                  //     EdgeInsets.only(top: 80),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff141a1e),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.white38,
                                                        offset: Offset(0, 2),
                                                        blurRadius: 10.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.02,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 55.0,
                                                        backgroundColor:
                                                            Colors.teal,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                userData[0]
                                                                    .profileUrl),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.02,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          userData[0]
                                                              .userName
                                                              .toUpperCase(),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 20.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 100,
                                                        child: Divider(
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 26.0,
                                                                    left: 20.0),
                                                            child: Text(
                                                              'Contact Details:',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .greenAccent,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 16.0),
                                                            child: Icon(
                                                              Icons.phone,
                                                              color:
                                                                  Colors.teal,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 16.0),
                                                            child: Text(
                                                              '${userData[0].userPhoneNo}',
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      16.0,
                                                                  color:
                                                                      kWhiteColour,
                                                                  letterSpacing:
                                                                      1.3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.005,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 16.0),
                                                            child: Icon(
                                                              Icons.email,
                                                              size: 22,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 16.0),
                                                            child: Text(
                                                              userData[0]
                                                                  .userEmail,
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 16.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.05,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => Get.back(),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 20.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff4f5b8a),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(
                                                                    0xff2f3650),
                                                                offset: Offset(
                                                                    0, 1),
                                                                blurRadius: 4.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                    // barrierColor:
                                    //     kWhiteColour.withOpacity(0.1),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: size.height * 0.009,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: kWhiteColour,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white30,
                                        offset: Offset(2, 5),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        EvaIcons.personOutline,
                                        color: kBlackColour,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Text(
                                        'Customer\'s Profile',
                                        style: GoogleFonts.raleway(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColour,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              InkWell(
                                onTap: () async {
                                  Get.to(ChatScreen(
                                      userID: requestData['requestedBy']
                                          ['userID']));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: size.height * 0.009,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: kWhiteColour,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white30,
                                        offset: Offset(2, 5),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        EvaIcons.messageCircleOutline,
                                        color: kBlackColour,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Text(
                                        // isAccepted ? 'Cancel' : 'Accept',
                                        'Chat',
                                        style: GoogleFonts.raleway(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: kBlackColour,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // : Container(),
                            ],
                          ),
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
  }
}
