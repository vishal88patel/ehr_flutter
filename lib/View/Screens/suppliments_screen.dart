import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/medication_model.dart';
import 'package:ehr/View/Screens/add_medication_screen.dart';
import 'package:ehr/View/Screens/add_suppliments_screen.dart';
import 'package:ehr/View/Screens/medication_detail_screen.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:ehr/View/Screens/supplement_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Constants/api_endpoint.dart';
import '../../Model/otp_verification_model.dart';
import '../../Model/supplement_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';

class SupplimentScreen extends StatefulWidget {
  const SupplimentScreen({Key? key}) : super(key: key);

  @override
  State<SupplimentScreen> createState() => _SupplimentScreenState();
}

class _SupplimentScreenState extends State<SupplimentScreen> {
  List<SupplementModel> supplementData = [];
  OtpVerificationModel? getUserName = OtpVerificationModel();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getSupplimentData();
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
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddSupplementsScreen()))
                  .then((value) => getSupplimentDataWithoutLoader());
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
      body: supplementData.isNotEmpty?Padding(
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
              itemCount: supplementData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var millis = supplementData[index].startDate;
                var dt = DateTime.fromMillisecondsSinceEpoch(millis!);
                var d24 =
                    DateFormat('dd/MM/yyyy').format(dt); // 31/12/2000, 22:00

                var userName = getUserName!.firstName.toString();
                var date = d24.toString();
                return InkWell(
                  onTap: () {

                  },
                  child: Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          padding: EdgeInsets.all(0),
                          onPressed: (BuildContext context) {
                            setState(() {});
                            deleteSuppliment(supplementData[index].supplementId,index);

                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: CupertinoIcons.delete,
                        ),
                        SlidableAction(
                          padding: EdgeInsets.all(0),
                          onPressed: (BuildContext context) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SupplementDetailScreen(
                                      supplementId:supplementData[index].supplementId ,
                                      supplementName:supplementData[index].supplementName ,
                                      dosage: supplementData[index].dosage,
                                      withFoodId: supplementData[index].withFoodId,
                                      endDate:supplementData[index].endDate ,startDate:supplementData[index].startDate ,isOngoing:supplementData[index].isOngoing ,
                                    ))).then((value) => getSupplimentDataWithoutLoader());
                          },
                          backgroundColor: ColorConstants.primaryBlueColor,
                          foregroundColor: Colors.white,
                          icon: CupertinoIcons.pen,
                        ),
                      ],
                    ),
                    child:  Container(
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
                                        Text(
                                          supplementData[
                                          index]
                                              .supplementName
                                              .toString(),
                                          style: GoogleFonts.heebo(
                                              fontSize: D.H /
                                                  52,
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                        Text(
                                          supplementData[index].dosage!.toString(),
                                          style: GoogleFonts.heebo(
                                              color: ColorConstants
                                                  .blueBtn,
                                              fontSize: D.H /
                                                  66,
                                              fontWeight:
                                              FontWeight.w500),
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
                                      Row(
                                        children: [
                                          Container(
                                            height:
                                            D.W /
                                                30,
                                            width: D.W /
                                                30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(25)),
                                                color: ColorConstants.lightRed),
                                          ),
                                          SizedBox(
                                            width:
                                            3,
                                          ),
                                          Text(
                                            supplementData[index]
                                                .withFoodId
                                                .toString()=="1"?"With Food":supplementData[index]
                                                .withFoodId
                                                .toString()=="2"?"Before":supplementData[index]
                                                .withFoodId
                                                .toString()=="3"?"After":"N/A",
                                            style: GoogleFonts.heebo(
                                                color:
                                                Colors.black.withOpacity(0.3)),
                                          )
                                        ],
                                      ),
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
                    ),
                  ),
                );
              }),
        ),
      ):Container(),
    );
  }

  Future<void> getSupplimentData() async {
    getUserName =
        await PreferenceUtils.getDataObject("OtpVerificationResponse");
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getSuppliment;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "pageNumber": 1,
      "keyword": "",
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
      print("medication 200");
      for (int i = 0; i < res.length; i++) {
        supplementData.add(SupplementModel(
          supplementId: res[i]["supplementId"],
          supplementName: res[i]["supplementName"],
          dosage: res[i]["dosage"],
          withFoodId: res[i]["withFoodId"],
          startDate: res[i]["startDate"],
          endDate: res[i]["endDate"],
          created: res[i]["created"],
        ));
      }
      print("medication"+supplementData.length.toString());
      CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> getSupplimentDataWithoutLoader() async {
    getUserName =
        await PreferenceUtils.getDataObject("OtpVerificationResponse");
    final uri = ApiEndPoint.getSuppliment;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "pageNumber": 1,
      "keyword": "",
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
      supplementData.clear();
      for (int i = 0; i < res.length; i++) {
        supplementData.add(SupplementModel(
          supplementId: res[i]["supplementId"],
          supplementName: res[i]["supplementName"],
          dosage: res[i]["dosage"],
          withFoodId: res[i]["withFoodId"],
          startDate: res[i]["startDate"],
          endDate: res[i]["endDate"],
          created: res[i]["created"],
        ));
      }
      // CommonUtils.showGreenToastMessage("Data Fetched Successfully");
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> deleteSuppliment(var id, int index) async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.deleteSupplement;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "supplementId": id,
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
      supplementData.removeAt(index);
      CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
      CommonUtils.hideProgressDialog(context);
    }
  }
}
