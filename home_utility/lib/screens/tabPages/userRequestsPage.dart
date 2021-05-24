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

          return Card(
            elevation: 3,
            margin: EdgeInsets.only(
              bottom: 10,
              // top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    requestMap['service'],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ListTile(
                  leading: Text('Date: ' + requestMap['date']),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text('Change Date'),
                  ),
                ),
                ListTile(
                  leading: Text('Time: ' + requestMap['time']),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text('Change Time'),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF0005),
                  ),
                  onPressed: () {
                    database.deleteRequest(requestMap['requestKey']);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Reject'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
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
