import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/medication_model.dart';
import 'package:ehr/View/Screens/add_medication_screen.dart';
import 'package:ehr/View/Screens/add_suppliments_screen.dart';
import 'package:ehr/View/Screens/medication_detail_screen.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:ehr/View/Screens/supplement_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Constants/api_endpoint.dart';
import '../../Model/height_weight_model.dart';
import '../../Model/otp_verification_model.dart';
import '../../Model/supplement_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_white_textform_field.dart';

class HeightWeightScreen extends StatefulWidget {
  const HeightWeightScreen({Key? key}) : super(key: key);

  @override
  State<HeightWeightScreen> createState() => _HeightWeightScreenState();
}

class _HeightWeightScreenState extends State<HeightWeightScreen> {
  List<HeightWeightModel> heightWeightData = [];
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getHeightWeightData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Supplements",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
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
                                        "Add Height Weight",
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
                                      "Height(Cm)",
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
                                    padding: EdgeInsets
                                        .only(
                                        left: D.W /
                                            18,
                                        right: D.W /
                                            18),
                                    child:
                                    CustomWhiteTextFormField(
                                      controller:
                                      heightController,
                                      readOnly: false,
                                      validators:
                                          (e) {
                                        if (heightController
                                            .text ==
                                            null ||
                                            heightController
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
                                    ),),
                                  SizedBox(
                                      height: D.H / 60),
                                  Padding(
                                    padding: EdgeInsets
                                        .only(
                                        left: D.W /
                                            18,
                                        right: D.W /
                                            18),
                                    child: Text(
                                      "Weight(Kg)",
                                      style: GoogleFonts.heebo(
                                          fontSize:
                                          D.H /
                                              52,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    ),
                                  )
                                  ,
                                  SizedBox(
                                      height: D.H / 240),
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
                                      weightController,
                                      readOnly: false,
                                      validators:
                                          (e) {
                                        if (weightController
                                            .text ==
                                            null ||
                                            weightController
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
                                    ),),
                                  SizedBox(
                                      height: D.H / 40),
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
                                          if (heightController.text.isEmpty) {
                                            CommonUtils
                                                .showRedToastMessage(
                                                "Please Enter Height");
                                          } else if (weightController.text.isEmpty) {
                                            CommonUtils.showRedToastMessage("Please add Weight");

                                          } else {
                                            saveHeightWeightResult();
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
      body: heightWeightData.isEmpty
          ? Container()
          :Padding(
        padding:
        EdgeInsets.only(left: D.W / 22, right: D.W / 22, top: D.H / 30),
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
                  heightWeightData.length,
                  shrinkWrap: true,
                  physics:
                  NeverScrollableScrollPhysics(),
                  itemBuilder:
                      (BuildContext context,
                      int index) {
                    var millis =
                        heightWeightData[index]
                            .changedDate;
                    var dt = DateTime
                        .fromMillisecondsSinceEpoch(
                        millis!);
                    var d24 = DateFormat(
                        'dd/MM/yyyy')
                        .format(
                        dt); // 31/12/2000, 22:00

                    var date = d24.toString();
                    return Container(
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
                                        Padding(
                                          padding: EdgeInsets
                                              .all(D.W /
                                              60),
                                          child: SvgPicture
                                              .asset(
                                              "assets/images/ic_bowl.svg"),
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
                                        Row(
                                          children: [
                                            Text(
                                              "Height:",
                                              style: GoogleFonts.heebo(
                                                  fontSize: D.H /
                                                      56,
                                                  fontWeight:
                                                  FontWeight.w300),
                                            ),
                                            SizedBox(
                                              width:
                                              D.W / 70,
                                            ),
                                            Text(
                                              heightWeightData[
                                              index]
                                                  .height
                                                  .toString()+"cm",
                                              style: GoogleFonts.heebo(
                                                  fontSize: D.H /
                                                      52,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Weight:",
                                              style: GoogleFonts.heebo(
                                                  fontSize: D.H /
                                                      56,
                                                  fontWeight:
                                                  FontWeight.w300),
                                            ),
                                            SizedBox(
                                              width:
                                              D.W / 70,
                                            ),
                                            Text(
                                              heightWeightData[
                                              index]
                                                  .weight
                                                  .toString()+"kg",
                                              style: GoogleFonts.heebo(
                                                  fontSize: D.H /
                                                      52,
                                                  fontWeight:
                                                  FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets
                                      .only(
                                      right: D.W /
                                          30),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [

                                      Text(
                                        date.toString(),
                                        style: GoogleFonts.heebo(
                                            color: Colors
                                                .black
                                                .withOpacity(0.3)),
                                      )
                                    ],
                                  ),
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
                    );
                  }),
            ),
          ),
    );
  }

  Future<void> getHeightWeightData() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getHeightWeight;
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
        heightWeightData.add(HeightWeightModel(
          height: res[i]["height"],
          weight: res[i]["weight"],
          changedDate: res[i]["changedDate"],
        ));
      }
      CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> getHeightWeightDataWithoutLoader() async {

    final uri = ApiEndPoint.getHeightWeight;
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
      heightWeightData.clear();
      for (int i = 0; i < res.length; i++) {
        heightWeightData.add(HeightWeightModel(
          height: res[i]["height"],
          weight: res[i]["weight"],
          changedDate: res[i]["changedDate"],
        ));
      }

      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
  Future<void> saveHeightWeightResult() async {
    FocusManager.instance.primaryFocus?.unfocus();
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.update_height_weight;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "height": heightController.text.toString(),
      "weight": weightController.text.toString(),
    };
    //1657650600000


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
      heightController.clear();
      weightController.clear();
      CommonUtils.hideProgressDialog(context);
      Navigator.pop(context);
      setState(() {});
      getHeightWeightDataWithoutLoader();
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
