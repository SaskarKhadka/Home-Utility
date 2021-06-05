import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:home_utility_pro/screens/confirmEmail.dart';
import 'package:home_utility_pro/screens/prosInfoScreen.dart';
import 'screens/registrationScreen.dart';
import 'screens/logInScreen.dart';
import 'screens/mainScreen.dart';
import 'screens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/userAuthentication.dart';
import 'model/database.dart';
import 'screens/forgotPassword.dart';

//TODO: probably make another file to store all these resuable accessories

final userAuthentication = UserAuthentication();

Database database = Database();

String prosProfessionValue;

String category;

DatabaseReference prosRefrence =
    FirebaseDatabase.instance.reference().child('pros');

DatabaseReference usersRefrence =
    FirebaseDatabase.instance.reference().child('users');

DatabaseReference requestRefrence =
    FirebaseDatabase.instance.reference().child('requests');

String professionToCategory(String profession) {
  String category;
  if (profession.toLowerCase() == 'electronics technician')
    category = 'repair';
  else if (profession.toLowerCase() == 'beautician')
    category = 'beauty';
  else if (profession.toLowerCase() == 'householdChores')
    category = 'householdChores';
  else
    category = '';
  return category;
}

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

Query myQuery;
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
      initialRoute: WelcomeScreen.id,
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
        primarySwatch: MaterialColor(
          0xff131313,
          <int, Color>{
            50: Color(0xff131313).withOpacity(0.1), //10%
            100: Color(0xff131313).withOpacity(0.2), //20%
            200: Color(0xff131313).withOpacity(0.3), //30%
            300: Color(0xff131313).withOpacity(0.4), //40%
            400: Color(0xff131313).withOpacity(0.5), //50%
            500: Color(0xff131313).withOpacity(0.6), //60%
            600: Color(0xff131313).withOpacity(0.7), //70%
            700: Color(0xff131313).withOpacity(0.8), //80%
            800: Color(0xff131313).withOpacity(0.9), //90%
            900: Color(0xff131313).withOpacity(1), //100%
          },
        ),
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
          name: ForgotPassword.id,
          page: () => ForgotPassword(),
        ),
        GetPage(
          name: ConfirmEmail.id,
          page: () => ConfirmEmail(),
        ),
        GetPage(
          name: MainScreen.id,
          page: () => MainScreen(),
        ),
        GetPage(
          name: ProsInfoScreen.id,
          page: () => ProsInfoScreen(),
        ),
      ],
    );
  }
}
