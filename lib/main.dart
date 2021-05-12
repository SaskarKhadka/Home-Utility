import 'package:flutter/material.dart';
import 'package:home_utility/screens/logInScreen.dart';
import 'package:home_utility/screens/services.dart';
import 'package:home_utility/screens/registrationScreen.dart';
import 'screens/welcomeScreen.dart';

void main() {
  runApp(HomeUtility());
}

class HomeUtility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: WelcomeScreen(),
      initialRoute: LogInScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LogInScreen.id: (context) => LogInScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
