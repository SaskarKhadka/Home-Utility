import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';
import 'package:home_utility_pro/screens/tabPages/userProfile.dart';
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
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(
          //       top: 8.0,
          //       left: 20.0,
          //       right: 15.0,
          //     ),
          //     child: Icon(
          //       Icons.more_vert,
          //       // color: Color(0xff131313),
          //       color: Colors.white,
          //       size: 30,
          //     ),
          //   ),
          // ],
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

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder(
        stream: prosRefrence.child(userAuthentication.userID).onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map prosData = snapshot.data.snapshot.value;
          return ListView(
            children: <Widget>[
              Container(
                height: 190.0,
                child: DrawerHeader(
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color(0xFF130F22),
                    Color(0xFF19152E),
                    Color(0xFF1C182E),
                    Color(0xFF2A263D),
                  ])),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        // Material(
                        //   borderRadius:
                        //       BorderRadius.all(Radius.circular(50.0)),
                        //   color: kBlackColour,
                        //   // elevation: 10,
                        //   // child: Padding(
                        //   // padding: EdgeInsets.all(8.0),
                        CircleAvatar(
                          radius: 50.0,
                          backgroundColor: kBlackColour,
                          backgroundImage: AssetImage('images/person.png'),
                        ),
                        // ),
                        SizedBox(height: 10),
                        // ),
                        // Padding(
                        // padding: EdgeInsets.all(8.0),
                        Text('HI, ' + prosData['prosName'].toUpperCase(),
                            style: GoogleFonts.maitree(
                                fontSize: 16, color: Colors.white70)),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              CustomListTile(Icons.person_outline, 'Profile', () => {}),
              CustomListTile(Icons.info_outline, 'About', () => {}),
              CustomListTile(Icons.help_outline, 'Help', () => {}),
              CustomListTile(Icons.lock_outline, 'Sign Out', () => {}),
            ],
          );
        },
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.grey[700],
            onTap: onTap,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: kBlackColour,
                        child: Center(
                          child: Icon(
                            icon,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          text,
                          style: GoogleFonts.mada(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: kBlackColour,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class UserRequestsStream extends StatefulWidget {
  @override
  _UserRequestsStreamState createState() => _UserRequestsStreamState();
}

class _UserRequestsStreamState extends State<UserRequestsStream> {
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
                                      // // if (data[index]['state'] == 'pending')
                                      // //   isAccepted = false;
                                      // // else
                                      // //   isAccepted = true;
                                      // setState(() {
                                      //   isAccepted = !isAccepted;
                                      // });
                                      // isAccepted
                                      //     ?
                                      await database.changeAcceptedState(
                                        requestKey: requestData['requestKey'],
                                        state: true,
                                      );

                                      await database.saveRequestAsJob(
                                        requestKey: requestData['requestKey'],
                                      );
                                      // : await database.changeState(
                                      //     userID: data[index]['uid'],
                                      //     category: data[index]['category'],
                                      //     requestKey: data[index]['requestKey'],
                                      //     state: 'pending');
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
