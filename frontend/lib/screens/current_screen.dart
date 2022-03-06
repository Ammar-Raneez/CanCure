import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cancure/screens/home_screen.dart';
import 'package:cancure/screens/main_cancer_screen.dart';
import 'package:cancure/components/custom_app_bar.dart';
import 'package:cancure/services/UserDetails.dart';

// ignore: must_be_immutable
class CurrentScreen extends StatefulWidget {
  static String id = "navigationBottom";
  String updatedUsername;
  String updatedEmail;
  String updatedGender;

  CurrentScreen();
  CurrentScreen.settingsNavigatorPush(
      this.updatedUsername, this.updatedEmail, this.updatedGender);

  @override
  _CurrentScreenState createState() {
    if (updatedUsername != null &&
        updatedEmail != null &&
        updatedGender != null)
      return _CurrentScreenState.settingsNavigatorPush(
          updatedUsername, updatedEmail, updatedGender);
    else
      return _CurrentScreenState();
  }
}

class _CurrentScreenState extends State<CurrentScreen> {
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  String username;
  String email;
  String gender;
  List<Widget> swipeScreen;

  _CurrentScreenState() {
    getCurrentUser();
    if (username == null) username = UserDetails.getUserData()["username"];
    if (gender == null) gender = UserDetails.getUserData()["gender"];
    if (email == null) email = UserDetails.getUserData()["email"];

    swipeScreen = [HomeScreen(), MainCancerTypesScreen()];
  }
  _CurrentScreenState.settingsNavigatorPush(
      this.username, this.email, this.gender) {
    swipeScreen = [
      HomeScreen.settingsNavigatorPush(username),
      MainCancerTypesScreen(),
    ];
  }

  User loggedInUser = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  var loggedInUserGoogle = "";

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print("(Email-Password login) User is Present!");
      }

      var userDocument =
          await _firestore.collection("users").doc(loggedInUser.email).get();

      setState(() {
        username = userDocument["username"];
        email = userDocument["email"];
        gender = userDocument["gender"];
      });
    } catch (e) {
      print(e);
    }
  }

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Color(0xffAFD5DA),
              appBar: CustomAppBar.settings(username, email, gender, context),
              body: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    currentIndex = page;
                  });
                },
                children: swipeScreen,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedNavigationBar(
                height: 52,
                color: Colors.white,
                backgroundColor: Color(0xffAFD5DA),
                index: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                    _pageController.jumpToPage(
                      index,
                    );
                  });
                },
                items: [
                  Icon(
                    Icons.home,
                    size: 27,
                    color: Color(0xffAFD5DA),
                  ),
                  Icon(
                    Icons.widgets,
                    size: 27,
                    color: Color(0xffAFD5DA),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
