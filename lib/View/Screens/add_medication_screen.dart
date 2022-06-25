import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/medicationData_model.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
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
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_date_field.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final mNameController = TextEditingController();
  final sDateController = TextEditingController();
  final eDateController = TextEditingController();
  String? _choosenDosageValue;
  String? _choosenFoodValue;
  String? _choosenFreqValue;

  var dosageId = 0;
  var frequencyId = 0;

  List<FoodType> foodTypeData = [];
  List<Dosage> dosageTypeData = [];
  List<Frequency> frequencyTypeData = [];
  var _selectedFood = "after";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    getMedicationContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        title: Padding(
          padding: EdgeInsets.only(right: D.W / 8),
          child: Center(
            child: Text(
              "Add Medication",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: D.H / 24, right: D.H / 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: D.H / 22),
                  Center(
                      child: SvgPicture.asset(
                          "assets/images/bg_add_medication.svg")),
                  SizedBox(height: D.H / 24),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              color: ColorConstants.lightPurple,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48)),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height/1.4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: D.W / 10, right: D.W / 10, top: D.H / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medication Name",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: mNameController,
                          readOnly: false,
                          validators: (e) {
                            if (mNameController.text == null ||
                                mNameController.text == '') {
                              return '*Medication Name';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 60),
                        Text(
                          "Dosage",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        Container(
                          padding:
                          EdgeInsets.only(left: D.W / 30, right: D.W / 60),
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
                            value: _choosenDosageValue,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: ColorConstants.lightGrey,
                            icon: Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 32,
                            underline: Container(color: Colors.transparent),
                            items: dosageTypeData.map((items) {
                              return DropdownMenuItem(
                                value: items.dosageType,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(
                                      left: 10),
                                  child: Text(
                                    items.dosageType
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15.0),
                                  ),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Please choose a Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: D.H / 48,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _choosenDosageValue = value;
                                for (int i = 0; i < dosageTypeData.length; i++) {
                                  if (dosageTypeData[i].dosageType == _choosenDosageValue) {
                                    dosageId = dosageTypeData[i].dosageTypeId!;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: D.H / 60),
                        Text(
                          "Food",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: D.W / 19,
                              width: D.W / 19,
                              decoration: new BoxDecoration(
                                color: ColorConstants.innerColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              "With Food",
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(
                              width: 29,
                            ),
                            Container(
                              height: D.W / 19,
                              width: D.W / 19,
                              decoration: new BoxDecoration(
                                color: ColorConstants.innerColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              "Before",
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(
                              width: 29,
                            ),
                            Container(
                              height: D.W / 19,
                              width: D.W / 19,
                              decoration: new BoxDecoration(
                                color: ColorConstants.innerColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              "After",
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: D.H / 60),
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
                                      _selectDate(context,sDateController);
                                    },
                                    controller: sDateController,
                                    iconPath: "assets/images/ic_date.svg",
                                    readOnly: true,
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
                                      _selectDate(context,eDateController);
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
                        SizedBox(height: D.H / 60),
                        Text(
                          "Add Frequency",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        Container(
                          padding:
                          EdgeInsets.only(left: D.W / 30, right: D.W / 60),
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
                            value: _choosenFreqValue,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: ColorConstants.lightGrey,
                            icon: Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 24,
                            underline: Container(color: Colors.transparent),
                            items: frequencyTypeData.map((items) {
                              return DropdownMenuItem(
                                value: items.frequencyType,
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(
                                      left: 10),
                                  child: Text(
                                    items.frequencyType
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15.0),
                                  ),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Please choose a Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: D.H / 48,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _choosenFreqValue = value;
                                for (int i = 0; i < frequencyTypeData.length; i++) {
                                  if (frequencyTypeData[i].frequencyType == _choosenFreqValue) {
                                    frequencyId = frequencyTypeData[i].frequencyTypeId!;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: D.H / 32),
                        CustomButton(
                          color: ColorConstants.blueBtn,
                          onTap: () {
                            saveMedication();
                          },
                          text: "Done",
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
  Future<void> _selectDate(BuildContext context,final controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yy');
        final String startDate = formatter.format(picked);
        controller.text= startDate.toString();
      });
    }
  }

  Future<void> getMedicationContent() async {
    final uri = ApiEndPoint.getMedicationContent;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    Response response = await get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      for (int i = 0; i < res.length; i++) {

      }

      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> saveMedication() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveMedication;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersMedicationId": 0,
      "medicationName": mNameController,
      "dosage": "10",
      "dosageId": dosageId,
      "foodId": 1,
      "startDate": 1655922600000,
      "endDate": 1658514600000,
      "frequencyId": frequencyId,
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
    if (statusCode == 200 ) {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage(res["message"]);

    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
