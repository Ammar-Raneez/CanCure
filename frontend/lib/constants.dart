import 'package:flutter/material.dart';

// This constant is for the login background gradient color
const kBackgroundBlueGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff01CDFA), Colors.white],
);

// This constant is for the text field decoration
const kTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  hintText: '',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff01CDFA), width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff01CDFA), width: 2.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);

// This constant is for the Text style for the
const kTextStyle = TextStyle(
  color: Colors.black38,
  fontSize: 15,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins-Regular',
);

const KIDNEY_CANCER_PROGNOSIS_QUESTIONS = [
  "Age",
  "Blood Pressure",
  "Albumin",
  "Sugar",
  "Are your Red Blood Cells normal?", //yes/no
  "Blood Glucose Random",
  "Blood Urea",
  "Serum Creatinine",
  "Sodium",
  "Haemoglobin",
  "Packed Cell Volume",
  "Red Blood Cell Count",
  "Do you have Hypertension?",  //yes/no
  "Do you have diabetes?", //yes/no
  "Do you have any heart disease?", //yes/no
  "Do you have a good appetite?", //yes/no
  "Are you anemic?" //yes/no
];

const BONE_CANCER_PROGNOSIS_QUESTIONS = [
  "Blue Count",
  "Red Count",
  "Blue Percentage",
  "Red Percentage",
  "Area",
  "Circularity"
];
