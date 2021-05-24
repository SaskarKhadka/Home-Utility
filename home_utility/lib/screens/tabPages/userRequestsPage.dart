import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
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
    } else if (newRequestKey != null) {
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
    scaffoldBody = Column(
      children: [
        Text('You have no requests'),
      ],
    );
    if (!isQueryNull) {
      scaffoldBody = FirebaseAnimatedList(
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

          return Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Card(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.03,
                ),
                child: Card(
                  // color: Colors.red[100],
                  // elevation: 3,
                  margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.005,
                    horizontal: size.width * 0.009,
                  ),

                  color: Colors.red[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.011,
                      // horizontal: size.height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          requestMap['service'],
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: size.height * 0.011,
                        ),
                        Text(
                          'Date: ' + requestMap['date'],
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: size.height * 0.011,
                        ),
                        Text(
                          'Time: ' + requestMap['time'],
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.145,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.375,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // shape: BoxShape.circle,
                          primary: Color(0xFFFF0005),
                        ),
                        onPressed: () {
                          database.deleteRequest(requestMap['requestKey']);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              EvaIcons.close,
                              size: 20,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text('Cancel'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('My Requests'),
        centerTitle: true,
      ),
      body: scaffoldBody,
    );
  }
}
