
import 'dart:convert';
import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/lab_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../../Constants/api_endpoint.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/preferences.dart';

class LabListScreen extends StatefulWidget {
  const LabListScreen({Key? key}) : super(key: key);

  @override
  State<LabListScreen> createState() => _LabListScreenState();
}

class _LabListScreenState extends State<LabListScreen> {
  List<LabListModel> labList= [];
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getTestResultData();
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
          SvgPicture.asset(
            "assets/images/ic_plus.svg",
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
                      return Container(
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
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
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
}

