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
import 'package:home_utility/screens/loginscreen.dart';
import 'package:home_utility/screens/popUpPages/about.dart';
import 'package:home_utility/screens/popUpPages/help.dart';
import '../../main.dart';


class UserRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    database.totalUsersRequests();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // drawer: Container(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          toolbarHeight: 67,
          elevation: 2,
          shadowColor: Colors.white,
          // automaticallyImplyLeading: false,
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
          title: Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              left: 16.0,
            ),
            child: Text(
              'My Requests',
              style: GoogleFonts.montserrat(
                // color: Color(0xff131313),
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        body: Scrollbar(
          child: UserRequestsStream(),
        ),
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

                  if (requestData['state'] == 'rejected') {
                    database.deleteRequest(
                      requestKey: requestData['requestKey'],
                    );
                    return Container();
                  }

                  bool isAccepted = requestData['isAccepted'];

                  bool isRatingPending = requestData['isRatingPending'];

                  if (isAccepted && now.isAfter(requestDateTime)) {
                    isRatingPending = true;
                  }

                  if (!isAccepted && now.isAfter(requestDateTime)) {
                    database.deleteRequest(
                      requestKey: requestData['requestKey'],
                    );
                    return Container();
                  }

                  if (isAccepted &&
                      now.difference(requestDateTime) >= Duration(minutes: 1)) {
                    database.deleteRequest(
                      requestKey: requestData['requestKey'],
                    );
                    return Container();
                  }

                  return Container(
                    height: size.height * 0.23,
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
                        mainAxisSize: MainAxisSize.min,
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
                                          'Rate and Review Your Experience',
                                          style: GoogleFonts.raleway(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: kBlackColour,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : isAccepted
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              GetProsInfo(
                                                proID:
                                                    requestData['requestedTo']
                                                        ['proID'],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.0,
                                              vertical: size.height * 0.009,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                                  'Pro\'s Profile',
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
                                                proID:
                                                    requestData['requestedTo']
                                                        ['proID']));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.0,
                                              vertical: size.height * 0.009,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) => Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ));
                                        await database.cancelRequest(
                                          requestKey: requestData['requestKey'],
                                          proID: requestData['requestedTo']
                                              ['proID'],
                                        );
                                        Get.back();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical: size.height * 0.009,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                              EvaIcons.close,
                                              color: kBlackColour,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Text(
                                              'Cancel',
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
