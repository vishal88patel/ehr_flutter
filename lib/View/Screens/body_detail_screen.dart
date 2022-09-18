import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../Constants/api_endpoint.dart';
import '../../Constants/constants.dart';
import '../../CustomWidgets/custom_date_field.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_big_textform_field.dart';
import '../../customWidgets/custom_button.dart';

class BodyDetailScreen extends StatefulWidget {
  final dynamic x;
  final dynamic y;
  final bool isBack;
  String bodyPartName;
  String? description;
  int? startdate;
  int? enddate;
  bool? iscurrent;
  int? userPainId;
  bool? isUpdate;

  BodyDetailScreen(
      {Key? key,
      required this.x,
      required this.y,
      required this.bodyPartName,
      required this.isBack,
      this.description,
      this.startdate,
      this.enddate,
      this.iscurrent,
      this.userPainId, this.isUpdate
      })
      : super(key: key);

  @override
  State<BodyDetailScreen> createState() => _BodyDetailScreenState();
}

class _BodyDetailScreenState extends State<BodyDetailScreen> {
  final desController = TextEditingController();
  final sDateController = TextEditingController();
  final eDateController = TextEditingController();
  int sDate = 0;
  int eDate = 0;
  DateTime selectedDate = DateTime.now();
  String? _bodyPartValue;
  var bodyPartId = 0;
  var current = false;
  var isOnlyRead = false;

  @override
  void initState() {
    if (widget.bodyPartName != "" && widget.bodyPartName != "None") {
      var jj = Constants.BodyPartsList.where((element) =>
          element.bodyPart!.toLowerCase().toString() ==
          widget.bodyPartName.toLowerCase().toString());
      _bodyPartValue = jj.first.bodyPart.toString();
      getIdPart();
      isOnlyRead = true;
    }
    if(widget.isUpdate??false){
      getIdPart();
      desController.text=widget.description!;
      var mydtStart = DateTime.fromMillisecondsSinceEpoch(widget.startdate!.toInt());
      var myd24Start = DateFormat('dd/MM/yyyy').format(mydtStart);
      sDateController.text=myd24Start.toString();

      var mydtEnd = DateTime.fromMillisecondsSinceEpoch(widget.enddate!.toInt());
      var myd24End = DateFormat('dd/MM/yyyy').format(mydtEnd);
      eDateController.text=myd24End.toString();
      current=widget.iscurrent!;

    }

    Constants.isBackBody = widget.isBack;
    print("isFlipped:" + widget.isBack.toString());
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
            SizedBox(
              height: 10,
            ),
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
                    child: SvgPicture.asset("assets/images/detail_icon.svg")),
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
                            focusColor: Colors.black,
                            value: _bodyPartValue,
                            style: TextStyle(color: Colors.black),
                            iconEnabledColor: ColorConstants.lightGrey,
                            icon: Icon(Icons.arrow_drop_down_sharp),
                            iconSize: 32,
                            underline: Container(color: Colors.transparent),
                            items: Constants.BodyPartsList.map((items) {
                              return DropdownMenuItem(
                                value: items.bodyPart,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    items.bodyPart.toString(),
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Please choose a Body Area",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: D.H / 48,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: isOnlyRead
                                ? null
                                : (String? value) {
                                    setState(() {
                                      _bodyPartValue = value;
                                      for (int i = 0;
                                          i < Constants.BodyPartsList.length;
                                          i++) {
                                        if (Constants
                                                .BodyPartsList[i].bodyPart ==
                                            _bodyPartValue) {
                                          bodyPartId = Constants
                                              .BodyPartsList[i].bodyPartId!;
                                          print("dropdownvalueId:" +
                                              bodyPartId.toString());
                                        }
                                      }
                                      print("");
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
                        CustomBigTextFormField(
                            controller: desController,
                            readOnly: false,
                            validators: (e) {
                              if (desController.text == null ||
                                  desController.text == '') {
                                return '*Medication Name';
                              }
                            },
                            keyboardTYPE: TextInputType.text,
                            maxlength: 100,
                            maxline: 6,
                            obscured: false),
                        SizedBox(height: D.H / 40),
                        Text(
                          "Duration",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w700),
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
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      _selectDateStartDate(
                                          context, sDateController, sDate);
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
                                current
                                    ? Container(
                                        width: D.W / 2.9,
                                        height: D.H / 16,
                                      )
                                    : Container(
                                        width: D.W / 2.9,
                                        child: CustomDateField(
                                          onTap: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            _selectDateEndDate(context,
                                                eDateController, eDate);
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
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                      activeColor:
                                          ColorConstants.primaryBlueColor,
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
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Issue Is Ongoing",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 50,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: D.H / 30),
                        CustomButton(
                          color: ColorConstants.blueBtn,
                          onTap: () {
                            if (current) {
                              eDate = 0;
                            }
                            if (bodyPartId == 0) {
                              CommonUtils.showRedToastMessage(
                                  "Please Select Body Part");
                            } else if (desController.text.isEmpty) {
                              CommonUtils.showRedToastMessage(
                                  "Please Enter Description");
                            } else if (sDateController.text.isEmpty) {
                              CommonUtils.showRedToastMessage(
                                  "Please Select StartDate");
                            } else if (current == false &&
                                eDateController.text.isEmpty) {
                              CommonUtils.showRedToastMessage(
                                  "Please Select EndDate");
                            } else {
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

  Future<void> _selectDateStartDate(
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
        final String sDate = formatter2.format(picked);
        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(sDate);
        this.sDate = dateTimeFormat.millisecondsSinceEpoch;

      });
    }
  }


  Future<void> _selectDateEndDate(
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
        final String sDate = formatter2.format(picked);
        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(sDate);
        this.eDate = dateTimeFormat.millisecondsSinceEpoch;

      });
    }
  }

  Future<void> savePain() async {
    FocusManager.instance.primaryFocus?.unfocus();
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.savePain;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    print("IS BACK"+widget.isBack.toString());
    Map<String, dynamic> body = {
      "usersPainId": 0,
      "bodyPartId": bodyPartId,//
      "locationX": widget.x,//
      "locationY": widget.y,//
      "description": desController.text.toString(),//
      "startDate": sDate,//
      "endDate": eDate,//
      "current": current,
      "isBack": widget.isBack,
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
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => DashBoardScreen(1),
        ),
      );
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  void getIdPart() {
    setState(() {
      _bodyPartValue = widget.bodyPartName;
      for (int i = 0; i < Constants.BodyPartsList.length; i++) {
        if (Constants.BodyPartsList[i].bodyPart == _bodyPartValue) {
          bodyPartId = Constants.BodyPartsList[i].bodyPartId!;
          print("dropdownvalueId:" + bodyPartId.toString());
        }
      }
      print("");
    });
  }
}


