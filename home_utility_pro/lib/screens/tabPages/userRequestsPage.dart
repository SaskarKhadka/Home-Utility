import 'dart:convert';
import 'package:home_utility_pro/components/getUsersInfo.dart';
import 'package:home_utility_pro/controllers/proController.dart';
import 'package:home_utility_pro/screens/tabPages/jobsPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/constants.dart';
import 'package:home_utility_pro/reusableTypes.dart';

class RequestsPage extends StatelessWidget {
  final proController = Get.put(ProController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff050505),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 38.0,
                    left: 32.0,
                    right: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, there",
                            style: GoogleFonts.shortStack(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              "You have following pending Requests",
                              style: GoogleFonts.raleway(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                            textTheme:
                                TextTheme().apply(bodyColor: Colors.black),
                            dividerColor: Colors.black,
                            iconTheme: IconThemeData(color: Colors.white)),
                        child: PopupMenuButton<int>(
                          color: Colors.white,
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Text(
                                "About",
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
                          offset: Offset(-5, 70),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                StreamBuilder(
                  stream: database.userRequestsStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.data.snapshot.value == null) {
                      return Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.3,
                          ),
                          Center(
                            child: Text(
                              'You have no requests',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    Map userRequests = snapshot.data.snapshot.value;
                    // print(userRequests);
                    // print(messages);
                    // ref.update(messages);
                    // print(snapshot.data.snapshot.value);
                    // print(messages);
                    // if (messages != null) {
                    List<String> data = [];
                    userRequests.forEach((key, value) {
                      data.add(value['requestKey'] as String);
                    });
                    // int totalRequests = data.length;
                    // for(Map data in data) {
                    //   ref.child(path)
                    // }
                    // print('HI');

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
                              stream: database.requestDataStream(
                                  requestKey: data[index]),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data.snapshot.value == null) {
                                  return Container();
                                }
                                Map requestData = snapshot.data.snapshot.value;
                                // print(requestData);

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
                                if (!requestData['isAccepted'] &&
                                    now.isAfter(requestDateTime)) {
                                  database.deleteRequest(
                                    requestKey: requestData['requestKey'],
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, right: 22.0, bottom: 22.0),
                                  child: Container(
                                    width: size.width,
                                    // height: 200.0,
                                    decoration: BoxDecoration(
                                      // color: Color(0xff28272c),
                                      color: Color(0xFF18171A),

                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          16.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 18.0,
                                              left: 18.0,
                                              right: 18.0),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.dialog(
                                                    GetUsersInfo(
                                                        userID: requestData[
                                                                'requestedBy']
                                                            ['userID']),

                                                    // barrierColor:
                                                    //     kWhiteColour.withOpacity(0.1),
                                                  );
                                                },
                                                child: StreamBuilder(
                                                    stream: usersRefrence
                                                        .child(requestData[
                                                                'requestedBy']
                                                            ['userID'])
                                                        .onValue,
                                                    builder:
                                                        (context, snapshot) {
                                                      if (!snapshot.hasData ||
                                                          snapshot.data.snapshot
                                                                  .value ==
                                                              null)
                                                        return CircleAvatar(
                                                          radius: 25.0,
                                                          backgroundColor:
                                                              Colors.teal,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'images/person.png'),
                                                        );

                                                      Map userData = snapshot
                                                          .data.snapshot.value;
                                                      // print(userData['prosProfile']);
                                                      return CircleAvatar(
                                                        radius: 25.0,
                                                        backgroundColor:
                                                            Colors.teal,
                                                        backgroundImage: userData[
                                                                    'profileUrl'] ==
                                                                null
                                                            ? AssetImage(
                                                                'images/person.png')
                                                            : NetworkImage(
                                                                userData[
                                                                    'profileUrl']),
                                                      );
                                                    }),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  StreamBuilder(
                                                      stream: usersRefrence
                                                          .child(requestData[
                                                                  'requestedBy']
                                                              ['userID'])
                                                          .onValue,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData ||
                                                            snapshot
                                                                    .data
                                                                    .snapshot
                                                                    .value ==
                                                                null)
                                                          return Text(
                                                            'username',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          );

                                                        Map usersData = snapshot
                                                            .data
                                                            .snapshot
                                                            .value;
                                                        // print(userData['prosProfile']);
                                                        return Text(
                                                          usersData['userName'],
                                                          style: GoogleFonts
                                                              .montserrat(
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
                                                    style:
                                                        GoogleFonts.shortStack(
                                                      fontSize: 12.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Date: ' +
                                                          requestData['date'],
                                                      style: GoogleFonts
                                                          .shortStack(
                                                        fontSize: 12.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.01,
                                                    ),
                                                    Text(
                                                      'Time: ' +
                                                          requestData['time'],
                                                      style: GoogleFonts
                                                          .shortStack(
                                                        fontSize: 12.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: (context),
                                                    builder: (context) {
                                                      return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            side:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                        backgroundColor:
                                                            Colors.black,
                                                        elevation: 25.0,
                                                        insetPadding: EdgeInsets
                                                            .symmetric(
                                                          vertical: 25.0,
                                                          horizontal: 25.0,
                                                        ),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(1),
                                                          width: size.width,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 18.0,
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                ),
                                                                child: Text(
                                                                  'Job\'s Description',
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        26,
                                                                    letterSpacing:
                                                                        2.0,
                                                                    wordSpacing:
                                                                        2.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 250.0,
                                                                child: Divider(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.7),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 18.0,
                                                                  left: 20.0,
                                                                  right: 18.0,
                                                                  bottom: 18.0,
                                                                ),
                                                                child: Text(
                                                                  requestData['jobDescription'] ==
                                                                          null
                                                                      ? 'The customer has not provided any description'
                                                                      : requestData['jobDescription'] ==
                                                                              ''
                                                                          ? 'The customer has not provided any description'
                                                                          : requestData[
                                                                              'jobDescription'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        19,
                                                                    letterSpacing:
                                                                        2.0,
                                                                    wordSpacing:
                                                                        2.0,
                                                                    // fontStyle: FontStyle.italic,
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () =>
                                                                    Get.back(),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                    horizontal:
                                                                        20.0,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  child: Text(
                                                                    'Ok',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.02,
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
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF5962DA),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  // child: Column(
                                                  //   children: [
                                                  // Text(
                                                  //   'Job',
                                                  //   style:
                                                  //       TextStyle(color: Colors.white),
                                                  // ),
                                                  child: Icon(
                                                    Icons.description,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                  // ],
                                                  // ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  Get.defaultDialog(
                                                    title: 'Reject Request',
                                                    content: Text(
                                                        'Are you sure you want to continue?'),
                                                    cancel: ElevatedButton(
                                                      onPressed: () =>
                                                          Get.back(),
                                                      child: Text('No'),
                                                    ),
                                                    confirm: ElevatedButton(
                                                        onPressed: () async {
                                                          Get.back();
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          CircularProgressIndicator(
                                                                            color:
                                                                                kBlackColour,
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                          ),
                                                                        ],
                                                                      ));
                                                          String token = await database
                                                              .getToken(requestData[
                                                                      'requestedBy']
                                                                  ['userID']);
                                                          await database
                                                              .cancelRequest(
                                                            requestKey:
                                                                requestData[
                                                                    'requestKey'],
                                                            userID: requestData[
                                                                    'requestedBy']
                                                                ['userID'],
                                                          );
                                                          Get.back();

                                                          try {
                                                            http.post(
                                                                Uri.parse(
                                                                    'https://fcm.googleapis.com/fcm/send'),
                                                                headers: <
                                                                    String,
                                                                    String>{
                                                                  'Content-Type':
                                                                      'application/json; charset=UTF-8',
                                                                  'Authorization':
                                                                      "$key",
                                                                },
                                                                body:
                                                                    jsonEncode(
                                                                  {
                                                                    "notification":
                                                                        {
                                                                      "body":
                                                                          "Your request has been rejected",
                                                                      "title":
                                                                          "Request Rejected",
                                                                      "android_channel_id":
                                                                          "high_importance_channel"
                                                                    },
                                                                    "priority":
                                                                        "high",
                                                                    "data": {
                                                                      "click_action":
                                                                          "FLUTTER_NOTIFICATION_CLICK",
                                                                      "status":
                                                                          "done"
                                                                    },
                                                                    "to":
                                                                        "$token"
                                                                  },
                                                                ));
                                                            print(
                                                                'FCM request for device sent!');
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                        child: Text('Yes')),
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFDA5D59),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                        16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    // Icons.cancel,
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 18.0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    Get.defaultDialog(
                                                      title: 'Accept Request',
                                                      content: Text(
                                                          'Are you sure you want to continue?'),
                                                      cancel: ElevatedButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: Text('No'),
                                                      ),
                                                      confirm: ElevatedButton(
                                                        onPressed: () async {
                                                          Get.back();
                                                          showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (context) =>
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          CircularProgressIndicator(
                                                                            color:
                                                                                kBlackColour,
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                          ),
                                                                        ],
                                                                      ));

                                                          await database
                                                              .changeAcceptedState(
                                                            requestKey:
                                                                requestData[
                                                                    'requestKey'],
                                                            state: true,
                                                          );

                                                          await database
                                                              .saveRequestAsJob(
                                                            requestKey:
                                                                requestData[
                                                                    'requestKey'],
                                                          );
                                                          Get.back();
                                                          String token = await database
                                                              .getToken(requestData[
                                                                      'requestedBy']
                                                                  ['userID']);
                                                          try {
                                                            await http.post(
                                                                Uri.parse(
                                                                    'https://fcm.googleapis.com/fcm/send'),
                                                                headers: <
                                                                    String,
                                                                    String>{
                                                                  'Content-Type':
                                                                      'application/json; charset=UTF-8',
                                                                  'Authorization':
                                                                      "$key",
                                                                },
                                                                body:
                                                                    jsonEncode(
                                                                  {
                                                                    "notification":
                                                                        {
                                                                      "body":
                                                                          "Your request has been accepted",
                                                                      "title":
                                                                          "Request Accepted",
                                                                      "android_channel_id":
                                                                          "high_importance_channel"
                                                                    },
                                                                    "priority":
                                                                        "high",
                                                                    "data": {
                                                                      "click_action":
                                                                          "FLUTTER_NOTIFICATION_CLICK",
                                                                      "status":
                                                                          "done"
                                                                    },
                                                                    "to":
                                                                        "$token"
                                                                  },
                                                                ));
                                                            print(
                                                                'FCM request for device sent!');
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                        child: Text('Yes'),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff59da6f),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    );
                  },
                  //   );
                  // },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
