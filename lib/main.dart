import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:home_utility/screens/detailsScreen.dart';
import 'package:home_utility/screens/logInScreen.dart';
import 'package:home_utility/screens/ourServices.dart';
import 'package:home_utility/screens/registrationScreen.dart';
import 'screens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

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
