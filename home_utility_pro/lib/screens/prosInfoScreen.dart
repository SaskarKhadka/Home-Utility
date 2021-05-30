import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility_pro/main.dart';
import 'package:home_utility_pro/screens/mainScreen.dart';

class ProsInfoScreen extends StatefulWidget {
  static String id = '/prosInfoScreen';
  @override
  _ProsInfoScreenState createState() => _ProsInfoScreenState();
}

class _ProsInfoScreenState extends State<ProsInfoScreen> {
  final TextEditingController professionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
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
                  prosProfessionValue = professionController.text.trim();
                  database.updateProfession(professionController.text.trim());
                  Get.toNamed(MainScreen.id);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
