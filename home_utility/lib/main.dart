import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'screens/registrationScreen.dart';
import 'screens/logInScreen.dart';
import 'screens/mainScreen.dart';
import 'screens/detailsScreen.dart';
import 'screens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/userAuthentication.dart';
import 'model/database.dart';

//TODO: probably make another file to store all these resuable accessories

int userRequestCounter;

String newRequestKey;

List requestKeysForThisSession = [];

final userAuthentication = UserAuthentication();

Database database = Database();

DatabaseReference usersRefrence =
    FirebaseDatabase.instance.reference().child('users');

DatabaseReference requestRefrence =
    FirebaseDatabase.instance.reference().child('requests');

String formatTime({TimeOfDay unformattedTime}) {
  String time = '';

  if (unformattedTime.hourOfPeriod <= 9) {
    if (unformattedTime.hour == 12) {
      time += '${unformattedTime.hour}';
    } else
      time += '0${unformattedTime.hourOfPeriod}';
  } else
    time += '${unformattedTime.hourOfPeriod}';

  if (unformattedTime.minute <= 9)
    time += ':0${unformattedTime.minute}';
  else
    time += ':${unformattedTime.minute}';
  String periodOfDay = unformattedTime.period == DayPeriod.am ? ' am' : ' pm';
  return time + periodOfDay;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(HomeUtility());
}

class HomeUtility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: WelcomeScreen(),
      initialRoute: LogInScreen.id,
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(
            Colors.white,
          ),

          thickness: MaterialStateProperty.all(
            6,
          ),
          radius: Radius.circular(10.0),
          // isAlwaysShown: true,
          showTrackOnHover: true,
          trackColor: MaterialStateProperty.all(Colors.white),
        ),
        primarySwatch: Colors.red,
      ),
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(
          name: WelcomeScreen.id,
          page: () => WelcomeScreen(),
        ),
        GetPage(
          curve: Curves.easeIn,
          transition: Transition.downToUp,
          name: LogInScreen.id,
          page: () => LogInScreen(),
        ),
        GetPage(
          curve: Curves.easeIn,
          transition: Transition.upToDown,
          name: RegistrationScreen.id,
          page: () => RegistrationScreen(),
        ),
        GetPage(
          name: MainScreen.id,
          page: () => MainScreen(),
        ),
        GetPage(
          name: DetailsScreen.id,
          page: () => DetailsScreen(),
        ),
      ],
    );
  }
}
