import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../Constants/api_endpoint.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Model/body_part_response_model.dart';
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

  BodyDetailScreen({Key? key}) : super(key: key);

  @override
  State<BodyDetailScreen> createState() => _BodyDetailScreenState();
}

class _BodyDetailScreenState extends State<BodyDetailScreen> {
  final desController = TextEditingController();
  final sDateController = TextEditingController();
  final eDateController = TextEditingController();
  int sDate=0;
  int eDate=0;
  DateTime selectedDate = DateTime.now();
  List<BodyPartListResponseModel> bodyPartData=[];
  String? _bodyPartValue;
  var bodyPartId = 0;

  @override
  void initState() {
    getBodyPartsApi();
    super.initState();
  }

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
              "Add Comment",
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
                            focusColor: Colors.black,
                            value: _bodyPartValue,
                            style: TextStyle(color: Colors.black),
                            iconEnabledColor: ColorConstants.lightGrey,
                            icon: Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 32,
                            underline: Container(color: Colors.transparent),
                            items: bodyPartData.map((items) {
                              return DropdownMenuItem(
                                value: items.bodyPart,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(items.bodyPart.toString(),
                                    style: TextStyle(fontSize: 15.0),
                                  ),
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
                            onChanged:
                                (String? value) {
                              setState(() {_bodyPartValue = value;
                              for (int i = 0;
                              i < bodyPartData.length; i++) {
                                if (bodyPartData[i].bodyPart == _bodyPartValue) {
                                  bodyPartId = bodyPartData[i].bodyPartId!;
                                  print("dropdownvalueId:" + bodyPartId.toString());
                                }
                              }
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
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      _selectDate(context, sDateController,sDate);
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
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      _selectDate(context, eDateController,eDate);
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
                            if(bodyPartId==0){
                              CommonUtils.showRedToastMessage("Please Select Body Part");
                            }
                            else if(desController.text.isEmpty){
                              CommonUtils.showRedToastMessage("Please Enter Description");
                            }
                            else if(sDateController.text.isEmpty){
                              CommonUtils.showRedToastMessage("Please Select StartDate");
                            }
                            else if(eDateController.text.isEmpty){
                              CommonUtils.showRedToastMessage("Please Select EndDate");
                            }
                            else{
                              savePain();
                            }
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

  Future<void> _selectDate(BuildContext context, final controller,int Date) async {
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


        final DateFormat formatter2 = DateFormat('dd-MM-yyy');
        final String sDate = formatter2.format(picked);
        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(sDate);
        Date=dateTimeFormat.millisecondsSinceEpoch;
        print("Date:"+Date.toString());
      });
    }
  }

  Future<void> getBodyPartsApi() async {
    final uri = ApiEndPoint.getBodyParts;
    final headers = {'Content-Type': 'application/json',
    };

    Response response = await get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    // changeRoute();
    var res = jsonDecode(responseBody);
    if (statusCode == 200 ) {
      for (int i = 0; i < res.length; i++) {
        bodyPartData.add(BodyPartListResponseModel(
            bodyPart: res[i]["bodyPart"], bodyPartId: res[i]["bodyPartId"]));
      }
      bodyPartId=bodyPartData[0].bodyPartId!;
      setState(() {});
    } else {

       CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> savePain() async {
    FocusManager.instance.primaryFocus?.unfocus();
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.savePain;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersPainId": 0,
      "bodyPartId": bodyPartId,
      "locationX": 15.22,
      "locationY": 153.55,
      "description": desController.text.toString(),
      "startDate": sDate,
      "endDate": eDate,
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
      CommonUtils.showGreenToastMessage("save Pain Successfully");
      Navigator.pop(context);
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
