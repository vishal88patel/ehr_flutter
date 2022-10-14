
import 'dart:convert';
import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/lab_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Constants/api_endpoint.dart';
import '../../CustomWidgets/custom_date_field.dart';
import '../../Model/testResultType_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_white_textform_field.dart';

class LabListScreen extends StatefulWidget {
  const LabListScreen({Key? key}) : super(key: key);

  @override
  State<LabListScreen> createState() => _LabListScreenState();
}

class _LabListScreenState extends State<LabListScreen> {
  List<LabListModel> labList= [];
  int positiveOrnegative = 1;
  var testTypeId = 0;
  var showFormField = "";
  bool askForName = false;
  final valueController = TextEditingController();
  final tasteNameController = TextEditingController();
  bool isPositive = true;
  String? _choosenLabValue;
  List<TestResultData> testResultTypesData = [];
  final labTestDate = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int eDate = 0;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getTestResultData();
      getTestResultTypes();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        title: Center(
          child: Text(
            "Labs",
            style: GoogleFonts.heebo(
                fontSize: D.H / 44, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              isPositive = true;
              positiveOrnegative = 1;
              valueController.text = "";
              tasteNameController.text = "";
              _choosenLabValue = testResultTypesData[0].testType;
              testTypeId = testResultTypesData[0].testTypeId!;
              var textModel = testResultTypesData
                  .where((element) =>
              element.testType ==
                  _choosenLabValue);
              showFormField = textModel
                  .first.shortCodeType
                  .toString();
              askForName =
              textModel.first.askForName!;
              labTestDate.text = "";
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(
                              void Function())
                          setState) =>
                          AlertDialog(
                            contentPadding:
                            EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            content: Container(
                              width: D.W / 1.25,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                mainAxisSize:
                                MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.only(
                                        top: D.W / 40,
                                        right:
                                        D.W / 40),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(
                                                context);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: D.W / 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Text(
                                        "Add Test results",
                                        style: GoogleFonts.heebo(
                                            fontSize:
                                            D.H / 38,
                                            fontWeight:
                                            FontWeight
                                                .w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: D.H / 60),
                                  Container(
                                    height: 1,
                                    color:
                                    ColorConstants.line,
                                  ),
                                  SizedBox(
                                      height: D.H / 60),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(
                                        left: D.W / 18,
                                        right:
                                        D.W / 18),
                                    child: Text(
                                      "Type",
                                      style:
                                      GoogleFonts.heebo(
                                          fontSize:
                                          D.H / 52,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    ),
                                  ),
                                  SizedBox(
                                      height: D.H / 240),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(
                                        left: D.W / 18,
                                        right:
                                        D.W / 18),
                                    child: Container(
                                      padding:
                                      EdgeInsets.only(
                                          left:
                                          D.W / 30,
                                          right:
                                          D.W / 60),
                                      width: MediaQuery.of(
                                          context)
                                          .size
                                          .width,
                                      decoration: BoxDecoration(
                                          color:
                                          Colors.white,
                                          border: Border.all(
                                              color: ColorConstants
                                                  .border),
                                          borderRadius: BorderRadius
                                              .all(Radius
                                              .circular(
                                              8))),
                                      child: DropdownButton<
                                          String>(
                                        isExpanded: true,
                                        focusColor:
                                        Colors.black,
                                        value:
                                        _choosenLabValue,
                                        style: TextStyle(
                                            color: Colors
                                                .black),
                                        iconEnabledColor:
                                        ColorConstants
                                            .lightGrey,
                                        icon: Icon(Icons
                                            .arrow_drop_down_sharp),
                                        iconSize: 32,
                                        underline: Container(
                                            color: Colors
                                                .transparent),
                                        items:
                                        testResultTypesData
                                            .map(
                                                (items) {
                                              return DropdownMenuItem(
                                                value: items
                                                    .testType,
                                                child: Padding(
                                                  padding: EdgeInsets
                                                      .only(
                                                      left:
                                                      10),
                                                  child: Text(
                                                    items
                                                        .testType
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                        15.0),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                        hint: Text(
                                          "Type",
                                          style: TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize:
                                              D.H / 48,
                                              fontWeight:
                                              FontWeight
                                                  .w400),
                                        ),
                                        onChanged: (String?
                                        value) {
                                          setState(() {
                                            _choosenLabValue =
                                                value;
                                            var textModel = testResultTypesData.where(
                                                    (element) =>
                                                element
                                                    .testType ==
                                                    _choosenLabValue);
                                            showFormField = textModel.first.shortCodeType;
                                            askForName = textModel.first.askForName!;
                                            for (int i = 0;
                                            i < testResultTypesData.length; i++) {
                                              if (testResultTypesData[i].testType == _choosenLabValue) {
                                                testTypeId = testResultTypesData[i].testTypeId!;
                                                print("dropdownvalueId:" + testTypeId.toString());
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: D.H / 60),
                                  askForName
                                      ? Padding(
                                    padding: EdgeInsets
                                        .only(
                                        left: D.W /
                                            18,
                                        right: D.W /
                                            18),
                                    child: Text(
                                      "Enter Test Name",
                                      style: GoogleFonts.heebo(
                                          fontSize:
                                          D.H /
                                              52,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    ),
                                  )
                                      : Container(),
                                  askForName
                                      ? SizedBox(
                                      height: D.H / 240)
                                      : Container(),
                                  askForName
                                      ? Padding(
                                    padding: EdgeInsets
                                        .only(
                                        left: D.W /
                                            18,
                                        right: D.W /
                                            18),
                                    child:
                                    CustomWhiteTextFormField(
                                      controller:
                                      tasteNameController,
                                      readOnly: false,
                                      validators:
                                          (e) {
                                        if (tasteNameController
                                            .text ==
                                            null ||
                                            tasteNameController
                                                .text ==
                                                '') {
                                          return '*Enter test nname';
                                        }
                                      },
                                      keyboardTYPE:
                                      TextInputType
                                          .text,
                                      obscured: false,
                                      maxlength: 100,
                                      maxline: 1,
                                    ),
                                  )
                                      : Container(),
                                  askForName
                                      ? SizedBox(
                                      height: D.H / 240)
                                      : Container(),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(
                                        left: D.W / 18,
                                        right:
                                        D.W / 18),
                                    child: Text(
                                      "Value",
                                      style:
                                      GoogleFonts.heebo(
                                          fontSize:
                                          D.H / 52,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    ),
                                  ),
                                  SizedBox(
                                      height: D.H / 240),
                                  showFormField == "Textbox"
                                      ? Padding(
                                    padding: EdgeInsets
                                        .only(
                                        left: D.W /
                                            18,
                                        right: D.W /
                                            18),
                                    child:
                                    CustomWhiteTextFormField(
                                      controller:
                                      valueController,
                                      readOnly: false,
                                      validators:
                                          (e) {
                                        if (valueController
                                            .text ==
                                            null ||
                                            valueController
                                                .text ==
                                                '') {
                                          return '*Value';
                                        }
                                      },
                                      keyboardTYPE:
                                      TextInputType
                                          .number,
                                      obscured: false,
                                      maxlength: 100,
                                      maxline: 1,
                                    ),
                                  )
                                      : showFormField ==
                                      "Radiobutton"
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: D.W /
                                            18,
                                        right: D.W /
                                            18),
                                    child:
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          InkWell(
                                            child:
                                            Container(
                                              height:
                                              D.W / 22,
                                              width:
                                              D.W / 22,
                                              decoration:
                                              new BoxDecoration(
                                                color: isPositive ? ColorConstants.primaryBlueColor : ColorConstants.innerColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.white,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                            ),
                                            onTap:
                                                () {
                                              setState(() {
                                                isPositive = true;
                                                positiveOrnegative = 1;
                                                valueController.text = positiveOrnegative.toString();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                              width:
                                              D.W / 60),
                                          Text(
                                            "(+) Positive",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width:
                                            29,
                                          ),
                                          InkWell(
                                            child:
                                            Container(
                                              height:
                                              D.W / 19,
                                              width:
                                              D.W / 19,
                                              decoration:
                                              new BoxDecoration(
                                                color: isPositive ? ColorConstants.innerColor : ColorConstants.primaryBlueColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.white,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                            ),
                                            onTap:
                                                () {
                                              setState(() {
                                                isPositive = false;
                                                positiveOrnegative = 0;
                                                valueController.text = positiveOrnegative.toString();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                              width:
                                              D.W / 60),
                                          Text(
                                            "(-) Negative",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  SizedBox(
                                      height: D.H / 40),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(
                                        left: D.W / 18,
                                        right:
                                        D.W / 18),
                                    child: Container(
                                      width: D.W / 2.9,
                                      child:
                                      CustomDateField(
                                        onTap: () {
                                          FocusManager
                                              .instance
                                              .primaryFocus
                                              ?.unfocus();
                                          _selectDateSE(
                                              context,
                                              labTestDate,
                                              eDate);
                                        },
                                        controller:
                                        labTestDate,
                                        iconPath:
                                        "assets/images/ic_date.svg",
                                        readOnly: true,
                                        validators: (e) {
                                          if (labTestDate
                                              .text ==
                                              null ||
                                              labTestDate
                                                  .text ==
                                                  '') {
                                            return '*Please enter Date';
                                          }
                                        },
                                        keyboardTYPE:
                                        TextInputType
                                            .text,
                                        obscured: false,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color:
                                    ColorConstants.line,
                                  ),
                                  SizedBox(
                                      height: D.H / 80),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (_choosenLabValue!
                                              .isEmpty) {
                                            CommonUtils
                                                .showRedToastMessage(
                                                "Please Select Type");
                                          } else if (askForName==false && showFormField!="Radiobutton" && valueController.text.isEmpty) {
                                            CommonUtils.showRedToastMessage("Please add Value");
                                          } else if (labTestDate
                                              .text
                                              .isEmpty) {
                                            CommonUtils
                                                .showRedToastMessage(
                                                "Please enter date");
                                          } else if (askForName &&
                                              tasteNameController
                                                  .text
                                                  .isEmpty) {
                                            CommonUtils
                                                .showRedToastMessage(
                                                "Please enter TasteName");
                                          } else {
                                            if(valueController.text.isEmpty){
                                              isPositive = true;
                                              positiveOrnegative = 1;
                                              valueController.text = positiveOrnegative.toString();

                                            }
                                            saveTestResult();
                                          }
                                        },
                                        child: Text(
                                          "OK",
                                          style: GoogleFonts.heebo(
                                              fontSize:
                                              D.H / 33,
                                              color: ColorConstants
                                                  .skyBlue,
                                              fontWeight:
                                              FontWeight
                                                  .w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: D.H / 80),
                                ],
                              ),
                            ),
                          ),
                    ),
              );
            },
            child: SvgPicture.asset(
              "assets/images/ic_plus.svg",
            ),
          ),
          Container(
            width: D.W / 36,
          )
        ],
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: D.W / 22, right: D.W / 22, top: D.H / 30),
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: ListView.builder(
                    itemCount: labList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.all(0),
                              onPressed: (BuildContext context) {
                                setState(() {});
                                deleteTestResult( labList[index].usersTestResultId,index);
                                // medicationData.removeAt(index);
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        child: Container(
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: D.W / 30.0,right: D.W / 30.0, top: D.H / 80),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        labList[index].testResultType.toString(),
                                        style: GoogleFonts.heebo(
                                            fontSize: D.H / 52,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        labList[index].testResultValue.toString(),
                                        style: GoogleFonts.heebo(
                                            fontSize: D.H / 52,
                                            color: ColorConstants.blueText,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: D.H / 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                                  child: Container(
                                    height: 1.0,
                                    color: ColorConstants.lineColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
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
        print("Date:" + Date.toString());
      });
    }
  }

  Future<void> getTestResultData() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getTestResult;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "pageNumber": 1,
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
      for (int i = 0; i < res.length; i++) {
        labList.add(LabListModel(
            created: res[i]["created"],
            testDate: res[i]["testDate"],
            testResultId:res[i]["testResultId"] ,
            testResultType: res[i]["testResultType"],
            testResultValue:res[i]["testResultValue"] ,
            usersTestResultId:res[i]["usersTestResultId"],
        ));
      }
      CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> deleteTestResult(var id, int index) async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.deleteTestResults;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersTestResultId": id,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await delete(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      CommonUtils.showGreenToastMessage(res["message"]);
      labList.removeAt(index);
      CommonUtils.hideProgressDialog(context);

      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
      CommonUtils.hideProgressDialog(context);

    }
  }
  Future<void> getTestResultDataWithoutLoader() async {
    labList.clear();
    //CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getTestResult;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "pageNumber": 1,
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
      for (int i = 0; i < res.length; i++) {
        labList.add(LabListModel(
          created: res[i]["created"],
          testDate: res[i]["testDate"],
          testResultId:res[i]["testResultId"] ,
          testResultType: res[i]["testResultType"],
          testResultValue:res[i]["testResultValue"] ,
          usersTestResultId:res[i]["usersTestResultId"],
        ));
      }
      //CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
      CommonUtils.hideProgressDialog(context);
    }
  }

  Future<void> getTestResultTypes() async {
    final uri = ApiEndPoint.getTestResultType;
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
      for (int i = 0; i < res.length; i++) {
        testResultTypesData.add(TestResultData(
            testType: res[i]["testType"],
            testTypeId: res[i]["testTypeId"],
            sequence: res[i]["sequence"],
            askForName: res[i]["askForName"],
            shortCodeType: res[i]["shortCodeType"],
            shortCodeTypeId: res[i]["shortCodeTypeId"]));
      }
      print("testResultTypesData" + testResultTypesData.toString());
      testTypeId = testResultTypesData[0].testTypeId!;
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> saveTestResult() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveTestResult;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersTestResultId": 0,
      "testResultId": testTypeId,
      "testResultName": tasteNameController.text,
      "testResultValue": valueController.text.toString(),
      "testDate": eDate,
    };
    //1657650600000

    var mydtStart = DateTime.fromMillisecondsSinceEpoch(eDate.toInt());
    var myd24Start = DateFormat('dd/MM/yyyy').format(mydtStart);

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
      setState(() {});
      getTestResultDataWithoutLoader();
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}

