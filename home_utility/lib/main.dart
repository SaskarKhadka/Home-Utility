import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:home_utility/components/detailsDialog.dart';
import 'package:home_utility/components/getProsInfo.dart';
import 'package:home_utility/screens/confirmEmail.dart';
import 'package:home_utility/screens/forgotPassword.dart';
import 'package:home_utility/screens/popUpPages/about.dart';
import 'package:home_utility/screens/popUpPages/help.dart';
import 'package:home_utility/screens/tabPages/userProfile.dart';
import 'package:home_utility/services/cloudStorage.dart';
import 'screens/registrationScreen.dart';
import 'screens/logInScreen.dart';
import 'screens/mainScreen.dart';
import 'screens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/userAuthentication.dart';
import 'model/database.dart';

//TODO:Add this to main file
DatabaseReference serviceRefrence =
    FirebaseDatabase.instance.reference().child('services');

DatabaseReference prosRefrence =
    FirebaseDatabase.instance.reference().child('pros');

final cloudStorage = CloudStorage();

//TODO:up

//TODO: probably make another file to store all these resuable accessories

int userRequestCounter;

String newRequestKey;

final userAuthentication = UserAuthentication();

Database database = Database();

DatabaseReference usersRefrence =
    FirebaseDatabase.instance.reference().child('users');

DatabaseReference messagesRefrence =
    FirebaseDatabase.instance.reference().child('messages');

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
        primarySwatch: MaterialColor(
          0xff131313,
          <int, Color>{
            50: Colors.white.withOpacity(0.1), //10%
            100: Colors.white.withOpacity(0.2), //20%
            200: Colors.white.withOpacity(0.3), //30%
            300: Colors.white.withOpacity(0.4), //40%
            400: Colors.white.withOpacity(0.5), //50%
            500: Colors.white.withOpacity(0.6), //60%
            600: Colors.white.withOpacity(0.7), //70%
            700: Colors.white.withOpacity(0.8), //80%
            800: Colors.white.withOpacity(0.9), //90%
            900: Colors.white.withOpacity(0.1), //100%
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
          name: DetailsPage.id,
          page: () => DetailsPage(),
        ),
        GetPage(
          name: UserProfile.id,
          page: () => UserProfile(),
        ),
        GetPage(
          name: AboutPage.id,
          page: () => AboutPage(),
        ),
        GetPage(
          name: GetProsInfo.id,
          page: () => GetProsInfo(),
        ),
        GetPage(
          name: HelpPage.id,
          page: () => HelpPage(),
        ),
      ],
    );
  }
}
