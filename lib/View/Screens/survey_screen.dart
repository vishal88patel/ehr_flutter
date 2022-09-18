import 'dart:convert';

import 'package:ehr/Utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../Constants/api_endpoint.dart';
import '../../Constants/color_constants.dart';
import '../../CustomWidgets/custom_button.dart';
import '../../CustomWidgets/custom_date_field.dart';
import '../../Model/answer_model.dart';
import '../../Model/answer_model_for_survey.dart';
import '../../Model/qa_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_white_textform_field.dart';
import 'dash_board_screen.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<QAModel> questionList = [];
  List<AnswerModelForSurvey> mainAnswerList = [];
  bool value = false;
  TextEditingController valueController = TextEditingController();
  final labTestDate = TextEditingController();
  int sDate = 0;
  int eDate = 0;
  List<String> valueList = [];
  List<int> sDateList = [];
  List<int> eDateList = [];

  DateTime selectedDate = DateTime.now();
  var current = false;
  final sDateController = TextEditingController();
  final eDateController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200), () {
      getQuestionApi();
    });
    super.initState();
  }

  Future<void> getQuestionApi() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getQuestion;
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
    // changeRoute();
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      if (res != null) {
        for (int i = 0; i < res.length; i++) {
          List<Options> templist = [];
          for (int j = 0; j < res[i]["options"].length; j++) {
            templist.add(Options(
                questionId: res[i]["options"][j]["questionId"],
                optionId: res[i]["options"][j]["optionId"],
                optionText: res[i]["options"][j]["optionText"],
                optionValue: res[i]["options"][j]["optionValue"],
                isSelected: false));
          }
          questionList.add(QAModel(
              options: templist,
              questionId: res[i]["questionId"],
              questionText: res[i]["questionText"],
              shortCodeType: res[i]["shortCodeType"],
              shortCodeTypeId: res[i]["shortCodeTypeId"]));
        }
        CommonUtils.hideProgressDialog(context);
      }
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 0,
        toolbarHeight: 45,
        centerTitle: true,
        title: Text(
          "Survey",
          style: GoogleFonts.heebo(
              fontSize: D.H / 44, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: questionList.length,
              padding: EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // List<String> templocalList=[];templocalList.clear();
                // for(int i=0;i<getModel.data!.length;i++){
                //   if(getBrandsResponseModel.data![index].brandId==getModel.data![i].brandId){
                //     templocalList.add(getModel.data![i].modelName.toString());
                //   }
                // }
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        questionList[index].questionText.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: questionList[index].options!.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    color: Color(0xFFF0F0F0),
                                  ),
                                  child: ListTile(
                                      onTap: () {
                                        if (questionList[index].options![i]
                                            .isSelected ?? false) {
                                          removeFromList(
                                              ans: questionList[index]
                                                  .options![i].optionId
                                                  .toString(),
                                              mainIndex: index,
                                              subIndex: i);
                                        } else {
                                          valueController.clear();
                                          labTestDate.clear();
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                StatefulBuilder(
                                                  builder: (
                                                      BuildContext context,
                                                      void Function(
                                                          void Function())
                                                      setState) =>
                                                      AlertDialog(
                                                        contentPadding: EdgeInsets
                                                            .all(0),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .all(
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
                                                            MainAxisAlignment
                                                                .start,
                                                            mainAxisSize:
                                                            MainAxisSize.min,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    top: D.W /
                                                                        40,
                                                                    right: D.W /
                                                                        40),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap: () {
                                                                        Navigator
                                                                            .pop(
                                                                            context);
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .close,
                                                                        size: D
                                                                            .W /
                                                                            20,
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
                                                                    "Add Comment",
                                                                    style:
                                                                    GoogleFonts
                                                                        .heebo(
                                                                        fontSize:
                                                                        D.H /
                                                                            38,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: D
                                                                  .H / 60),
                                                              Container(
                                                                height: 1,
                                                                color:
                                                                ColorConstants
                                                                    .line,
                                                              ),
                                                              SizedBox(height: D
                                                                  .H / 60),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    left: D.W /
                                                                        18,
                                                                    right: D.W /
                                                                        18),
                                                                child: Text(
                                                                  "Type Value",
                                                                  style:
                                                                  GoogleFonts
                                                                      .heebo(
                                                                      fontSize:
                                                                      D.H / 52,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                                ),
                                                              ),
                                                              SizedBox(height: D
                                                                  .H / 240),
                                                              SizedBox(height: D
                                                                  .H / 240),
                                                              Padding(
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
                                                                  validators: (
                                                                      e) {
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
                                                                      .text,
                                                                  obscured: false,
                                                                  maxlength: 100,
                                                                  maxline: 1,
                                                                ),
                                                              ),
                                                              SizedBox(height: D
                                                                  .H / 40),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    left: D.W /
                                                                        24,
                                                                    right: D.W /
                                                                        24
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          "Start Date",
                                                                          style: GoogleFonts
                                                                              .heebo(
                                                                              fontSize: D
                                                                                  .H /
                                                                                  52,
                                                                              fontWeight: FontWeight
                                                                                  .w400),
                                                                        ),
                                                                        SizedBox(
                                                                            height: D
                                                                                .H /
                                                                                120),
                                                                        Container(
                                                                          width: D
                                                                              .W /
                                                                              2.9,
                                                                          child: CustomDateField(
                                                                            onTap: () {
                                                                              FocusManager
                                                                                  .instance
                                                                                  .primaryFocus
                                                                                  ?.unfocus();
                                                                              _selectDateS(
                                                                                  context,
                                                                                  sDateController,
                                                                                  sDate);
                                                                            },
                                                                            controller: sDateController,
                                                                            iconPath: "assets/images/ic_date.svg",
                                                                            readOnly: true,
                                                                            validators: (
                                                                                e) {
                                                                              if (sDateController
                                                                                  .text ==
                                                                                  null ||
                                                                                  sDateController
                                                                                      .text ==
                                                                                      '') {
                                                                                return '*Please enter Start Date';
                                                                              }
                                                                            },
                                                                            keyboardTYPE: TextInputType
                                                                                .text,
                                                                            obscured: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          "End Date",
                                                                          style: GoogleFonts
                                                                              .heebo(
                                                                              fontSize: D
                                                                                  .H /
                                                                                  52,
                                                                              fontWeight: FontWeight
                                                                                  .w400),
                                                                        ),
                                                                        SizedBox(
                                                                            height: D
                                                                                .H /
                                                                                120),
                                                                        current
                                                                            ? Container(
                                                                          width: D
                                                                              .W /
                                                                              2.9,
                                                                          height: D
                                                                              .H /
                                                                              16,
                                                                        )
                                                                            : Container(
                                                                          width: D
                                                                              .W /
                                                                              2.9,
                                                                          child: CustomDateField(
                                                                            onTap: () {
                                                                              FocusManager
                                                                                  .instance
                                                                                  .primaryFocus
                                                                                  ?.unfocus();
                                                                              _selectDateSE(
                                                                                  context,
                                                                                  eDateController,
                                                                                  eDate);
                                                                            },
                                                                            controller: eDateController,
                                                                            iconPath:
                                                                            "assets/images/ic_date.svg",
                                                                            readOnly: true,
                                                                            validators: (
                                                                                e) {
                                                                              if (eDateController
                                                                                  .text ==
                                                                                  null ||
                                                                                  eDateController
                                                                                      .text ==
                                                                                      '') {
                                                                                return '*Please enter End Date';
                                                                              }
                                                                            },
                                                                            keyboardTYPE:
                                                                            TextInputType
                                                                                .text,
                                                                            obscured: false,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .zero,
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Transform
                                                                            .scale(
                                                                          scale: 1.3,
                                                                          child: Checkbox(
                                                                              activeColor: ColorConstants
                                                                                  .primaryBlueColor,
                                                                              tristate: false,
                                                                              value: current,
                                                                              onChanged: (
                                                                                  bool? value) {
                                                                                setState(() {
                                                                                  current =
                                                                                  value!;
                                                                                  // eDateController
                                                                                  //     .text =
                                                                                  // "0";
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
                                                                    "Issue Is Ongoing",
                                                                    style: GoogleFonts
                                                                        .heebo(
                                                                        fontSize: D
                                                                            .H /
                                                                            50,
                                                                        fontWeight: FontWeight
                                                                            .w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              /*Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Container(
                                                        width: D.W / 2.9,
                                                        child: CustomDateField(
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
                                                    ),*/
                                                              Container(
                                                                height: 1,
                                                                color:
                                                                ColorConstants
                                                                    .line,
                                                              ),
                                                              SizedBox(height: D
                                                                  .H / 80),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () async {
                                                                      if (valueController
                                                                          .text
                                                                          .isEmpty) {
                                                                        CommonUtils
                                                                            .showRedToastMessage(
                                                                            "Please add Value");
                                                                      } else
                                                                      if (sDateController
                                                                          .text
                                                                          .isEmpty) {
                                                                        CommonUtils
                                                                            .showRedToastMessage(
                                                                            "Please enter Start Date");
                                                                      } else
                                                                      if (current ==
                                                                          false &&
                                                                          eDateController
                                                                              .text
                                                                              .isEmpty) {
                                                                        CommonUtils
                                                                            .showRedToastMessage(
                                                                            "Please enter End Date");
                                                                      } else {
                                                                        AnswerModelForSurvey ans = AnswerModelForSurvey(
                                                                            questionId: questionList[index]
                                                                                .options![i]
                                                                                .questionId,
                                                                            answers: questionList[index]
                                                                                .options![i]
                                                                                .optionId
                                                                                .toString(),
                                                                            startDate: sDate,
                                                                            endDate: current ==
                                                                                true
                                                                                ? 0
                                                                                : eDate,
                                                                            current: current,
                                                                            description: valueController
                                                                                .text);
                                                                        await saveAnswerToList(
                                                                            answer: ans,
                                                                            mainIndex: index,
                                                                            subIndex: i)
                                                                            .then((
                                                                            value) {
                                                                          Navigator
                                                                              .pop(
                                                                              context);
                                                                          valueController
                                                                              .clear();
                                                                          sDateController
                                                                              .clear();
                                                                          eDateController
                                                                              .clear();
                                                                          sDate =
                                                                          0;
                                                                          eDate =
                                                                          0;
                                                                          current =
                                                                          false;
                                                                          setState(() {});
                                                                        });
                                                                        // valueList.add(valueController.text.toString());
                                                                        // sDateList.add(int.parse(sDate.toString()));
                                                                        // eDateList.add(int.parse(eDate.toString()));

                                                                        // value=!value;
                                                                        // saveandbuildList(desc:
                                                                        //     valueController
                                                                        //         .text,
                                                                        //     labTestDate
                                                                        //         .text,index,i,true,questionList[index].options![i].questionId!);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      "OK",
                                                                      style: GoogleFonts
                                                                          .heebo(
                                                                          fontSize:
                                                                          D.H /
                                                                              33,
                                                                          color:
                                                                          ColorConstants
                                                                              .skyBlue,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(height: D
                                                                  .H / 80),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                          );
                                        }


                                        //   value=!value;
                                        // if (value) {
                                        // questionList[index]
                                        //     .options![i]
                                        //     .isSelected = true;
                                        // } else {
                                        // questionList[index]
                                        //     .options![i]
                                        //     .isSelected = false;
                                        // }
                                        // setState(() {});
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      leading: Transform.scale(
                                        scale: 1,
                                        child: Checkbox(
                                          activeColor:
                                          ColorConstants.checkBoxColor,
                                          side: BorderSide(
                                              width: 1, color: Colors.grey),
                                          onChanged: (bool? value) async {
                                            // if (value??false) {
                                            //   questionList[index]
                                            //       .options![i]
                                            //       .isSelected = true;
                                            // } else {
                                            //   questionList[index]
                                            //       .options![i]
                                            //       .isSelected = false;
                                            // }
                                            // setState(() {});
                                          },
                                          value: questionList[index]
                                              .options![i]
                                              .isSelected,
                                        ),
                                      ),
                                      horizontalTitleGap: 0,
                                      title: Text(
                                        questionList[index]
                                            .options![i]
                                            .optionText
                                            .toString(),
                                        style: GoogleFonts.heebo(
                                            color: questionList[index]
                                                .options![i]
                                                .isSelected ??
                                                false
                                                ? ColorConstants.checkBoxColor
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
            questionList.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                color: ColorConstants.blueBtn,
                onTap: () {
                  // List<AnswerModel> ansList = [];
                  // for (int i = 0; i < questionList.length; i++) {
                  //   var ss = "";
                  //   List<String> ll = [];
                  //
                  //   for (int j = 0;
                  //   j < questionList[i].options!.length;
                  //   j++) {
                  //     if (questionList[i].options![j].isSelected ??
                  //         false) {
                  //       ll.add(questionList[i]
                  //           .options![j]
                  //           .optionId
                  //           .toString());
                  //       //ss = ll.join(',');
                  //     }
                  //   }
                  //   ansList.add(AnswerModel(
                  //       answers: ll[i],
                  //       questionId: (questionList[i].questionId)));
                  // }
                  // saveSurvey(ansList);
                  //

                  callSaveSurvetApi();
                },
                text: "Done",
                textColor: Colors.white,
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
    //
  }

  Future<void> saveSurvey(List<AnswerModel> ansList) async {
    List<AnswerModel> tempanslist = [];
    for (int i = 0; i < ansList.length; i++) {
      if (ansList[i].answers!.isNotEmpty) {
        tempanslist.add(ansList[i]);
      }
    }
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveAnswer;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    // String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var rr = [];
    for (int i = 0; i < tempanslist.length; i++) {
      rr.add({
        "questionId": tempanslist[i].questionId,
        "answers": tempanslist[i].answers,
        "description": valueList[i],
        "current": eDateList[i] == 0 ? true : false,
        "startDate": sDateList[i],
        "endDate": eDateList[i],
      });
    }
    String jsonBody = json.encode(rr);
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
      NavigationHelpers.redirectto(context, DashBoardScreen(1));
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> callSaveSurvetApi() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveAnswer;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    // String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    var rr = [];
    for (int i = 0; i < mainAnswerList.length; i++) {
      rr.add({
        "questionId": mainAnswerList[i].questionId,
        "answers": mainAnswerList[i].answers,
        "description": mainAnswerList[i].description,
        "current": mainAnswerList[i].current,
        "startDate": mainAnswerList[i].startDate,
        "endDate": mainAnswerList[i].endDate,
      });
    }
    String jsonBody = json.encode(rr);
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
      NavigationHelpers.redirectto(context, DashBoardScreen(1));
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> _selectDateSE(BuildContext context, final controller,
      int Date) async {
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

  Future<void> _selectDateS(BuildContext context, final controller,
      int Date) async {
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
        print("Date:" + Date.toString());
      });
    }
  }

  void saveandbuildList(
      {required String desc, required String date, required int MainIndex, required int subIndex, required bool chekboxvalue, required int questionId}) {
    // if (chekboxvalue??false) {
    //   questionList[index]
    //       .options![i]
    //       .isSelected = true;
    //
    //   for (int j = 0; j < questionList[i].options!.length; j++) {
    //     if (questionList[i].options![j].isSelected ?? false) {
    //       ll.add(questionList[i].options![j].optionId.toString());
    //       ss = ll.join(',');
    //     }
    // } else {
    //   questionList[index]
    //       .options![i]
    //       .isSelected = false;
    // }

    // mainAnswerList.add(AnswerModelForSurvey(description: desc,answers: ,current: false,endDate:date ,questionId: ,startDate: date));
    setState(() {});
    Navigator.pop(context);
  }

  Future<void> saveAnswerToList(
      {required AnswerModelForSurvey answer, required int mainIndex, required int subIndex}) async {
    mainAnswerList.add(answer);
    questionList[mainIndex].options![subIndex].isSelected = true;
    print(mainAnswerList);
    setState(() {});
  }

  Future<void> removeFromList(
      {required String ans, required int mainIndex, required int subIndex}) async {

    for(int i=0;i<mainAnswerList.length;i++){
      if(mainAnswerList[i].answers==ans.toString()){
        mainAnswerList.removeWhere((element) => element.answers==ans.toString());
      }
    }
    questionList[mainIndex].options![subIndex].isSelected = false;
    setState(() {});
  }
}
