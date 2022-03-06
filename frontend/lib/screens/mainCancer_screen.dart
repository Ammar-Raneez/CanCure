import 'package:flutter/material.dart';
import 'package:cancure/components/cancer_card.dart'; //imports card component
import 'package:cancure/screens/diagnosis/bone_screen.dart';
import 'package:cancure/screens/diagnosis/kidney_screen.dart';
import 'package:cancure/screens/prognosis/prognosis_screen.dart';
import 'package:cancure/screens/selectService_screen.dart';

/* This is the Cancer Page that displays an appbar with a gradient and a logo, three cards that allow the user to click on a
 certain cancer and be redirected to that page and the nav at the bottom. */

class MainCancerTypesScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "mainCancerTypesScreen";

  @override
  _MainCancerTypesScreenState createState() => _MainCancerTypesScreenState();
}

class _MainCancerTypesScreenState extends State<MainCancerTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xffAFD5DA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  //* might need to change when adding top row and nav
                  left: 22,
                  right: 22,
                  bottom: 20),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 15),
                      child: Text(
                        'Prognosis & Diagnosis of Cancers',
                        style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 24,
                          color: Color(0xFF565D5E),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectServiceScreen(
                              cancerType: 'Bone Cancer',
                              diagnosisRoute: BoneDiagnosis(),
                              prognosisRoute: CancerPrognosis("Bone Cancer"),
                            ),
                          ),
                        );
                      },
                      child: CancerCard(
                        cardTitle: 'Bone Cancer',
                        cardColor: '0xFF66b9ed',
                        cardColor2: '0xFF2d81b5',
                        textColor: '0xFFFFFFFF',
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectServiceScreen(
                              cancerType: 'Kidney Cancer',
                              diagnosisRoute: KidneyDiagnosis(),
                              prognosisRoute: CancerPrognosis("Kidney Cancer"),
                            ),
                          ),
                        );
                      },
                      child: CancerCard(
                        cardTitle: 'Kidney Cancer',
                        cardColor: '0xFFf25ca2',
                        cardColor2: '0xFFa62863',
                        textColor: '0xFFFFFFFF',
                      ),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
