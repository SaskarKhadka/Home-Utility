import 'package:home_utility/components/roundedButton.dart';
import 'package:home_utility/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  static const id = '/details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DateTime pickedDate;
  TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page_sharp),
            label: 'New Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page_outlined),
            label: 'My Requests',
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            Get.parameters['imgPath'],
            fit: BoxFit.fill,
          ),
          Center(
            child: Container(
              width: size.height * 0.45,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      height: size.height * 0.02,
                    ),
                    Text(
                      'When would you like us to come?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ListTile(
                      title: Text(
                          "Date: ${pickedDate.year}/${pickedDate.month}/${pickedDate.day}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _pickDate,
                    ),
                    ListTile(
                      title: Text(
                          "Time: ${formatTime(unformattedTime: selectedTime)}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _selectTime,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
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
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 29),
      // lastDate: DateTime(DateTime.now().month + 5),
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  _selectTime() async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
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
        await database.saveRequest(
            service: Get.parameters['service'],
            date: pickedDate,
            time: selectedTime);
      },
    );
  }
}
