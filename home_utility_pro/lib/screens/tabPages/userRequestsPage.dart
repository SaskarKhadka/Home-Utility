import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/dialogBox.dart';
import 'package:home_utility_pro/components/drawerItems.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_utility_pro/screens/logInScreen.dart';
import 'package:home_utility_pro/screens/tabPages/popUpMenuPages/about.dart';
import 'package:home_utility_pro/screens/tabPages/popUpMenuPages/help.dart';
import '../../constants.dart';
import '../../main.dart';

class UserRequestsPage extends StatelessWidget {
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => DialogBox(
          title: 'Signing Out',
        ),
      );
      await userAuthentication.signOut();
      Get.offAndToNamed(LogInScreen.id);

      break;
  }
}

class UserRequestsStream extends StatelessWidget {
  // bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
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
        int totalRequests = 0;
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
                  stream: database.requestDataStream(requestKey: data[index]),
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
                    if (now.isAfter(requestDateTime)) {
                      database.deleteRequest(
                        requestKey: requestData['requestKey'],
                      );
                    }
                    if (requestData['state'] == 'pending') {
                      totalRequests++;
                      // if (data[index]['state']['state'] == 'pending')
                      //   isAccepted = false;
                      // else
                      //   isAccepted = true;
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
                                height: size.height * 0.011,
                              ),
                              // Row(
                              // children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await database.changeState(
                                        requestKey: requestData['requestKey'],
                                        state: 'accepted',
                                      );
                                      await database.changeAcceptedState(
                                        requestKey: requestData['requestKey'],
                                        state: true,
                                      );

                                      await database.saveRequestAsJob(
                                        requestKey: requestData['requestKey'],
                                      );

                                      String token = await database.getToken(
                                          requestData['requestedBy']['userID']);
                                      try {
                                        await http.post(
                                            Uri.parse(
                                                'https://fcm.googleapis.com/fcm/send'),
                                            headers: <String, String>{
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'Authorization': "$key",
                                            },
                                            body: jsonEncode(
                                              {
                                                "notification": {
                                                  "body":
                                                      "Your request has been accepted",
                                                  "title": "Request Accepted",
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
                                        print('FCM request for device sent!');
                                      } catch (e) {
                                        print(e);
                                      }
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
                                            // isAccepted
                                            // ? EvaIcons.close :
                                            EvaIcons.checkmark,
                                            color: kBlackColour,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Text(
                                            // isAccepted ? 'Cancel' : 'Accept',
                                            'Accept',
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
                                      await database.changeState(
                                        requestKey: requestData['requestKey'],
                                        state: 'rejected',
                                      );
                                      await database.deleteRequest(
                                        requestKey: requestData['requestKey'],
                                      );

                                      String token = await database.getToken(
                                          requestData['requestedBy']['userID']);
                                      try {
                                        http.post(
                                            Uri.parse(
                                                'https://fcm.googleapis.com/fcm/send'),
                                            headers: <String, String>{
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'Authorization': "$key",
                                            },
                                            body: jsonEncode(
                                              {
                                                "notification": {
                                                  "body":
                                                      "Your request has been rejected",
                                                  "title": "Request Rejected",
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
                                        print('FCM request for device sent!');
                                      } catch (e) {
                                        print(e);
                                      }
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
                                            // isAccepted
                                            // ? EvaIcons.close :
                                            EvaIcons.close,
                                            color: kBlackColour,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Text(
                                            // isAccepted ? 'Cancel' : 'Accept',
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
                                ],
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (index == data.length - 1 && totalRequests == 0)
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.3,
                          ),
                          child: Text(
                            'You have no requests',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      );
                    else
                      return Container();
                  });
            },
          ),
        );
      },
    );
  }
}
