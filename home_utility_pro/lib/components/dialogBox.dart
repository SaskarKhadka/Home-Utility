import 'package:flutter/material.dart';
import '../constants.dart';

class DialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // insetAnimationCurve: Curves.elasticInOut,
      backgroundColor: Color(0xff131313),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10.0,
      // insetAnimationDuration: Duration(seconds: 3),
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
              valueColor: AlwaysStoppedAnimation<Color>(
                kBlackColour,
              ),
              // value: 0.5,
              backgroundColor: kBlackColour.withOpacity(0.5),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Authenticating...Please Wait...',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: kBlackColour,
              ),
            )
          ],
        ),
      ),
    );
  }
}
