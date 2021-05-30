import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../constants.dart';
import '../main.dart';
import 'customButton.dart';
import 'customTextField.dart';

class DetailsDialog extends StatefulWidget {
  final String service;
  DetailsDialog({this.service});
  @override
  _DetailsDialogState createState() => _DetailsDialogState();
}

class _DetailsDialogState extends State<DetailsDialog> {
  final _addressController = TextEditingController();
  DateTime _pickedDate;
  TimeOfDay _selectedTime;

  @override
  void dispose() {
    // TODO: implement dispose
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pickedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: kBlackColour.withOpacity(0.6),
        child: Container(
          decoration: BoxDecoration(
            color: kWhiteColour,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            border: Border.all(
              color: kBlackColour,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          // insetPadding: EdgeInsets.all(25.0),
          // backgroundColor: kWhiteColour,
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20.0),
          //     side: BorderSide(
          //       color: kBlackColour,
          //       width: 2.0,
          //       style: BorderStyle.solid,
          //     )),
          // elevation: 10.0,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 15.0,
              bottom: 25.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.service,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    color: kBlackColour,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  'When would you like us to come?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: kBlackColour.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomTextField(
                  hintText: 'Enter your address',
                  icon: EvaIcons.home,
                  isPhoneNumber: false,
                  textController: _addressController,
                  labelText: 'ADDRESS',
                  // onChanged: null,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                ListTile(
                  // tileColor: Colors.blue,
                  title: Text(
                    "Date: ${_pickedDate.year}/${_pickedDate.month}/${_pickedDate.day}",
                    style: GoogleFonts.juliusSansOne(
                      fontSize: 17.0,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickDate,
                ),
                ListTile(
                  minVerticalPadding: 5,
                  // tileColor: Colors.red,
                  title: Text(
                    "Time: ${formatTime(unformattedTime: _selectedTime)}",
                    style: GoogleFonts.juliusSansOne(
                      fontSize: 17.0,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _selectTime,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      // color: Colors.white,
                      text: 'Confirm',
                      onTap: _getDialog,
                      // color: Colors.red,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    CustomButton(
                      // color: Colors.white,
                      text: 'Cancel',
                      onTap: () => Get.back(),
                      // color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: _pickedDate,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 29),
      // lastDate: DateTime(DateTime.now().month + 5),
    );
    if (date != null)
      setState(() {
        _pickedDate = date;
      });
  }

  _selectTime() async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != _selectedTime)
      setState(() {
        _selectedTime = pickedTime;
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
            service: widget.service,
            address: _addressController.text.trim(),
            date: _pickedDate,
            time: _selectedTime);
        // userRequestCounter = database.totalUserRequests;
        print(userRequestCounter);
      },
    );
  }
}
