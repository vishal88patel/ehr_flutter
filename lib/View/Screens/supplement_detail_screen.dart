import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Constants/api_endpoint.dart';
import '../../Constants/string_constants.dart';
import '../../CustomWidgets/custom_date_field.dart';
import '../../Model/medicationData_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_textform_field.dart';
import 'body_detail_screen.dart';
import 'change_pass_screen.dart';
import 'comment_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class SupplementDetailScreen extends StatefulWidget {
  final int? supplementId;
  final String? supplementName;
  final String? dosage;
  final int? withFoodId;
  final int? startDate;
  final int? endDate;
  final bool? isOngoing;

  const SupplementDetailScreen({
    Key? key,
    required this.supplementName,
    required this.supplementId,
    required this.dosage,
    required this.startDate,
    required this.endDate, this.withFoodId, this.isOngoing,
  }) : super(key: key);

  @override
  State<SupplementDetailScreen> createState() => _SupplementDetailScreenState();
}

class _SupplementDetailScreenState extends State<SupplementDetailScreen> {

  final mNameController = TextEditingController();
  final dosageController = TextEditingController();
  final sDateController = TextEditingController();
  final eDateController = TextEditingController();
  int sDate = 0;
  int eDate = 0;
  bool withFood = true;
  bool before = false;
  bool after = false;

  var dosageId = 0;
  var frequencyId = 0;
  var foodId = 1;

  List<FoodType> foodTypeData = [];
  List<Dosage> dosageTypeData = [];
  List<Frequency> frequencyTypeData = [];
  DateTime selectedDate = DateTime.now();
  var current = false;
  @override
  void initState() {
    mNameController.text=widget.supplementName!;
    dosageController.text=widget.dosage!;
    if(widget.withFoodId==1){
      withFood=true;
      before=false;
      after=false;
    }else if(widget.withFoodId==2){
      before=true;
      withFood=false;
      after=false;
    }else if(widget.withFoodId==3){
      after=true;
      before=false;
      withFood=false;
    }else{
      withFood=true;
      after=false;
      before=false;
    }
    if (widget.startDate!.toInt() != 0) {
      sDate=widget.startDate!;
      var mydtEnd =
      DateTime.fromMillisecondsSinceEpoch(widget.startDate!.toInt());
      var myd24End = DateFormat('dd/MM/yyyy').format(mydtEnd);
      sDateController.text = myd24End.toString();
    }
    if (widget.endDate!.toInt() != 0) {
      eDate=widget.endDate!;
      var mydtEnd =
      DateTime.fromMillisecondsSinceEpoch(widget.endDate!.toInt());
      var myd24End = DateFormat('dd/MM/yyyy').format(mydtEnd);
      eDateController.text = myd24End.toString();
    }else{
      current=true;
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      getMedicationContent();
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: D.W / 6),
          child: Text(
            "Supplements",
            style: GoogleFonts.heebo(
                fontSize: D.H / 44, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      backgroundColor: ColorConstants.background,
      body:foodTypeData.isNotEmpty && dosageTypeData.isNotEmpty && frequencyTypeData.isNotEmpty? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: D.H / 24, right: D.H / 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: D.H / 22),
                  SvgPicture.asset(
                    "assets/images/bg_medication_detail.svg",
                    height: D.H / 5,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: D.H / 16),
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
                          "Supplement Name",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52,
                              fontWeight: FontWeight.w400),
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
                              fontSize: D.H / 52,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: dosageController,
                          readOnly: false,
                          validators: (e) {
                            if (dosageController.text == null ||
                                dosageController.text == '') {
                              return '*Dosage';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        /*Container(
                                    padding: EdgeInsets.only(
                                        left: D.W / 30, right: D.W / 60),
                                    width: D.W / 4,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.innerColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
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
                                      iconEnabledColor:
                                          ColorConstants.lightGrey,
                                      icon: Icon(Icons.arrow_drop_down_sharp),
                                      iconSize: 32,
                                      underline:
                                          Container(color: Colors.transparent),
                                      items: dosageTypeData.map((items) {
                                        return DropdownMenuItem(
                                          value: items.dosageType,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              items.dosageType.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text(
                                        " ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: D.H / 48,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _choosenDosageValue = value;
                                          for (int i = 0;
                                              i < dosageTypeData.length;
                                              i++) {
                                            if (dosageTypeData[i].dosageType ==
                                                _choosenDosageValue) {
                                              dosageId = dosageTypeData[i]
                                                  .dosageTypeId!;
                                            }
                                          }
                                        });
                                      },
                                    ),
                                  ),*/
                        SizedBox(height: D.H / 60),
                        Text(
                          "Food",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  withFood = true;
                                  before = false;
                                  after = false;
                                  foodId = foodTypeData[0]
                                      .medicationFoodTypeId!;
                                });
                              },
                              child: Container(
                                height: D.W / 19,
                                width: D.W / 19,
                                decoration: new BoxDecoration(
                                  color: withFood
                                      ? ColorConstants.primaryBlueColor
                                      : ColorConstants.innerColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              foodTypeData[0].medicationFood.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(
                              width: 29,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  withFood = false;
                                  before = true;
                                  after = false;
                                  foodId = foodTypeData[1]
                                      .medicationFoodTypeId!;
                                });
                              },
                              child: Container(
                                height: D.W / 19,
                                width: D.W / 19,
                                decoration: new BoxDecoration(
                                  color: before
                                      ? ColorConstants.primaryBlueColor
                                      : ColorConstants.innerColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              foodTypeData[1].medicationFood.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(
                              width: 29,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  withFood = false;
                                  before = false;
                                  after = true;
                                  foodId = foodTypeData[2]
                                      .medicationFoodTypeId!;
                                });
                              },
                              child: Container(
                                height: D.W / 19,
                                width: D.W / 19,
                                decoration: new BoxDecoration(
                                  color: after
                                      ? ColorConstants.primaryBlueColor
                                      : ColorConstants.innerColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              foodTypeData[2].medicationFood.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: D.H / 60),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      _selectDateS(context,
                                          sDateController, sDate);
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: D.H / 120),
                                current
                                    ? Container(
                                  width: D.W / 2.9,
                                  height: D.H / 16,
                                )
                                    : Container(
                                  width: D.W / 2.9,
                                  child: CustomDateField(
                                    onTap: () {
                                      FocusManager
                                          .instance.primaryFocus
                                          ?.unfocus();
                                      _selectDateSE(context,
                                          eDateController, eDate);
                                    },
                                    controller: eDateController,
                                    iconPath:
                                    "assets/images/ic_date.svg",
                                    readOnly: true,
                                    validators: (e) {
                                      if (eDateController.text ==
                                          null ||
                                          eDateController.text ==
                                              '') {
                                        return '*Please enter End Date';
                                      }
                                    },
                                    keyboardTYPE:
                                    TextInputType.text,
                                    obscured: false,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                        activeColor: ColorConstants
                                            .primaryBlueColor,
                                        tristate: false,
                                        value: current,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            current = value!;
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Ongoing",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 50,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: D.H / 32),
                        CustomButton(
                          color: ColorConstants.blueBtn,
                          onTap: () {
                            if (current) {
                              eDate = 0;
                            }
                            if (mNameController.text.isEmpty) {
                              CommonUtils.showRedToastMessage(
                                  StringConstants.ENTER_MEDICATION_NAME);
                            } else if (dosageController.text.isEmpty) {
                              CommonUtils.showRedToastMessage(
                                  StringConstants.ENTER_DOSAGE);
                            } /*else if (dosageId == 0) {
                                    CommonUtils.showRedToastMessage(
                                        "Please select Dosage Type");
                                  }*/ else if (foodId == 0) {
                              CommonUtils.showRedToastMessage(
                                  StringConstants.SELECT_FOOD_TYPE);
                            } else if (sDateController.text.isEmpty) {
                              CommonUtils.showRedToastMessage(
                                  StringConstants.ENTER_START_DATE);
                            } else if (current == false &&
                                eDateController.text.isEmpty) {
                              CommonUtils.showRedToastMessage(
                                  StringConstants.ENTER_END_DATE);
                            }  else {
                              saveSuppliments();
                            }
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
      ):Container(),
    );
  }
  Future<void> _selectDateS(
      BuildContext context, final controller, int Date) async {
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
        final String sDatee = formatter2.format(picked);
        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(sDatee);
        sDate = dateTimeFormat.millisecondsSinceEpoch;
        print("Date:" + sDate.toString());
      });
    }
  }

  Future<void> _selectDateSE(
      BuildContext context, final controller, int Date) async {
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
        final String sDatee = formatter2.format(picked);
        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(sDatee);
        eDate = dateTimeFormat.millisecondsSinceEpoch;
        print("Date:" + eDate.toString());
      });
    }
  }
  Future<void> getMedicationContent() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getMedicationContent;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    Response response = await get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      MedicationData data = MedicationData();
      data = MedicationData.fromJson(res);
      if (data != null) {
        foodTypeData = data.foodType!;
        frequencyTypeData = data.frequency!;
        dosageTypeData = data.dosage!;
      }
      CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> saveSuppliments() async {
    FocusManager.instance.primaryFocus?.unfocus();
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveSupplements;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "supplementId": widget.supplementId,
      "supplementName": mNameController.text.toString(),
      "dosage": dosageController.text.toString(),
      "withfoodId": foodId,
      "startDate": sDate,
      "endDate": eDate,
      "isOngoing": current,
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
      Navigator.pop(context);
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
