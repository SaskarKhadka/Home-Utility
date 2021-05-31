import 'package:flutter/material.dart';
import '../constants.dart';

class DialogBox extends StatelessWidget {
  final String title;
  DialogBox({this.title});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // insetAnimationCurve: Curves.elasticInOut,
      backgroundColor: Color(0xff131313),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      elevation: 10.0,
      // insetAnimationDuration: Duration(seconds: 3),
      // insetPadding: EdgeInsets.all(25.0),
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.0),
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
              title + '...Please Wait...',
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
