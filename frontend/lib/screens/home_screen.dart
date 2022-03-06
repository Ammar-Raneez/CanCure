import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cancure/components/homepage_card.dart';
import 'package:cancure/components/widgets.dart';
import 'package:cancure/services/UserDetails.dart';

var username = "";
var loggedInUserEP;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static String id = "homeScreen";
  String updatedUsername;

  HomeScreen();
  HomeScreen.settingsNavigatorPush(this.updatedUsername);

  @override
  _HomeScreenState createState() {
    if (updatedUsername != null)
      return _HomeScreenState.settingsNavigatorPush(updatedUsername);
    else
      return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  String username;

  _HomeScreenState() {
    getCurrentUser();

    if (username == null) username = UserDetails.getUserData()["username"];
  }
  _HomeScreenState.settingsNavigatorPush(this.username);

  void getCurrentUser() async {
    try {
      if (user != null) {
        loggedInUserEP = user.email;
      }

      await _firestore
          .collection("users")
          .doc(loggedInUserEP)
          .get()
          .then((value) => {
                username = value.data()["username"],
              });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Color(0xffAFD5DA),
          body: Container(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Text(
                          'Hello,\n' + username + '!',
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 27.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Text(
                          'How can we help you?',
                          style: TextStyle(
                            color: Color(0xff59939F),
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 5),
                      child: ScrollConfiguration(
                        behavior: ScrollEffectBehaviour(),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                  },
                                  child: HomeCard(
                                    cardTitle: 'Card One',
                                    cardColor: '0xFFdb5682',
                                    textColor: '0xFFFFFFFF',
                                    cardImage:
                                        'images/CardImages/personalManager.jpg',
                                  ),
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                  },
                                  child: HomeCard(
                                    cardTitle: 'Card Two',
                                    cardColor: '0xFFa4d44a',
                                    textColor: '0xFFFFFFFF',
                                    cardImage:
                                        'images/CardImages/exercisePlan.jpg',
                                  ),
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                  },
                                  child: HomeCard(
                                    cardTitle: 'Card Three',
                                    cardColor: '0xFF4ad4b1',
                                    textColor: '0xFFFFFFFF',
                                    cardImage: 'images/CardImages/mealPlan.jpg',
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
