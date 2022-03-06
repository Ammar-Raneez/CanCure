import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cancure/screens/diagnosis/bone_screen.dart';
import 'package:cancure/screens/diagnosis/kidney_screen.dart';
import 'package:cancure/screens/forgetPassword_screen.dart';
import 'package:cancure/screens/current_screen.dart';
import 'package:cancure/screens/login_screen.dart';
import 'package:cancure/screens/registration_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffAFD5DA), // status bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,

        // This is the first screen which will be displayed for the user when he opens the app
        home: LoginScreen(),

        // This is the initial route for the app
        initialRoute: LoginScreen.id,

        // Creating Named routes for all the pages (we used named routes when we deal with multiple routes 'more than 2')
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ForgetPassword.id: (context) => ForgetPassword(),
          CurrentScreen.id: (context) => CurrentScreen(),
          KidneyDiagnosis.id: (context) => KidneyDiagnosis(),
          BoneDiagnosis.id: (context) => BoneDiagnosis(),
        });
}
