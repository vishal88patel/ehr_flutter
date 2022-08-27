import 'dart:convert';

import 'package:ehr/Utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../Constants/api_endpoint.dart';
import '../../Constants/color_constants.dart';
import '../../CustomWidgets/custom_button.dart';
import '../../Model/answer_model.dart';
import '../../Model/qa_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import 'dash_board_screen.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<QAModel> questionList = [];
  bool value=false;
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
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Color(0xFFF0F0F0),
                                  ),
                                  child: ListTile(
                                    onTap: (){
                                        value=!value;
                                      if (value ?? false) {
                                      questionList[index]
                                          .options![i]
                                          .isSelected = true;
                                      } else {
                                      questionList[index]
                                          .options![i]
                                          .isSelected = false;
                                      }
                                      setState(() {});
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
                        List<AnswerModel> ansList = [];
                        for (int i = 0; i < questionList.length; i++) {
                          var ss = "";
                          List<String> ll = [];

                          for (int j = 0;
                              j < questionList[i].options!.length;
                              j++) {
                            if (questionList[i].options![j].isSelected ??
                                false) {
                              ll.add(questionList[i]
                                  .options![j]
                                  .optionId
                                  .toString());
                              ss = ll.join(',');
                            }
                          }
                          ansList.add(AnswerModel(
                              answers: ss,
                              questionId: (questionList[i].questionId)));
                        }
                        saveSurvey(ansList);
                        //
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
    List<AnswerModel> tempanslist=[];
    for(int i=0;i<ansList.length;i++){
     if(ansList[i].answers!.isNotEmpty){
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
    var rr=[];
    for(int i=0;i<tempanslist.length;i++){
      rr.add({"questionId":tempanslist[i].questionId,"answers":tempanslist[i].answers});
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
}
