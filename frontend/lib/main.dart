import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cancure/screens/diagnosis/bone_screen.dart';
import 'package:cancure/screens/diagnosis/kidney_screen.dart';
import 'package:cancure/screens/forget_password_screen.dart';
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
          home: LoginScreen(),
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            ForgetPassword.id: (context) => ForgetPassword(),
            CurrentScreen.id: (context) => CurrentScreen(),
            KidneyDiagnosis.id: (context) => KidneyDiagnosis(),
            BoneDiagnosis.id: (context) => BoneDiagnosis(),
          });
}
