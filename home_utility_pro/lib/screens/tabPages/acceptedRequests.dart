import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/location/userLocation.dart';
import 'package:home_utility_pro/screens/tabPages/userRequestsPage.dart';
import '../../constants.dart';
import '../../main.dart';
import '../googleMapsScreen.dart';

class AcceptedRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // database.totalUsersRequests();

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColour,
        drawer: DrawerItems(),
        appBar: AppBar(
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
                fontSize: 35,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Scrollbar(
          child: AcceptedRequestsStream(),
        ),
      ),
    );
  }
}

class AcceptedRequestsStream extends StatefulWidget {
  @override
  _AcceptedRequestsStreamState createState() => _AcceptedRequestsStreamState();
}

class _AcceptedRequestsStreamState extends State<AcceptedRequestsStream> {
  // bool isAccepted = false;

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
        print(snapshot.data.snapshot.value);
        Map acceptedRequests = snapshot.data.snapshot.value;
        // print(messages);
        // ref.update(messages);
        // print(snapshot.data.snapshot.value);
        // print(messages);
        // if (messages != null) {
        List<String> data = [];
        acceptedRequests.forEach((key, value) {
          data.add(value['requestKey'] as String);
        });

        // for(Map data in data) {
        //   ref.child(path)
        // }
        return Container(
          // height: 200, //TODO: manage
          child: ListView.builder(
            // controller: scrollController,
            shrinkWrap: true,
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              // Map requestMap = snapshot.value;

              return StreamBuilder(
                stream: database.requestDataStream(requestKey: data[index]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
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
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15.0,
                                            horizontal: 20.0,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Job Description'),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Text('Enter text here'),
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

                                  print(userPosition);
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
                                    StreamBuilder(
                                        stream: database.userDataStream(
                                            userID: requestData['requestedBy']
                                                ['userID']),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                  color: kBlackColour,
                                                  backgroundColor: kWhiteColour,
                                                ),
                                              ],
                                            );
                                          }

                                          Map userData =
                                              snapshot.data.snapshot.value;

                                          return SingleChildScrollView(
                                            child: Dialog(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide.none,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(25.0),
                                                  bottomLeft:
                                                      Radius.circular(25.0),
                                                  bottomRight:
                                                      Radius.circular(25.0),
                                                  topRight:
                                                      Radius.circular(25.0),
                                                ),
                                              ),
                                              insetAnimationCurve:
                                                  Curves.bounceIn,
                                              // backgroundColor: Color(0xFF110E1F),
                                              // elevation: 30.0,
                                              backgroundColor: kWhiteColour,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 20.0,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // Text(
                                                    //   'Customer\'s Profile'
                                                    //       .toUpperCase(),
                                                    //   style: GoogleFonts.roboto(
                                                    //     fontSize: 28.0,
                                                    //     color: Colors.black,
                                                    //   ),
                                                    // ),
                                                    // ),

                                                    SizedBox(
                                                      height:
                                                          size.height * 0.021,
                                                    ),
                                                    CircleAvatar(
                                                      radius: 50.0,
                                                      backgroundColor:
                                                          kBlackColour,
                                                      backgroundImage: AssetImage(
                                                          'images/person.png'),
                                                    ),
                                                    Divider(
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.05,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xff1F1D2B),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      kWhiteColour,
                                                                  width: 1.0,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xFF9751E6),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color(0xFF9751E6)
                                                                            .withOpacity(0.6),
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            8.0,
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                      ),
                                                                    ]),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .person_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.04),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text('NAME',
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.005,
                                                                  ),
                                                                  Text(
                                                                    '${userData['userName']}',
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height:
                                                          size.height * 0.021,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xff1F1D2B),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      kWhiteColour,
                                                                  width: 1.0,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xFF36B460),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color(0xFF36B460)
                                                                            .withOpacity(0.6),
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            8.0,
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                      ),
                                                                    ]),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .phone_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Icon(Icons.work, color: Colors.blueGrey),
                                                              SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.04),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text('PHONE',
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.005,
                                                                  ),
                                                                  Text(
                                                                    ' ${userData['userPhoneNo']}',
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      fontSize:
                                                                          18.0,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height:
                                                          size.height * 0.021,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xff1F1D2B),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      kWhiteColour,
                                                                  width: 1.0,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xFFE6D751),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color(0xFFE6D751)
                                                                            .withOpacity(0.6),
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            8.0,
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                      ),
                                                                    ]),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .email_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Icon(Icons.work, color: Colors.blueGrey),
                                                              SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.04),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text('EMAIL',
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.005,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        '${userData['userEmail']}',
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          fontSize:
                                                                              18.0,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  // Flex(
                                                                  //     direction: Axis
                                                                  //         .horizontal)
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.021,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color(
                                                                    0xff1F1D2B),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      kWhiteColour,
                                                                  width: 1.0,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                ),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xFFCE4040),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color(0xFFCE4040)
                                                                            .withOpacity(0.6),
                                                                        spreadRadius:
                                                                            2,
                                                                        blurRadius:
                                                                            8.0,
                                                                        offset: Offset(
                                                                            2,
                                                                            4),
                                                                      ),
                                                                    ]),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .home_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Icon(Icons.work, color: Colors.blueGrey),
                                                              SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.04),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'ADDRESS',
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              20,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  SizedBox(
                                                                    height: size
                                                                            .height *
                                                                        0.005,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        '${requestData['userMunicipality']},\n ${requestData['userDistrict']}',
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          fontSize:
                                                                              18.0,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height:
                                                          size.height * 0.065,
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
                                                          color: kBlackColour,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        child: Text(
                                                          'Ok',
                                                          style: TextStyle(
                                                            color: kWhiteColour,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                onTap: () async {},
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
