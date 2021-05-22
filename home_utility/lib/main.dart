import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:home_utility/screens/detailsScreen.dart';
import 'package:home_utility/screens/logInScreen.dart';
import 'package:home_utility/screens/ourServices.dart';
import 'package:home_utility/screens/registrationScreen.dart';
import 'screens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/userAuthentication.dart';
import 'model/database.dart';

//TODO: probably make another file to store all these resuable accessories

int userRequestCounter;

final userAuthentication = UserAuthentication();

Database database = Database();

DatabaseReference usersRefrence =
    FirebaseDatabase.instance.reference().child('users');

DatabaseReference requestRefrence =
    FirebaseDatabase.instance.reference().child('requests');

String formatTime({TimeOfDay unformattedTime}) {
  String time = '';
  if (unformattedTime.hour <= 9)
    time += '0${unformattedTime.hour}';
  else
    time += '${unformattedTime.hour}';

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
      initialRoute: WelcomeScreen.id,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(
          name: WelcomeScreen.id,
          page: () => WelcomeScreen(),
        ),
        GetPage(
          name: LogInScreen.id,
          page: () => LogInScreen(),
        ),
        GetPage(
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
