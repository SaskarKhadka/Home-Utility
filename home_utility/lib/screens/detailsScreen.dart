import 'package:home_utility/components/roundedButton.dart';

import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_utility/constants.dart';

class DetailsScreen extends StatelessWidget {
  static const id = '/details';

  @override
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
              width: MediaQuery.of(context).size.height * 0.5,
              height: MediaQuery.of(context).size.height * 0.49,
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
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: '(Date) ya dropdown halnu parxa',
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: '(Time) ya dropdown halnu parxa',
                      ),
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

  void _getDialog() {
    Get.defaultDialog(
      title: 'Order Placed!',
      titleStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
      ),
      barrierDismissible: false,
      middleText: 'Your order has been placed',
      onConfirm: () {
        Get.back();
      },
    );
  }
}
