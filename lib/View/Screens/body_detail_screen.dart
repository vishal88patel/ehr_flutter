import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../Constants/api_endpoint.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_big_textform_field.dart';
import '../../customWidgets/custom_button.dart';
import 'otp_screen.dart';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_date_field.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class BodyDetailScreen extends StatefulWidget {
  String appBarName;
  BodyDetailScreen({required this.appBarName}) ;

  @override
  State<BodyDetailScreen> createState() => _BodyDetailScreenState();
}

class _BodyDetailScreenState extends State<BodyDetailScreen> {
  final desController = TextEditingController();
  final sDateController = TextEditingController();
  final eDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var _selectedFood = "after";
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Text(
              widget.appBarName,
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child:
                    SvgPicture.asset("assets/images/detail_icon.svg")),
              ],
            ),
            Card(
              color: ColorConstants.lightPurple,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height/1.4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: D.W / 10, right: D.W / 10, top: D.H / 34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Body Area",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        Container(
                          padding: EdgeInsets.only(left:D.W/30,right: D.W/60),
                          width: MediaQuery.of(context).size.width,
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
                            value: _chosenValue,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: ColorConstants.lightGrey,
                            icon: Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 32,
                            underline: Container(color: Colors.transparent),
                            items: <String>[
                              'Abc',
                              'Bcd',
                              'Cde',
                              'Def',
                              'Efg',
                              'Fgh',
                              'Ghi',
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
                              "Please choose a Body Area",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: D.H/48,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: D.H / 60),
                        Text(
                          "Description",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomBigTextFormField(controller: desController,
                            readOnly: false,
                            validators: (e) {
                              if (desController.text == null ||
                                  desController.text == '') {
                                return '*Medication Name';
                              }
                            },
                            keyboardTYPE: TextInputType.text,
                            maxlength: 6,
                            maxline: 6,
                            obscured: false),

                        SizedBox(height: D.H / 40),
                        Text(
                          "Duration",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: D.H / 120),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: D.H / 120),
                                Container(
                                  width: D.W / 2.9,
                                  child: CustomDateField(
                                    onTap: (){
                                      _selectDate(context, sDateController);
                                    },
                                    controller: sDateController,
                                    iconPath: "assets/images/ic_date.svg",
                                    readOnly: false,
                                    validators: (e) {
                                      if (sDateController.text == null ||
                                          sDateController.text == '') {
                                        return '*Please enter Start Date';
                                      }
                                    },
                                    keyboardTYPE: TextInputType.text,
                                    obscured: false,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: D.H / 120),
                                Container(
                                  width: D.W / 2.9,
                                  child: CustomDateField(
                                    onTap: (){
                                      _selectDate(context, eDateController);
                                    },
                                    controller: eDateController,
                                    iconPath: "assets/images/ic_date.svg",
                                    readOnly: false,
                                    validators: (e) {
                                      if (eDateController.text == null ||
                                          eDateController.text == '') {
                                        return '*Please enter End Date';
                                      }
                                    },
                                    keyboardTYPE: TextInputType.text,
                                    obscured: false,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: D.H / 32),
                        CustomButton(
                          color: ColorConstants.blueBtn,
                          onTap: () {
                           /* NavigationHelpers.redirect(
                                context, OtpVerificationScreen());*/
                          },
                          text: "Save",
                          textColor: Colors.white,
                        ),
                        SizedBox(height: D.H / 28),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, final controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yy');
        final String startDate = formatter.format(picked);
        controller.text = startDate.toString();
      });
    }
  }

  Future<void> savePain() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.savePain;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersPainId": 0,
      "bodyPartId": 1,
      "locationX": 15.22,
      "locationY": 153.55,
      "description": desController.text.toString(),
      "startDate": 1655620136070,
      "endDate": 0,
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


/*class BodyDetailScreen extends StatefulWidget {
  String appBarName;
   BodyDetailScreen({required this.appBarName}) ;

  @override
  State<BodyDetailScreen> createState() => _BodyDetailScreenState();
}

class _BodyDetailScreenState extends State<BodyDetailScreen> {
  final ccController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 4,
        centerTitle: true,
        title: Text(
          widget.appBarName,
          style: GoogleFonts.heebo(fontWeight: FontWeight.normal),
        ),

      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(child: SvgPicture.asset("assets/images/detail_icon.svg")),
            Stack(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:6.0),
                  child: SvgPicture.asset("assets/images/bg_light.svg",fit: BoxFit.fill,height:MediaQuery.of(context).size.height,),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: D.W/10,right: D.W/10,top: D.H/25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Body Area",style: GoogleFonts.heebo(fontSize: D.H/52,fontWeight: FontWeight.normal),),
                      SizedBox(height:D.H/120),
                      CustomTextFormField(keyboardTYPE: TextInputType.name, validators: (String? value) {  }, obscured: false, readOnly: false, controller:ccController ,),
                      SizedBox(height:D.H/22),
                      CustomButton(color: ColorConstants.blueBtn,onTap: (){
                        NavigationHelpers.redirect(context, OtpScreen());
                      },text: "Save",textColor: Colors.white,)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}*/
