import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_utility_pro/components/customTextField.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/model/services.dart';
import 'package:home_utility_pro/model/servicesHandler.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';

import '../constants.dart';

class ProsInfoScreen extends StatefulWidget {
  static String id = '/prosInfoScreen';
  @override
  _ProsInfoScreenState createState() => _ProsInfoScreenState();
}

class _ProsInfoScreenState extends State<ProsInfoScreen> {
  final TextEditingController professionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // ServiceHandler _serviceHandler = ServiceHandler();
  String value;

  @override
  void initState() {
    // TODO: implement initState
    value = 'Electronics Technician';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: kBlackColour,
        body: Column(
          children: [
            Text('Please fill up your info'),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'This is pro\'s info scren',
                    ),
                    TextField(
                      controller: professionController,
                      decoration: InputDecoration(
                        hintText: 'Enter your profession',
                        labelText: 'Profession',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        prosProfessionValue = value.trim();
                        database.updateProfession(prosProfessionValue);
                        category = professionToCategory(prosProfessionValue);
                        Get.offAndToNamed(MainScreen.id);
                      },
                      child: Text('Submit'),
                    ),
                    CustomTextField(
                      textController: addressController,
                      isPhoneNumber: false,
                      icon: EvaIcons.homeOutline,
                      labelText: 'Enter your municipality/VDC',
                    ),
                    DropdownButton<String>(
                      style: GoogleFonts.robotoMono(
                        color: kBlackColour,
                      ),
                      elevation: 20,
                      // focusColor: kBlackColour,
                      items: _getDropDownMenuItems(),
                      value: value,
                      onChanged: (newvalue) {
                        setState(() {
                          value = newvalue;
                        });
                      },
                      // dropdownColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    List<String> professions = [
      'Electronics Technician',
      'Beautician',
      'House Worker'
    ];

    for (String profession in professions) {
      items.add(
        DropdownMenuItem<String>(
          child: Text(profession),
          value: profession,
        ),
      );
    }
    return items;
  }
}
