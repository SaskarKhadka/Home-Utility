import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/constants.dart';
import '../../main.dart';

class UserRequestsPage extends StatefulWidget {
  @override
  _UserRequestsPageState createState() => _UserRequestsPageState();
}

class _UserRequestsPageState extends State<UserRequestsPage> {
  Query _query;
  bool isQueryNull = true;
  int requestCount;
  @override
  void initState() {
    String temp;
    print(userRequestCounter);
    // userRequestCounter = database.totalUserRequests;
    database.totalUsersRequests();

    if (newRequestKey == null && requestKeysForThisSession.isNotEmpty) {
      temp = requestKeysForThisSession[0];
      database.requestQuery(temp).then((Query query) {
        setState(() {
          _query = query;
          isQueryNull = false;
        });
      });
    } else if (newRequestKey != null && requestKeysForThisSession.isNotEmpty) {
      temp = newRequestKey;
      database.requestQuery(temp).then((Query query) {
        setState(() {
          _query = query;
          isQueryNull = false;
        });
      });
    } else {
      isQueryNull = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget scaffoldBody;
    scaffoldBody = Center(
      child: Text(
        'You have no requests',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    if (!isQueryNull) {
      scaffoldBody = FirebaseAnimatedList(
        // controller: _scrollController,
        query: _query,
        itemBuilder: (
          BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index,
        ) {
          // ++userRequestCounter;
          // String mountainKey = snapshot.key;

          Map requestMap = snapshot.value;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // children: [
                  Text(
                    requestMap['service'],
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
                    'Date: ' + requestMap['date'],
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
                    'Time: ' + requestMap['time'],
                    style: TextStyle(
                      fontSize: size.height * 0.021,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      database.deleteRequest(requestMap['requestKey']);
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
                            EvaIcons.close,
                            color: kBlackColour,
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Cancel',
                            style: GoogleFonts.raleway(
                              fontSize: 16.0,
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
            ),
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColour,
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
              child: Icon(
                Icons.more_vert,
                // color: Color(0xff131313),
                color: Colors.white,
                size: 30,
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
                fontSize: 35,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        body: Scrollbar(
          child: scaffoldBody,
        ),
      ),
    );
  }
}
