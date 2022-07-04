import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../Constants/api_endpoint.dart';
import '../../CustomWidgets/custom_calender.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import 'otp_screen.dart';

class AddSheduleScreen extends StatefulWidget {
  const AddSheduleScreen({Key? key}) : super(key: key);

  @override
  State<AddSheduleScreen> createState() => _AddSheduleScreenState();
}

class _AddSheduleScreenState extends State<AddSheduleScreen> {
  final commentController = TextEditingController();
  String? _chosenTime;
  String? _chosenAmPm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "Add Schedule",
          style: GoogleFonts.heebo(
              fontSize: D.H / 44, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(D.W/28),
              child: CustomCalender(),
            ),
            Container(
              color: ColorConstants.lightPurple,
              child: Column(
                children: [
                  SizedBox(height: D.H / 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: D.W / 18),
                            child: Text(
                              "Select Time",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 52,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: D.H / 240),
                          Padding(
                            padding: EdgeInsets.only(left: D.W / 18),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: D.W / 30, right: D.W / 60),
                              width: MediaQuery.of(context).size.width / 1.8,
                              decoration: BoxDecoration(
                                color: ColorConstants.innerColor,
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),

                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Colors.white,
                                value: _chosenTime,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: ColorConstants.lightGrey,
                                icon: Icon(Icons.arrow_drop_down_sharp),
                                iconSize: 32,
                                underline: Container(color: Colors.transparent),
                                items: <String>[
                                  '1.00',
                                  '2.00',
                                  '3.00',
                                  '4.00',
                                  '5.00',
                                  '6.00',
                                  '7.00',
                                  '8.00',
                                  '9.00',
                                  '10.00',
                                  '11.00',
                                  '12.00',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: D.H / 48,
                                      fontWeight: FontWeight.w400),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    _chosenTime = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: D.W / 18, right: D.W / 18),
                            child: Text(
                              "Select Time",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 52,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: D.H / 240),
                          Padding(
                            padding: EdgeInsets.only(
                                left: D.W / 18, right: D.W / 18),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: D.W / 30, right: D.W / 60),
                              width: MediaQuery.of(context).size.width / 3.65,
                              decoration: BoxDecoration(
                                color: ColorConstants.innerColor,
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),

                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Colors.white,
                                value: _chosenAmPm,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: ColorConstants.lightGrey,
                                icon: Icon(Icons.arrow_drop_down_sharp),
                                iconSize: 32,
                                underline: Container(color: Colors.transparent),
                                items: <String>[
                                  'AM',
                                  'PM'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: D.H / 48,
                                      fontWeight: FontWeight.w400),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    _chosenAmPm = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: D.H / 60),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: D.W / 18, right: D.W / 18),
                        child: Text(
                          "Comment",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: D.W / 18, right: D.W / 18),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: CustomTextFormField(
                        controller: commentController,
                        readOnly: false,
                        validators: (e) {
                          if (commentController.text == null ||
                              commentController.text == '') {
                            return '*Value';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                    ),
                  ),
                  SizedBox(height: D.H / 26),
                  Padding(
                    padding: EdgeInsets.only(left: D.W / 10, right: D.W / 10),
                    child: CustomButton(
                      color: ColorConstants.blueBtn,
                      onTap: () {
                        saveSchedule();
                        //NavigationHelpers.redirect(context, OtpScreen());
                      },
                      text: "Save",
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: D.H / 26),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveSchedule() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveSchedule;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersScheduleId": 0,
      "scheduleDateTime": DateTime.now().millisecond,
      "comment": commentController.text.toString(),
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("saveSchedule Successfully");
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
