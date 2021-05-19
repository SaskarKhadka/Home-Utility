import 'package:home_utility/components/roundedButton.dart';
import 'package:home_utility/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> saveRequest() async {
  //TODO: To the userInfo map, add type of job, date and time, (address too if we can't implement the adress directly)
  String userID = userAuthentication.userID;
  Map userInfo = await database.getUserInfo(userID);
  requestRefrence.child('Request ${++requestCounter}').set(userInfo);
}

deleteRequest() {}
class DetailsScreen extends StatefulWidget {
  static const id = '/details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {
  DateTime pickedDate;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Get.parameters['imgPath'],
            fit: BoxFit.fill,
          ),
          Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.49,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Get.parameters['service'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'When would you like us to come?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ListTile(
                      title: Text("Date: ${pickedDate.year}/${pickedDate
                          .month}/${pickedDate.day}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _pickDate,
                    ),
                    ListTile(
                      title: Text("Time: ${selectedTime.hour}:${selectedTime.minute} "),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _selectTime,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),

                    Flexible(
                      child: RoundedButton(
                        text: 'Confirm',
                        onPressed: _getDialog,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime
          .now()
          .year - 5),
      lastDate: DateTime(DateTime
          .now()
          .year + 5),
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }
  _selectTime() async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

    if (picked_s != null && picked_s != selectedTime )
      setState(() {
        selectedTime = picked_s;
      });
  }
}

  void _getDialog() {
    Get.defaultDialog(
      title: 'Request Placed!',
      titleStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
      ),
      barrierDismissible: false,
      middleText: 'Your request has been placed',
      onConfirm: () async {
        Get.back();
        CircularProgressIndicator(
          backgroundColor: Colors.blue,
        );
        await saveRequest();
      },
    );
  }

