import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/testResultType_model.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Constants/api_endpoint.dart';
import '../../CustomWidgets/chart_widget.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Model/lab_list_model.dart';
import '../../Model/lab_screen_response_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_date_field.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class LabListScreen extends StatefulWidget {
  const LabListScreen({Key? key}) : super(key: key);

  @override
  State<LabListScreen> createState() => _LabListScreenState();
}

class _LabListScreenState extends State<LabListScreen> {
  List<TestResults> labListData = [];

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
        centerTitle: true,
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
                    itemCount:
                    labListData.length,
                    shrinkWrap: true,
                    physics:
                    NeverScrollableScrollPhysics(),
                    itemBuilder:
                        (BuildContext context,
                        int index) {
                      var millis =
                          labListData[index]
                              .values?.last.created;
                      var dt = DateTime
                          .fromMillisecondsSinceEpoch(
                          millis!);
                      var d24 = DateFormat(
                          'dd/MM/yyyy')
                          .format(
                          dt);
                      return InkWell(
                        onTap: (){
                          showDialouge(name:labListData[index].testResultName.toString(),values:labListData);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: D.W / 40.0,
                              top: D.H / 80),
                          child: Center(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                            color: ColorConstants
                                                .bgImage,
                                            shape:
                                            const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .only(
                                                topLeft:
                                                Radius.circular(8),
                                                topRight:
                                                Radius.circular(8),
                                                bottomLeft:
                                                Radius.circular(8),
                                                bottomRight:
                                                Radius.circular(8),
                                              ),
                                            ),
                                            elevation:
                                            0,
                                            child:
                                            Container(
                                              height: D.W/8,
                                              width: D.W/8,
                                              child: Padding(
                                                padding: EdgeInsets
                                                    .all(D.W /
                                                    60),
                                                child: Image
                                                    .asset(
                                                    "assets/images/graph.png"),
                                              ),
                                            )),
                                        SizedBox(
                                          width:
                                          D.W / 50,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              labListData[
                                              index]
                                                  .testResultName
                                                  .toString(),
                                              style: GoogleFonts.heebo(
                                                  fontSize: D.H /
                                                      52,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Last Updated : ",
                                                  style: GoogleFonts.heebo(
                                                      color: ColorConstants.darkText,
                                                      fontSize: D.H / 66,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 2.0,
                                                      top: 2.0),
                                                  child:
                                                  Text(
                                                    d24.toString(),
                                                    style: GoogleFonts.heebo(
                                                        color: ColorConstants.darkText,
                                                        fontSize: D.H / 66,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: D.H / 80,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets
                                      .only(
                                      left: 4.0,
                                      right: 4.0),
                                  child: Container(
                                    height: 1.0,
                                    color:
                                    ColorConstants
                                        .lineColor,
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
        labListData.add(TestResults(
          testResultName: res[i]["testResultName"],
          values: res[i]["values"]
        ));
      }
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("Data Fetched Successfully");
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
  showDialouge({
    required String name,
    required List<TestResults> values,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) =>
                Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    name.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      name,
                                      style: GoogleFonts.heebo(
                                          color: ColorConstants.light,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 26,
                              ),
                              Container(
                                height: 350,
                                child: GraphWidget(graphList:values),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: ColorConstants.line,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "OK",
                              style: GoogleFonts.heebo(
                                  color: Colors.blue, fontSize: 25),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
          );
        });
  }
}
