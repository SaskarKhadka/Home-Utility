import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../main.dart';

class AcceptedRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // database.totalUsersRequests();

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlackColour,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.black, Colors.grey[700]])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset('images/img-1.jpg',
                              width: 80, height: 80),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'User',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CustomListTile(Icons.person, 'Profile', () => {}),
              CustomListTile(Icons.info, 'About', () => {}),
              CustomListTile(Icons.help, 'Help', () => {}),
              CustomListTile(Icons.lock, 'Sign Out', () => {}),
            ],
          ),
        ),
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
            onTap: () => {},
            child: Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_right),
                ],
              ),
            )),
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

              return FutureBuilder(
                future: database.requestData(requestKey: data[index]),
                builder: (context, snapshot) {
                  // if (!snapshot.hasData) {
                  //   return Center(
                  //     child: Text(
                  //       'You have no requests',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 25,
                  //       ),
                  //     ),
                  //   );
                  // }
                  Map requestData = snapshot.data;

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
                    height: size.height * 0.3,
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
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.011,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await database.changeState(
                                    category: requestData['category'],
                                    requestKey: requestData['requestKey'],
                                    state: 'pending',
                                  );

                                  await database.deleteJob(
                                    requestKey: requestData['requestKey'],
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
                              SizedBox(
                                width: 15.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    Dialog(
                                      backgroundColor: kWhiteColour,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 20.0,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Customer Profile'.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 25.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'NAME: NAME',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'EMAIL: EMAIL',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'PHONE NO.: PHONE NUMBER',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'ADDRESS: %ADDRESS%',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            GestureDetector(
                                              onTap: () => Get.back(),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 20.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: kBlackColour,
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                              )
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
