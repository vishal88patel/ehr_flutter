import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/medication_model.dart';
import 'package:ehr/View/Screens/add_medication_screen.dart';
import 'package:ehr/View/Screens/medication_detail_screen.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
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
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  List<MedicationModel> medicationData = [];
  OtpVerificationModel? getUserName = OtpVerificationModel();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getMedicationData();
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
              "Medication",
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
                          builder: (context) => AddMedicationScreen()))
                  .then((value) => getMedicationDataWithoutLoader());
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
      body: medicationData.isNotEmpty?Padding(
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
              itemCount: medicationData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var millis = medicationData[index].created;
                var dt = DateTime.fromMillisecondsSinceEpoch(millis!);
                var d24 =
                    DateFormat('dd/MM/yyyy').format(dt); // 31/12/2000, 22:00

                var userName = getUserName!.firstName.toString();
                var date = d24.toString();
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicationDetailScreen(
                                  medicationName: medicationData[index]
                                      .medicationName
                                      .toString(),
                                  dosage: medicationData[index]
                                      .dosage
                                      .toString(),
                                  dosageType: medicationData[index]
                                      .dosageType
                                      .toString(),
                                  medicationFood: medicationData[index]
                                      .medicationFood
                                      .toString(),
                                  startDate: medicationData[index].startDate,
                                  endDate: medicationData[index].endDate,
                                  frequencyType: medicationData[index]
                                      .frequencyType
                                      .toString(),
                                )));
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
                            deleteMedication(medicationData[index].usersMedicationId,index);

                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          label: "Delete",
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: D.W / 40.0, top: D.H / 80),
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Card(
                                        color: ColorConstants.bgImage,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        elevation: 0,
                                        child: Padding(
                                          padding: EdgeInsets.all(D.W / 60),
                                          child: SvgPicture.asset(
                                              "assets/images/ic_bowl.svg"),
                                        )),
                                    SizedBox(
                                      width: D.W / 50,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          medicationData[index]
                                              .medicationName
                                              .toString(),
                                          style: GoogleFonts.heebo(
                                              fontSize: D.H / 52,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${medicationData[index].dosage! + " " + "${medicationData[index].dosageType! + " "}" + "${medicationData[index].frequencyType}"}",
                                          // "Hil 250 mg 2/Day",
                                          style: GoogleFonts.heebo(
                                              color: ColorConstants.blueBtn,
                                              fontSize: D.H / 66,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     SvgPicture.asset(
                                        //         "assets/images/ic_doctor.svg"),
                                        //     Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           left: 2.0, top: 2.0),
                                        //       child: Text(
                                        //         userName.toString(),
                                        //         style: GoogleFonts.heebo(
                                        //             color:
                                        //                 ColorConstants.darkText,
                                        //             fontSize: D.H / 66,
                                        //             fontWeight: FontWeight.w400),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: D.W / 30),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: D.W / 30,
                                            width: D.W / 30,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                                color: ColorConstants.lightRed),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            medicationData[index]
                                                .medicationFood
                                                .toString(),
                                            style: GoogleFonts.heebo(
                                                color: Colors.black
                                                    .withOpacity(0.3)),
                                          )
                                        ],
                                      ),
                                      Text(
                                        date.toString(),
                                        style: GoogleFonts.heebo(
                                            color: Colors.black.withOpacity(0.3)),
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
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: Container(
                                height: 1.0,
                                color: ColorConstants.lineColor,
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

  Future<void> getMedicationData() async {
    getUserName =
        await PreferenceUtils.getDataObject("OtpVerificationResponse");
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getMedications;
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
        medicationData.add(MedicationModel(
          usersMedicationId: res[i]["usersMedicationId"],
          medicationName: res[i]["medicationName"],
          dosage: res[i]["dosage"],
          dosageId: res[i]["dosageId"],
          dosageType: res[i]["dosageType"],
          foodId: res[i]["foodId"],
          medicationFood: res[i]["medicationFood"],
          startDate: res[i]["startDate"],
          endDate: res[i]["endDate"],
          frequencyId: res[i]["frequencyId"],
          frequencyType: res[i]["frequencyType"],
          created: res[i]["created"],
        ));
      }
      print("medication"+medicationData.length.toString());
      CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> getMedicationDataWithoutLoader() async {
    getUserName =
        await PreferenceUtils.getDataObject("OtpVerificationResponse");
    final uri = ApiEndPoint.getMedications;
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
      medicationData.clear();
      for (int i = 0; i < res.length; i++) {
        medicationData.add(MedicationModel(
          usersMedicationId: res[i]["usersMedicationId"],
          medicationName: res[i]["medicationName"],
          dosage: res[i]["dosage"],
          dosageId: res[i]["dosageId"],
          dosageType: res[i]["dosageType"],
          foodId: res[i]["foodId"],
          medicationFood: res[i]["medicationFood"],
          startDate: res[i]["startDate"],
          endDate: res[i]["endDate"],
          frequencyId: res[i]["frequencyId"],
          frequencyType: res[i]["frequencyType"],
          created: res[i]["created"],
        ));
      }
      // CommonUtils.showGreenToastMessage("Data Fetched Successfully");
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> deleteMedication(var id, int index) async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.deleteMedication;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersMedicationId": id,
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
      medicationData.removeAt(index);
      CommonUtils.hideProgressDialog(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
      CommonUtils.hideProgressDialog(context);
    }
  }
}
