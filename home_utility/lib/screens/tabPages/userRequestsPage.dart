import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility/components/customButton.dart';
import 'package:home_utility/constants.dart';
import '../../main.dart';

class UserRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    database.totalUsersRequests();

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

class UserRequestsStream extends StatefulWidget {
  @override
  _UserRequestsStreamState createState() => _UserRequestsStreamState();
}

class _UserRequestsStreamState extends State<UserRequestsStream> {
  TextEditingController _reviewController;
  bool isAccepted = false;
  bool isRatingPending = false;
  // double proRating;

  @override
  void initState() {
    // TODO: implement initState
    _reviewController = TextEditingController();
    // proRating = 1.0;
    super.initState();
  }

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
        Map messages = snapshot.data.snapshot.value;

        // ref.update(messages);
        // print(snapshot.data.snapshot.value);
        // print(messages);
        // if (messages != null) {
        List<Map> data = [];
        messages.forEach((key, value) {
          data.add(value as Map);
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
              // if (DateTime.now().isAfter(data[index]['dateTimeNow'])) {
              // database.deleteRequest(
              //   category: data[index]['category'],
              //   requestKey: data[index]['requestKey'],
              // );
              //   return Container();
              // }
              String value = data[index]['dateTime'];
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

              if (data[index]['state']['state'] == 'pending')
                isAccepted = false;
              else
                isAccepted = true;

              // print(isAccepted);

              if (isAccepted && now.isAfter(requestDateTime)) {
                isRatingPending = true;
              }
              if (!isAccepted && now.isAfter(requestDateTime)) {
                database.deleteRequest(
                  category: data[index]['category'],
                  requestKey: data[index]['requestKey'],
                );
                return Container();
              }

              if (isAccepted &&
                  now.difference(requestDateTime) >= Duration(minutes: 30)) {
                database.deleteRequest(
                  category: data[index]['category'],
                  requestKey: data[index]['requestKey'],
                );
                return Container();
              }

              return Container(
                height: isAccepted
                    ? isRatingPending
                        ? size.height * 0.23
                        : size.height * 0.29
                    : size.height * 0.23,
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
                        data[index]['service'],
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
                        'Date: ' + data[index]['date'],
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
                        'Time: ' + data[index]['time'],
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
                                double proRating = 1;
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
                                              itemPadding: EdgeInsets.all(2.5),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              // itemPadding: EdgeInsets.symmetric(
                                              //     horizontal: 4.0),
                                              itemBuilder: (context, index) =>
                                                  Icon(
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
                                              controller: _reviewController,
                                              maxLines: 3,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Write something about your technician',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: kBlackColour,
                                                    style: BorderStyle.solid,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: kBlackColour,
                                                    style: BorderStyle.solid,
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
                                                    onTap: () async {
                                                      await database
                                                          .updateRatingAndReview(
                                                        proID: data[index]
                                                            ['state']['uid'],
                                                        review:
                                                            _reviewController
                                                                .text
                                                                .trim(),
                                                        rating: proRating,
                                                      );
                                                      database.deleteRequest(
                                                        category: data[index]
                                                            ['category'],
                                                        requestKey: data[index]
                                                            ['requestKey'],
                                                      );
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
                                                    onTap: () => Get.back(),
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
                          : Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await database.deleteRequest(
                                      category: data[index]['category'],
                                      requestKey: data[index]['requestKey'],
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
                                isAccepted
                                    ? GestureDetector(
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Pro\'s Profile'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      'NAME: ${data[index]['state']['prosName']}',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      'EMAIL: ${data[index]['state']['prosEmail']}',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                      'PHONE NO.: ${data[index]['state']['prosPhoneNo']}',
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
                                      )
                                    : Container(),
                              ],
                            ),
                      SizedBox(
                        height: 10.0,
                      ),
                      isAccepted
                          ? isRatingPending
                              ? Container()
                              : InkWell(
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
                                )
                          : Container()
                    ],
                  ),
                ),
              );
              // }
            },
          ),
        );
      },
    );
  }
}
