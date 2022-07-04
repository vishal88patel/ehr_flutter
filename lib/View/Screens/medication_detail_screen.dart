import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/add_medication_screen.dart';
import 'package:ehr/View/Screens/lab_screen.dart';
import 'package:ehr/View/Screens/lab_list_screen.dart';
import 'package:ehr/View/Screens/medication_screen.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../../Constants/api_endpoint.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import 'body_detail_screen.dart';
import 'change_pass_screen.dart';
import 'comment_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class MedicationDetailScreen extends StatefulWidget {
  const MedicationDetailScreen({Key? key}) : super(key: key);

  @override
  State<MedicationDetailScreen> createState() => _MedicationDetailScreenState();
}

class _MedicationDetailScreenState extends State<MedicationDetailScreen> {
  final ccController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        title: Padding(
          padding:  EdgeInsets.only(left: D.W/6),
          child: Text(
            "Medication Detail",
            style: GoogleFonts.heebo(
                fontSize: D.H / 44, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left:D.H / 24,right: D.H / 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: D.H / 22),
                  SvgPicture.asset("assets/images/bg_medication_detail.svg",height: D.H/5,fit: BoxFit.fill,),
                  SizedBox(height: D.H / 16),
                ],
              ),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48)),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 30,top: D.H / 24),
                        child: Text(
                          "Nandrolone",
                          style: GoogleFonts.heebo(
                            color: ColorConstants.blueBtn,
                              fontSize:D.H/40, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 30,top: D.H / 45),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                "assets/images/ic_dosage.svg"),
                            SizedBox(width: D.H / 50),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dosage",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      color: ColorConstants.lightText3,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Hil 250 mg 2/Day",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 50,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 4.0,right: 4.0,top: D.H/60),
                        child: Container(
                          height: 1.0,
                          color: ColorConstants.lineColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 30,top: D.H / 45),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                                "assets/images/ic_time.svg"),
                            SizedBox(width: D.H / 50),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      color: ColorConstants.lightText3,
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Start Time",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 50,
                                          color: ColorConstants.blueBtn,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "29-12-2021",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 50,
                                          color: ColorConstants.skyBlue,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "End Time",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 50,
                                          color: ColorConstants.blueBtn,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "01-01-2022",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 50,
                                          color: ColorConstants.skyBlue,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0,right: 4.0,top: D.H/60),
                        child: Container(
                          height: 1.0,
                          color: ColorConstants.lineColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 30,top: D.H / 45,right : D.H / 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    "assets/images/ic_doctorr.svg"),
                                SizedBox(width: D.H / 50),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Doctor",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 52,
                                          color: ColorConstants.lightText3,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "John Miler",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 50,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(width: 1.0,height: D.H/16,color: ColorConstants.lineColor,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    "assets/images/ic_food.svg"),
                                SizedBox(width: D.H / 50),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Food",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 52,
                                          color: ColorConstants.lightText3,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "With Food",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 50,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0,right: 4.0,top: D.H/60),
                        child: Container(
                          height: 1.0,
                          color: ColorConstants.lineColor,
                        ),
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getMedication() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getMedications;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "pageNumber": "1",
      "keyword": "Disprin",
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
      CommonUtils.showGreenToastMessage("feedback Successfully");
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
