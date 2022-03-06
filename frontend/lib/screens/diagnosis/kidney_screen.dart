import 'dart:io';
import 'package:cancure/services/endPoints.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cancure/components/alert_widget.dart';
import 'package:cancure/components/custom_app_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class KidneyDiagnosis extends StatefulWidget {
  static String id = "kidneyCancerDiagnosisScreen";

  @override
  KidneyDiagnosisState createState() => KidneyDiagnosisState();
}

class KidneyDiagnosisState extends State<KidneyDiagnosis> {
  File imageFile;
  Dio dio = new Dio();
  bool showSpinner = false;
  dynamic responseBody;

  _openGallery() async {
    var selectedPicture =
        // ignore: deprecated_member_use
        await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = selectedPicture;
    });
  }

  _detect(ProgressDialog progressDialog) async {
    if (imageFile == null) {
      createAlertDialog(
          context, "Error", "There is no image selected or captured!", 404);
    } else {
      progressDialog.show();
      try {
        String fileName = imageFile.path.split('/').last;
        FormData formData = new FormData.fromMap({
          "file":
              await MultipartFile.fromFile(imageFile.path, filename: fileName),
        });

        await getResponse(formData);
        String resultPrediction = responseBody;
        progressDialog.hide();

        if (responseBody != null) {
          createAlertDialog(context, "Diagnosis", resultPrediction, 201);
        } else {
          createAlertDialog(
              context, "Error", "Oops something went wrong!", 404);
        }
      } catch (e) {
        progressDialog.hide();
        createAlertDialog(context, "Error", e._message, 404);
      }
    }
  }

  getResponse(FormData formData) async {
    Response response = await dio.post(
      KIDNEY_CANCER_DIAGNOSIS,
      data: formData,
    );
    responseBody = response.data['result'];
  }

  _openCamera() async {
    setState(() {
      showSpinner = true;
    });

    var selectedPicture =
        // ignore: deprecated_member_use
        await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = selectedPicture;
    });

    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        showSpinner = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

    progressDialog.style(
      message: '   Scanning\n   Image',
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

    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: Color(0xffAFD5DA),
          appBar: CustomAppBar.arrow(context),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 6,
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Kidney Cancer",
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 27.0,
                              color: Color(0xFF93ACB1),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Diagnosis",
                            style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 27.0,
                              color: Color(0xFF565D5E),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: imageFile == null
                              ? Image.asset(
                                  'images/uploadImageGrey1.png',
                                  scale: 13,
                                )
                              : Image.file(
                                  imageFile,
                                  width: 500,
                                  height: 500,
                                ),
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openCamera();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                _openGallery();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                child: Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
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
                                    "SCAN IMAGE",
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
                            onPressed: () {
                              _detect(progressDialog);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
