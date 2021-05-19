import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.lightBlueAccent,
      elevation: 10.0,
      insetAnimationDuration: Duration(seconds: 5),
      // insetPadding: EdgeInsets.all(25.0),
      child: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
              // value: 1000.0,
              // backgroundColor: Colors.lightBlueAccent,
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Authenticating...Please Wait...',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
