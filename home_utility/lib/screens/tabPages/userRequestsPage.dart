import 'dart:convert';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customButton.dart';
import 'package:home_utility/components/getProsInfo.dart';
import 'package:home_utility/constants.dart';
import 'package:home_utility/controllers/textController.dart';
import 'package:home_utility/screens/chatScreen.dart';
import 'package:home_utility/screens/popUpPages/about.dart';
import 'package:home_utility/screens/popUpPages/help.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../logInScreen.dart';

class UserRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    database.totalUsersRequests();

    return Scaffold(
      backgroundColor: Colors.black,
      // drawer: Container(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.1),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Container(
              height: size.height * 0.17,
              decoration: BoxDecoration(
                  color: Color(0xff6737F6),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: size.height * 0.13,
                        child:
                            Center(child: Image.asset('images/requests.png'))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'My Requests !',
                          style: GoogleFonts.montserrat(
                              color: Color(0xffECECEC),
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Find your requests',
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'View all your Pending Works',
              style: GoogleFonts.lato(color: Color(0xffaaabac), fontSize: 14),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Expanded(
            child: Scrollbar(
              child: UserRequestsStream(),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> SelectedItem(BuildContext context, int item) async {
  switch (item) {
    case 0:
      Get.offNamed(AboutPage.id);
      break;
    case 1:
      Get.offNamed(HelpPage.id);
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
      Get.offAllNamed(Login.id);
      break;
  }
}

class UserRequestsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textController = Get.find<TextController>();
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: database.userRequestsStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.snapshot.value == null) {
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

        Map myRequests = snapshot.data.snapshot.value;

        List<String> requestKeys = [];
        myRequests.forEach((key, value) {
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
              return StreamBuilder(
                stream:
                    database.requestDataStream(requestKey: requestKeys[index]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.data.snapshot.value == null) {
                    // print(snapshot.data);
                    return Container();
                  }
                  // print(snapshot.data);
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
                  // print(requestDateTime);

                  DateTime now = DateTime.now();
                  // print(now);

                  bool isAccepted = requestData['isAccepted'];

                  bool isRatingPending = requestData['isRatingPending'];

                  if (isAccepted && now.isAfter(requestDateTime)) {
                    isRatingPending = true;
                  }

                  if (!isAccepted && now.isAfter(requestDateTime)) {
                    database.cancelRequest(
                      requestKey: requestData['requestKey'],
                      proID: requestData['requestedTo']['proID'],
                    );
                    return Container();
                  }

                  if (isAccepted &&
                      now.difference(requestDateTime) >= Duration(days: 2)) {
                    database.deleteRequest(
                      requestKey: requestData['requestKey'],
                    );
                    return Container();
                  }

                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      bottom: 15.0,
                      right: 15.0,
                      left: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF18171A),
                      borderRadius: BorderRadius.circular(30.0),
                      // border: Border.all(
                      //   color: Colors.white,
                      //   width: 0.05,
                      //   style: BorderStyle.solid,
                      // ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                        left: 30.0,
                        bottom: size.height * 0.015,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    GetProsInfo(
                                        proID: requestData['requestedTo']
                                            ['proID']),

                                    // barrierColor:
                                    //     kWhiteColour.withOpacity(0.1),
                                  );
                                },
                                child: StreamBuilder(
                                    stream: prosRefrence
                                        .child(
                                            requestData['requestedTo']['proID'])
                                        .onValue,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData ||
                                          snapshot.data.snapshot.value == null)
                                        return CircleAvatar(
                                          radius: 25.0,
                                          backgroundColor: Colors.teal,
                                          backgroundImage:
                                              AssetImage('images/person.png'),
                                        );

                                      Map prosData =
                                          snapshot.data.snapshot.value;
                                      // print(userData['prosProfile']);
                                      return CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: Colors.teal,
                                        backgroundImage:
                                            prosData['profileUrl'] == null
                                                ? AssetImage(
                                                    'images/person.png')
                                                : NetworkImage(
                                                    prosData['profileUrl']),
                                      );
                                    }),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  StreamBuilder(
                                      stream: prosRefrence
                                          .child(requestData['requestedTo']
                                              ['proID'])
                                          .onValue,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.data.snapshot.value ==
                                                null)
                                          return Text(
                                            'username',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          );

                                        Map prosData =
                                            snapshot.data.snapshot.value;
                                        // print(userData['prosProfile']);
                                        return Text(
                                          prosData['prosName'],
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
                                    // textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.011,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  'Date:\n' + requestData['date'],
                                  style: GoogleFonts.shortStack(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.2,
                                ),
                                Text(
                                  'Time:\n' + requestData['time'],
                                  style: GoogleFonts.shortStack(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: size.height * 0.011,
                          // ),

                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          isRatingPending
                              ? InkWell(
                                  onTap: () async {
                                    double proRating = 1.00;
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                            horizontal: 25.0,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 15.0,
                                              horizontal: 20.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: kWhiteColour,
                                              border: Border.all(
                                                color: kBlackColour,
                                                style: BorderStyle.solid,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Rate Your Experience',
                                                  style: GoogleFonts.montserrat(
                                                    color: kBlackColour,
                                                    fontSize: 25.0,
                                                    letterSpacing: 1.3,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Divider(
                                                  thickness: 1.5,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                RatingBar.builder(
                                                  initialRating: 1,
                                                  glowColor: Colors.amber,

                                                  glowRadius: 1,
                                                  itemPadding:
                                                      EdgeInsets.all(2.5),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  // itemPadding: EdgeInsets.symmetric(
                                                  //     horizontal: 4.0),
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    EvaIcons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    proRating = rating;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Divider(
                                                  thickness: 1.5,
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  'Review Your Technician',
                                                  style: GoogleFonts.montserrat(
                                                    color: kBlackColour,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                TextField(
                                                  controller: textController
                                                      .reviewController,
                                                  maxLines: 3,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Write something about your technician',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: kBlackColour,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: kBlackColour,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomButton(
                                                        color: kBlackColour,
                                                        borderColour:
                                                            kBlackColour,
                                                        shadowcolor:
                                                            kWhiteColour,
                                                        ontap: () async {
                                                          showDialog(
                                                              barrierDismissible:
                                                                  false,
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
                                                                          SizedBox(
                                                                            height:
                                                                                20.0,
                                                                          ),
                                                                          Text(
                                                                              'Processing...',
                                                                              style: TextStyle(
                                                                                fontSize: 20.0,
                                                                                color: Colors.white,
                                                                              )),
                                                                        ],
                                                                      ));
                                                          await database
                                                              .updateRatingAndReview(
                                                            proID: requestData[
                                                                    'requestedTo']
                                                                ['proID'],
                                                            review: textController
                                                                .reviewController
                                                                .text
                                                                .trim(),
                                                            rating: proRating,
                                                            category:
                                                                requestData[
                                                                    'category'],
                                                            service:
                                                                requestData[
                                                                    'service'],
                                                          );
                                                          await database
                                                              .deleteRequest(
                                                            requestKey:
                                                                requestData[
                                                                    'requestKey'],
                                                          );
                                                          Get.back();
                                                          // return Container();
                                                          Get.back();
                                                        },
                                                        text: 'Confirm',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Expanded(
                                                      child: CustomButton(
                                                        color: kBlackColour,
                                                        borderColour:
                                                            kBlackColour,
                                                        shadowcolor:
                                                            kWhiteColour,
                                                        ontap: () => Get.back(),
                                                        text: 'Cancel',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    textController.reviewController.clear();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: size.height * 0.009,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xffD37B41),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          EvaIcons.messageCircleOutline,
                                          color: kWhiteColour,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),
                                        Text(
                                          // isAccepted ? 'Cancel' : 'Accept',
                                          'Rate and Review Your Experience',
                                          style: GoogleFonts.raleway(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: kWhiteColour,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : isAccepted
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Get.defaultDialog(
                                              title: 'Alert!',
                                              content: Text(
                                                  'Are you sure you want to continue?'),
                                              cancel: ElevatedButton(
                                                onPressed: () => Get.back(),
                                                child: Text('Cancel'),
                                              ),
                                              confirm: ElevatedButton(
                                                onPressed: () async {
                                                  Get.back();
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) =>
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircularProgressIndicator(
                                                                color:
                                                                    kBlackColour,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              SizedBox(
                                                                height: 20.0,
                                                              ),
                                                              Text(
                                                                  'Processing...',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20.0,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                            ],
                                                          ));

                                                  String token = await database
                                                      .getToken(requestData[
                                                              'requestedTo']
                                                          ['proID']);
                                                  await database
                                                      .cancelOnGoingRequest(
                                                    requestKey: requestData[
                                                        'requestKey'],
                                                    proID: requestData[
                                                        'requestedTo']['proID'],
                                                  );
                                                  Get.back();

                                                  try {
                                                    http.post(
                                                        Uri.parse(
                                                            'https://fcm.googleapis.com/fcm/send'),
                                                        headers: <String,
                                                            String>{
                                                          'Content-Type':
                                                              'application/json; charset=UTF-8',
                                                          'Authorization':
                                                              "$key",
                                                        },
                                                        body: jsonEncode(
                                                          {
                                                            "notification": {
                                                              "body":
                                                                  "Your request was cancelled",
                                                              "title":
                                                                  "Request Cancelled",
                                                              "android_channel_id":
                                                                  "high_importance_channel"
                                                            },
                                                            "priority": "high",
                                                            "data": {
                                                              "click_action":
                                                                  "FLUTTER_NOTIFICATION_CLICK",
                                                              "status": "done"
                                                            },
                                                            "to": "$token"
                                                          },
                                                        ));
                                                    print(
                                                        'FCM request for device sent!');
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                },
                                                child: Text('Ok'),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.0,
                                              vertical: size.height * 0.009,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              color: Color(0xFFDA5D59),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  EvaIcons.close,
                                                  color: kWhiteColour,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.01,
                                                ),
                                                Text(
                                                  'Cancel',
                                                  style: GoogleFonts.raleway(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: kWhiteColour,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15.0),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Get.to(ChatScreen(
                                                proID:
                                                    requestData['requestedTo']
                                                        ['proID']));
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.0,
                                              vertical: size.height * 0.009,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              color: Color(0xFF59B1DA),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  EvaIcons.messageCircleOutline,
                                                  color: kWhiteColour,
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
                                                    color: kWhiteColour,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        Get.defaultDialog(
                                          title: 'Alert!',
                                          content: Text(
                                              'Are you sure you want to continue?',
                                              textAlign: TextAlign.center),
                                          cancel: ElevatedButton(
                                            onPressed: () => Get.back(),
                                            child: Text('Cancel'),
                                          ),
                                          confirm: ElevatedButton(
                                            onPressed: () async {
                                              Get.back();
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) => Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircularProgressIndicator(
                                                            color: kBlackColour,
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          Text('Processing...',
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        ],
                                                      ));
                                              await database.cancelRequest(
                                                requestKey:
                                                    requestData['requestKey'],
                                                proID:
                                                    requestData['requestedTo']
                                                        ['proID'],
                                              );
                                              Get.back();
                                            },
                                            child: Text('Ok'),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.0,
                                          vertical: size.height * 0.009,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          color: Color(0xFFDA5D59),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              EvaIcons.close,
                                              color: kWhiteColour,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Text(
                                              'Cancel',
                                              style: GoogleFonts.raleway(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: kWhiteColour,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                          SizedBox(
                            height: 10.0,
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
