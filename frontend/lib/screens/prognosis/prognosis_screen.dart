import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cancure/components/alert_widget.dart';
import 'package:cancure/components/custom_app_bar.dart';
import 'package:cancure/constants.dart';
import 'package:cancure/services/endPoints.dart';
import 'dart:convert';
import 'dart:io';

// ignore: must_be_immutable
class CancerPrognosis extends StatefulWidget {
  var _cancerType;
  var _url;
  var _cancerPrognosisAttributes;

  CancerPrognosis(String cancerType) {
    this._cancerType = cancerType;

    if (cancerType == "Kidney Cancer") {
      _cancerPrognosisAttributes = KIDNEY_CANCER_PROGNOSIS_QUESTIONS;
      _url = KIDNEY_CANCER_PROGNOSIS;
    } else if (cancerType == "Bone Cancer") {
      _cancerPrognosisAttributes = BONE_CANCER_PROGNOSIS_QUESTIONS;
      _url = BONE_CANCER_PROGNOSIS;
    }
  }

  @override
  CancerPrognosisState createState() =>
      CancerPrognosisState(_cancerType, _cancerPrognosisAttributes, _url);
}

class CancerPrognosisState extends State<CancerPrognosis> {
  ScrollController _controller = ScrollController();
  List<Widget> _itemsData = [];
  List<TextEditingController> _textFieldControllers = [];
  Map prognosisBody;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _cancerType;
  var _cancerPrognosisAttributes;
  var _url;
  var _count = 0;

  CancerPrognosisState(var cancerType, var cancerPrognosisAttributes, var url) {
    this._cancerType = cancerType;
    this._cancerPrognosisAttributes = cancerPrognosisAttributes;
    this._url = url;
  }

  Future<String> apiRequest() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(_url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(prognosisBody)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  void _getPostsData() {
    List<dynamic> responseList = _cancerPrognosisAttributes;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      _textFieldControllers.add(new TextEditingController());
      listItems.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.only(top: 0, bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color(0xFFABD8E2),
                  ),
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        post,
                        style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          color: Colors.blueGrey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some Input';
                        }

                        return null;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _textFieldControllers[_count],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(16),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white),
                            borderRadius: new BorderRadius.circular(16),
                          ),
                          hintText: 'Enter the Value for the Input'),
                    ),
                  ])),
            ),
          ),
        ),
      );

      _count++;
    });
    setState(() {
      _itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffAFD5DA),
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar.arrow(context),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      _cancerType,
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 27,
                        color: Color(0xFF93ACB1),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {
                      String helpMessage =
                          "Based on your inputs the prognosis would be whether or not there's a risk of cancer within next 5 years";
                      createAlertDialog(context, "Help", helpMessage, 404);
                    },
                  )
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Prognosis",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 27.0,
                    color: Color(0xFF565D5E),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: _itemsData.length,
                      itemBuilder: (context, index) {
                        return _itemsData[index];
                      }),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 50, right: 50),
                child: RawMaterialButton(
                    fillColor: Colors.black54,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          SizedBox(
                            width: 10.0,
                            height: 30.0,
                          ),
                          Text(
                            "Predict",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins-Regular',
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    shape: const StadiumBorder(),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (_cancerType == "Bone Cancer") {
                          prognosisBody = {
                            "Blue.count":
                                int.parse(_textFieldControllers[0].text),
                            "red.count":
                                int.parse(_textFieldControllers[1].text),
                            "Blue.percentage":
                                int.parse(_textFieldControllers[2].text),
                            "red.percentage":
                                int.parse(_textFieldControllers[3].text),
                            "area": int.parse(_textFieldControllers[4].text),
                            "circularity":
                                int.parse(_textFieldControllers[5].text),
                          };
                        } else if (_cancerType == "Kidney Cancer") {
                          prognosisBody = {
                            "radius_mean": _textFieldControllers[0].text,
                            "texture_mean": _textFieldControllers[1].text,
                            "perimeter_mean": _textFieldControllers[2].text,
                            "compactness_mean": _textFieldControllers[3].text,
                            "concavity_mean": _textFieldControllers[4].text,
                            "concave points_mean":
                                _textFieldControllers[5].text,
                            "fractal_dimension_mean":
                                _textFieldControllers[6].text,
                            "radius_se": _textFieldControllers[7].text,
                            "texture_se": _textFieldControllers[8].text,
                            "perimeter_se": _textFieldControllers[9].text,
                            "compactness_se": _textFieldControllers[10].text,
                            "concavity_se": _textFieldControllers[11].text,
                            "concave points_se": _textFieldControllers[12].text,
                            "symmetry_se": _textFieldControllers[13].text,
                            "fractal_dimension_se":
                                _textFieldControllers[14].text,
                            "compactness_worst": _textFieldControllers[15].text,
                            "concavity_worst": _textFieldControllers[16].text,
                            "concave points_worst":
                                _textFieldControllers[17].text,
                            "symmetry_worst": _textFieldControllers[18].text,
                            "fractal_dimension_worst":
                                _textFieldControllers[19].text,
                            "tumor_size": _textFieldControllers[20].text,
                            "positive_axillary_lymph_node":
                                _textFieldControllers[21].text
                          };
                        }

                        final ProgressDialog progressDialog = ProgressDialog(
                            context,
                            type: ProgressDialogType.Normal,
                            isDismissible: false,
                            showLogs: true);

                        progressDialog.style(
                          message: '   Analyzing\n   Input',
                          padding: EdgeInsets.all(20),
                          borderRadius: 10.0,
                          backgroundColor: Colors.white,
                          progressWidget: LinearProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                          elevation: 10.0,
                          insetAnimCurve: Curves.easeInCubic,
                          progress: 0.0,
                          maxProgress: 100.0,
                          progressTextStyle: TextStyle(
                            color: Color(0xFF565D5E),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins-SemiBold',
                          ),
                          messageTextStyle: TextStyle(
                            color: Color(0xFF565D5E),
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins-SemiBold',
                          ),
                        );

                        progressDialog.show();
                        String reply = await apiRequest();
                        progressDialog.hide();

                        if (reply != null) {
                          final body = json.decode(reply);
                          var prognosisResult;
                          if (body["message"] == "Internal Server Error")
                            createAlertDialog(
                                context,
                                "Error",
                                "Something's wrong on our end :( please try again !",
                                404);
                          else {
                            if (_cancerType != "Skin Cancer")
                              prognosisResult = body["Prediction"];
                            else {
                              prognosisResult = body['result_string'];
                            }

                            if (prognosisResult == "N" &&
                                _cancerType == "Breast Cancer")
                              prognosisResult = "Non-Recurring";
                            else if (prognosisResult == "R" &&
                                _cancerType == "Breast Cancer")
                              prognosisResult = "Recurring";

                            createAlertDialog(
                                context, "Prognosis", prognosisResult, 203);
                          }
                        } else {
                          createAlertDialog(context, "Error",
                              "Oops something went wrong!", 404);
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
