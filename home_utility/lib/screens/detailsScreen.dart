import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../components/customTextField.dart';
import '../components/roundedButton.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DetailsScreen extends StatefulWidget {
  static const id = '/details';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final addressController = TextEditingController();
  DateTime pickedDate;
  TimeOfDay selectedTime;

  @override
  void dispose() {
    // TODO: implement dispose
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // try {
    //   usersRefrence
    //       .child(userAuthentication.userID)
    //       .child('requests')
    //       .once()
    //       .then((value) {
    //     if (value.value != null) {
    //       Map.from(value.value).forEach((key, value) {
    //         requestKeysForThisSession.add(key);
    //       });
    //     }
    //   });
    // } catch (e) {}

    pickedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        requestKeysForThisSession.clear();
        newRequestKey = Uuid().v1();

        await database.saveRequest(
            id: newRequestKey,
            service: Get.parameters['service'],
            address: addressController.text.trim(),
            date: pickedDate,
            time: selectedTime);
        // userRequestCounter = database.totalUserRequests;
        print(userRequestCounter);
      },
    );
  }
}
