import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:home_utility/components/detailsDialog.dart';
import 'package:home_utility/controllers/textController.dart';
import 'package:home_utility/screens/forgetpasswordscreen.dart';
import 'package:home_utility/screens/popUpPages/about.dart';
import 'package:home_utility/screens/popUpPages/help.dart';
import 'package:home_utility/screens/signupscreen.dart';
import 'package:home_utility/screens/tabPages/userProfile.dart';
import 'package:home_utility/services/cloudStorage.dart';
import 'screens/loginscreen.dart';
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Query myQuery;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(HomeUtility());
}

class HomeUtility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(TextController());
    return GetMaterialApp(
      // home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: userAuthentication.currentUser == null
          ? WelcomeScreen.id
          : MainScreen.id,
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
          name: Login.id,
          page: () => Login(),
        ),
        GetPage(
          curve: Curves.easeIn,
          transition: Transition.upToDown,
          name: Signup.id,
          page: () => Signup(),
        ),
        GetPage(
          name: ForgetPassword.id,
          page: () => ForgetPassword(),
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
          name: HelpPage.id,
          page: () => HelpPage(),
        ),
      ],
    );
  }
}
