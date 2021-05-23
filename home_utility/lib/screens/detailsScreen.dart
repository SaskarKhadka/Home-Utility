import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:home_utility/components/customTextField.dart';
import 'package:home_utility/components/roundedButton.dart';
import 'package:home_utility/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DetailsScreen extends StatefulWidget {
  static const id = '/details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String uniqueID;
  final addressController = TextEditingController();
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
        onTap: (index) {
          if (index == 1)
            Get.to(
              RequestStream(
                requestKey: uniqueID,
              ),
            );
          else
            Get.to(DetailsScreen());
        },
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              Get.parameters['imgPath'],
              fit: BoxFit.fill,
            ),
            Center(
              child: Container(
                width: size.height * 0.45,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
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
                      CustomTextField(
                        hintText: 'Enter your address',
                        icon: EvaIcons.homeOutline,
                        controller: addressController,
                        lableText: 'ADDRESS',
                        obsecure: false,
                        onChanged: null,
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
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
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
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
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
        uniqueID = Uuid().v1();
        userRequestCounter = await database.totalUserRequests;
        await database.saveRequest(
            id: uniqueID,
            service: Get.parameters['service'],
            address: addressController.text.trim(),
            date: pickedDate,
            time: selectedTime);
      },
    );
  }
}

class RequestStream extends StatefulWidget {
  final requestKey;
  RequestStream({this.requestKey});
  @override
  _RequestStreamState createState() => _RequestStreamState();
}

class _RequestStreamState extends State<RequestStream> {
  Query _query;
  @override
  void initState() {
    database.requestQuery(widget.requestKey).then((Query query) {
      setState(() {
        _query = query;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffoldBody = Column(
      children: [
        Text('You have no requests'),
      ],
    );
    if (_query != null) {
      scaffoldBody = FirebaseAnimatedList(
        query: _query,
        itemBuilder: (
          BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index,
        ) {
          // String mountainKey = snapshot.key;

          Map key = snapshot.value;

          // key.forEach((key, value) {
          //   if (key == 'service') dataMap['service'] = value;
          //   if (key == 'date') dataMap['date'] = value;
          //   if (key == 'time') dataMap['time'] = value;
          // });

          return Column(
            children: [
              ListTile(
                leading: Text(
                  'You requested for a ' + key['service'] + ' service',
                  style: TextStyle(fontSize: 13),
                ),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text('Reject'),
                ),
              ),
              Divider(
                height: 2.0,
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
