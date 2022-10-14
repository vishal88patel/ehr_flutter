import 'dart:convert';

import 'package:ehr/Constants/constants.dart';
import 'package:ehr/Model/pain_dashboard_model.dart';
import 'package:ehr/Utils/navigation_helper.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:ehr/View/Screens/survey_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../Constants/api_endpoint.dart';
import '../../Constants/color_constants.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/customAlertDialog.dart';
import 'body_detail_screen.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  _BodyScreenState createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  FlipCardController _flipCardController = FlipCardController();

  // bool isFlipped = false;
  bool showDrag = false;
  bool showDragBack = false;
  bool showdialog = false;
  bool showdialoggg = false;

  List<PainDashboardModel> painData = [];
  List<PainDashboardModel> frontPainData = [];
  List<PainDashboardModel> backPainData = [];
  int length = 0;
  int frontLength = 0;
  int backLength = 0;
  int index = 0;
  double x0 = 128.0;
  double y0 = 136.0;
  double x1 = 0.0;
  double y1 = 0.0;
  double x2 = 0.0;
  double y2 = 0.0;
  double x3 = 0.0;
  double y3 = 0.0;
  double x4 = 0.0;
  double y4 = 0.0;
  double x5 = 0.0;
  double y5 = 0.0;
  double x6 = 0.0;
  double y6 = 0.0;
  double x7 = 0.0;
  double y7 = 0.0;
  double x8 = 0.0;
  double y8 = 0.0;
  double x9 = 0.0;
  double y9 = 0.0;
  double x10 = 0.0;
  double y10 = 0.0;

  double xx0 = 128.0;
  double yy0 = 136.0;
  double xx1 = 0.0;
  double yy1 = 0.0;
  double xx2 = 0.0;
  double yy2 = 0.0;
  double xx3 = 0.0;
  double yy3 = 0.0;
  double xx4 = 0.0;
  double yy4 = 0.0;
  double xx5 = 0.0;
  double yy5 = 0.0;
  double xx6 = 0.0;
  double yy6 = 0.0;
  double xx7 = 0.0;
  double yy7 = 0.0;
  double xx8 = 0.0;
  double yy8 = 0.0;
  double xx9 = 0.0;
  double yy9 = 0.0;
  double xx10 = 0.0;
  double yy10 = 0.0;

  var bodyPartName = "";
  var _chosenValueOfYear = "";
  var usersPainId = 0;
  var bodyPartId = "";
  var description = "";
  var startDate = "";
  var endDate = "";
  bool current = false;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  String? _chosenValue;
  List<String>? countryCode = ['+91'];

  @override
  void initState() {
    print(D.H.toString());
    print(D.W.toString());
    _chosenValueOfYear = Constants.yearList[0];
    Future.delayed(Duration(milliseconds: 50), () {
      if (Constants.isBackBody) {
        cardKey.currentState!.toggleCard();
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPainApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 0,
        toolbarHeight: 45,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                NavigationHelpers.redirect(context, SurveyScreen());
              },
              child: Text(
                "Home",
                style: GoogleFonts.heebo(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              NavigationHelpers.redirect(context, ProfileScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                "assets/images/avatar.svg",
                height: 30,
                width: 30,
              ),
            ),
          ),
          Container(
            width: 5,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Diagnosis History",
                  style: GoogleFonts.heebo(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    if (Constants.isBackBody) {
                      Constants.isBackBody = false;
                      _flipCardController.toggleCard();
                      setState(() {});
                    } else {
                      Constants.isBackBody = true;
                      _flipCardController.toggleCard();
                      setState(() {});
                    }
                  },
                  child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.primaryBlueColor,
                            //                   <--- border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      height: 50,
                      child: Center(
                          child: Text(
                        Constants.isBackBody ? "Frontside" : "Backside",
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.primaryBlueColor),
                      ))),
                ),
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       if(length>=10){
                //         CommonUtils.showRedToastMessage("You did not set circle more then 5");
                //       }else{
                //         showDrag = true;
                //         x0 = 128.0;
                //         y0 = 136.0;
                //         showdialog=false;
                //       }
                //     });
                //   },
                //   child: Container(
                //       width: 30,
                //       height: 30,
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //             color: ColorConstants.primaryBlueColor,
                //             //                   <--- border color
                //             width: 2.0,
                //           ),
                //           borderRadius: BorderRadius.all(Radius.circular(12))),
                //       child: Center(
                //           child: Text(
                //             " + ",
                //             style: GoogleFonts.roboto(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w700,
                //                 color: ColorConstants.primaryBlueColor),
                //           ))),
                // ),
              ],
            ),
            Stack(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.grey.withOpacity(0.5),
                              width: 250,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Container(
                                  height: 16,
                                ),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(
                                      left: D.W / 30, right: D.W / 60),
                                  width: MediaQuery.of(context).size.width,
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
                                    focusColor: Colors.black,
                                    value: _chosenValueOfYear,
                                    style: TextStyle(color: Colors.black),
                                    iconEnabledColor: ColorConstants.lightGrey,
                                    icon: Icon(Icons.arrow_drop_down_sharp),
                                    iconSize: 32,
                                    underline:
                                        Container(color: Colors.transparent),
                                    items: Constants.yearList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _chosenValueOfYear = value!;
                                      });
                                      getPainApi();
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 421,
                            width: 264,
                            child: GestureDetector(
                              child: FlipCard(
                                key: cardKey,
                                flipOnTouch: false,
                                fill: Fill.fillBack,
                                controller: _flipCardController,
                                direction: FlipDirection.HORIZONTAL,
                                front: Stack(
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onTapUp: (TapUpDetails details) {
                                          /*var offsetX =
                                              details.localPosition.dx - 10;
                                          var offsetY =
                                              details.localPosition.dy;
                                          print(offsetX.toString() +
                                              ":" +
                                              offsetY.toString());
                                          if (offsetX.toInt() >= 120 &&
                                              offsetX.toInt() <= 140 &&
                                              offsetY.toInt() >= 10 &&
                                              offsetY.toInt() <= 18) {
                                            print("BodyPart:" + "Brain");
                                            bodyPartName = "Brain";
                                          } else if (offsetX.toInt() >= 130 &&
                                              offsetX.toInt() <= 145 &&
                                              offsetY.toInt() >= 95 &&
                                              offsetY.toInt() <= 110) {
                                            print("BodyPart:" + "Heart");
                                            bodyPartName = "Heart";
                                          } else if (offsetX.toInt() >= 128 &&
                                              offsetX.toInt() <= 141 &&
                                              offsetY.toInt() >= 117 &&
                                              offsetY.toInt() <= 125) {
                                            print("BodyPart:" + "Pancreas");
                                            bodyPartName = "Pancreas";
                                          } else if (offsetX.toInt() >= 113 &&
                                              offsetX.toInt() <= 147 &&
                                              offsetY.toInt() >= 137 &&
                                              offsetY.toInt() <= 158) {
                                            print("BodyPart:" + "Kidney");
                                            bodyPartName = "Kidney";
                                          } else if (offsetX.toInt() >= 121 &&
                                              offsetX.toInt() <= 135 &&
                                              offsetY.toInt() >= 170 &&
                                              offsetY.toInt() <= 180) {
                                            print("BodyPart:" + "Bladder");
                                            bodyPartName = "Bladder";
                                          } else if ((offsetX.toInt() >= 102 &&
                                                  offsetX.toInt() <= 123 &&
                                                  offsetY.toInt() >= 290 &&
                                                  offsetY.toInt() <= 370) ||
                                              (offsetX.toInt() >= 130 &&
                                                  offsetX.toInt() <= 158 &&
                                                  offsetY.toInt() >= 290 &&
                                                  offsetY.toInt() <= 370)) {
                                            print("BodyPart:" + "leg");
                                            bodyPartName = "Leg";
                                          } else if (offsetX.toInt() >= 97 &&
                                              offsetX.toInt() <= 160 &&
                                              offsetY.toInt() >= 80 &&
                                              offsetY.toInt() <= 112) {
                                            print("BodyPart:" + "Lungs");
                                            bodyPartName = "Lungs";
                                          } else if ((offsetX.toInt() >= 20 &&
                                                  offsetX.toInt() <= 96 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168) ||
                                              (offsetX.toInt() >= 182 &&
                                                  offsetX.toInt() <= 225 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168)) {
                                            print("BodyPart:" + "Arm");
                                            bodyPartName = "Arm";
                                          } else if (offsetX.toInt() >= 112 &&
                                              offsetX.toInt() <= 122 &&
                                              offsetY.toInt() >= 120 &&
                                              offsetY.toInt() <= 138) {
                                            print("BodyPart:" + "Liver");
                                            bodyPartName = "Liver";
                                          } else if (offsetX.toInt() >= 120 &&
                                              offsetX.toInt() <= 130 &&
                                              offsetY.toInt() >= 181 &&
                                              offsetY.toInt() <= 187) {
                                            print("BodyPart:" +
                                                "Reproductive System");
                                            bodyPartName =
                                                "Reproductive System";
                                          } else {
                                            bodyPartName = "None";
                                            print("BodyPart:" + "None");
                                          }

                                          if (bodyPartName != "None") {
                                            if (painData.length > 10) {
                                              CommonUtils.showRedToastMessage(
                                                  "you can not add pain more than 10");
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BodyDetailScreen(
                                                              bodyPartName:
                                                                  bodyPartName,
                                                              isBack: Constants
                                                                  .isBackBody,
                                                              x: offsetX,
                                                              y: offsetY))).then(
                                                  (value) =>
                                                      bodyPartName = "None");
                                            }
                                          } else {
                                            CommonUtils.showRedToastMessage(
                                                'Please select valid body part');
                                          }*/
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Image.asset(
                                            "assets/images/front_part.png",
                                            height: 400,
                                            width: 240,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        frontLength >= 1
                                            ? Positioned(
                                                left: x1,
                                                top: y1,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 2
                                            ? Positioned(
                                                left: x2,
                                                top: y2,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 3
                                            ? Positioned(
                                                left: x3,
                                                top: y3,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.yellow),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 4
                                            ? Positioned(
                                                left: x4,
                                                top: y4,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.orange),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 5
                                            ? Positioned(
                                                left: x5,
                                                top: y5,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 6
                                            ? Positioned(
                                                left: x6,
                                                top: y6,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 7
                                            ? Positioned(
                                                left: x7,
                                                top: y7,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 8
                                            ? Positioned(
                                                left: x8,
                                                top: y8,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors
                                                            .tealAccent),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 9
                                            ? Positioned(
                                                left: x9,
                                                top: y9,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors
                                                            .deepPurpleAccent),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 10
                                            ? Positioned(
                                                left: x10,
                                                top: y10,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                                back: Stack(
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onTapUp: (TapUpDetails details) {
                                          /*var offsetX =
                                              details.localPosition.dx;
                                          var offsetY =
                                              details.localPosition.dy + 14.00;
                                          print(offsetX.toString() +
                                              ":" +
                                              offsetY.toString());
                                          if (offsetX.toInt() >= 120 &&
                                              offsetX.toInt() <= 140 &&
                                              offsetY.toInt() >= 10 &&
                                              offsetY.toInt() <= 18) {
                                            print("BodyPart:" + "Brain");
                                            bodyPartName = "Brain";
                                          } else if (offsetX.toInt() >= 130 &&
                                              offsetX.toInt() <= 145 &&
                                              offsetY.toInt() >= 95 &&
                                              offsetY.toInt() <= 110) {
                                            print("BodyPart:" + "Heart");
                                            bodyPartName = "Heart";
                                          } else if (offsetX.toInt() >= 128 &&
                                              offsetX.toInt() <= 141 &&
                                              offsetY.toInt() >= 117 &&
                                              offsetY.toInt() <= 125) {
                                            print("BodyPart:" + "Pancreas");
                                            bodyPartName = "Pancreas";
                                          } else if (offsetX.toInt() >= 113 &&
                                              offsetX.toInt() <= 147 &&
                                              offsetY.toInt() >= 137 &&
                                              offsetY.toInt() <= 158) {
                                            print("BodyPart:" + "Kidney");
                                            bodyPartName = "Kidney";
                                          } else if (offsetX.toInt() >= 121 &&
                                              offsetX.toInt() <= 135 &&
                                              offsetY.toInt() >= 170 &&
                                              offsetY.toInt() <= 180) {
                                            print("BodyPart:" + "Bladder");
                                            bodyPartName = "Bladder";
                                          } else if ((offsetX.toInt() >= 102 &&
                                                  offsetX.toInt() <= 123 &&
                                                  offsetY.toInt() >= 290 &&
                                                  offsetY.toInt() <= 370) ||
                                              (offsetX.toInt() >= 130 &&
                                                  offsetX.toInt() <= 158 &&
                                                  offsetY.toInt() >= 290 &&
                                                  offsetY.toInt() <= 370)) {
                                            print("BodyPart:" + "leg");
                                            bodyPartName = "Leg";
                                          } else if (offsetX.toInt() >= 97 &&
                                              offsetX.toInt() <= 160 &&
                                              offsetY.toInt() >= 80 &&
                                              offsetY.toInt() <= 112) {
                                            print("BodyPart:" + "Lungs");
                                            bodyPartName = "Lungs";
                                          } else if ((offsetX.toInt() >= 20 &&
                                                  offsetX.toInt() <= 96 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168) ||
                                              (offsetX.toInt() >= 182 &&
                                                  offsetX.toInt() <= 225 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168)) {
                                            print("BodyPart:" + "Arm");
                                            bodyPartName = "Arm";
                                          } else if (offsetX.toInt() >= 112 &&
                                              offsetX.toInt() <= 122 &&
                                              offsetY.toInt() >= 120 &&
                                              offsetY.toInt() <= 138) {
                                            print("BodyPart:" + "Liver");
                                            bodyPartName = "Liver";
                                          } else if (offsetX.toInt() >= 120 &&
                                              offsetX.toInt() <= 130 &&
                                              offsetY.toInt() >= 181 &&
                                              offsetY.toInt() <= 187) {
                                            print("BodyPart:" +
                                                "Reproductive System");
                                            bodyPartName =
                                                "Reproductive System";
                                          } else {
                                            bodyPartName = "None";
                                            print("BodyPart:" + "None");
                                          }

                                          if (bodyPartName != "None") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BodyDetailScreen(
                                                            bodyPartName:
                                                                bodyPartName,
                                                            isBack: Constants
                                                                .isBackBody,
                                                            x: offsetX,
                                                            y: offsetY))).then(
                                                (value) =>
                                                    bodyPartName = "None");
                                          } else {
                                            CommonUtils.showRedToastMessage(
                                                'Please select valid body part');
                                          }*/
                                        },
                                        child: Image.asset(
                                          "assets/images/backtestbody.png",
                                          height: 400,
                                          width: 240,
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        backLength >= 1
                                            ? Positioned(
                                                left: xx1,
                                                top: yy1,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 2
                                            ? Positioned(
                                                left: xx2,
                                                top: yy2,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 3
                                            ? Positioned(
                                                left: xx3,
                                                top: yy3,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.yellow),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 4
                                            ? Positioned(
                                                left: xx4,
                                                top: yy4,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.orange),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 5
                                            ? Positioned(
                                                left: xx5,
                                                top: yy5,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 6
                                            ? Positioned(
                                                left: xx6,
                                                top: yy6,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 7
                                            ? Positioned(
                                                left: xx7,
                                                top: yy7,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 8
                                            ? Positioned(
                                                left: xx8,
                                                top: yy8,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors
                                                            .tealAccent),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 9
                                            ? Positioned(
                                                left: xx9,
                                                top: yy9,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors
                                                            .deepPurpleAccent),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 10
                                            ? Positioned(
                                                left: xx10,
                                                top: yy10,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white,
                                                            width: 1.5),
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstants.primaryBlueColor,
        onPressed: () {
          // showDrag=false;
          if (showDrag) {
            CommonUtils.showRedToastMessage("Please save the pain first");
          } else if (showDragBack) {
            CommonUtils.showRedToastMessage("Please save the pain first");
          } else if (painData.length >= 10) {
            CommonUtils.showRedToastMessage(
                "you can not add pain more than 10");
          } else {
            //showDrag = false;
           // showDragBack = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BodyDetailScreen(
                        bodyPartName: "None",
                        isBack: Constants.isBackBody,
                        x: 0.0,
                        y: 0.0))).then((value) => setState(() {
                  getPainApi();
                }));
          }
        },
        label: Text(
          "Add Comment",
          style: GoogleFonts.heebo(
              fontSize: D.H / 52, fontWeight: FontWeight.w400),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> getPainApi() async {
    final uri = ApiEndPoint.painDashboard;
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
    painData.clear();
    frontPainData.clear();
    backPainData.clear();
    var tempFirstSortedYearList = [];
    tempFirstSortedYearList.clear();
    if (statusCode == 200) {
      if (_chosenValueOfYear != "All years") {
        for (int i = 0; i < res.length; i++) {
          var mydtStart =
              DateTime.fromMillisecondsSinceEpoch(res[i]["startDate"].toInt());
          var myd24Start = DateFormat('yyyy').format(mydtStart);
          if (myd24Start.toString() == _chosenValueOfYear) {
            tempFirstSortedYearList.add((res[i]));
          }
        }
      } else {
        tempFirstSortedYearList.addAll(res);
      }

      for (int i = 0; i < tempFirstSortedYearList.length; i++) {
        painData.add(PainDashboardModel(
            bodyPart: tempFirstSortedYearList[i]["bodyPart"],
            bodyPartId: tempFirstSortedYearList[i]["bodyPartId"],
            created: tempFirstSortedYearList[i]["created"],
            current: tempFirstSortedYearList[i]["current"],
            description: tempFirstSortedYearList[i]["description"],
            endDate: tempFirstSortedYearList[i]["endDate"],
            locationX: tempFirstSortedYearList[i]["locationX"],
            locationY: tempFirstSortedYearList[i]["locationY"],
            isBack: tempFirstSortedYearList[i]["isBack"],
            startDate: tempFirstSortedYearList[i]["startDate"],
            usersPainId: tempFirstSortedYearList[i]["usersPainId"]));
      }

      for (int i = 0; i < painData.length; i++) {
        if (painData[i].isBack == true) {
          backPainData.add(painData[i]);
        } else {
          frontPainData.add(painData[i]);
        }
      }

      length = painData.length;
      frontLength = frontPainData.length;
      backLength = backPainData.length;
      print("length:" + length.toString());
      print("frontLength:" + frontLength.toString());
      print("backLength:" + backLength.toString());

      frontPainData = frontPainData.reversed.toList();
      backPainData = backPainData.reversed.toList();

      if (frontPainData.length == 1) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        print("x1:" + x1.toString());
        print("y1:" + y1.toString());

      } else if (frontPainData.length == 2) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        print("x2:" + x2.toString());
        print("y2:" + y2.toString());

      } else if (frontPainData.length == 3) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();

      } else if (frontPainData.length == 4) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();

      } else if (frontPainData.length == 5) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();
        x5 = frontPainData[4].locationX!.toDouble();
        y5 = frontPainData[4].locationY!.toDouble();

      } else if (frontPainData.length == 6) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();
        x5 = frontPainData[4].locationX!.toDouble();
        y5 = frontPainData[4].locationY!.toDouble();
        x6 = frontPainData[5].locationX!.toDouble();
        y6 = frontPainData[5].locationY!.toDouble();

      } else if (frontPainData.length == 7) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();
        x5 = frontPainData[4].locationX!.toDouble();
        y5 = frontPainData[4].locationY!.toDouble();
        x6 = frontPainData[5].locationX!.toDouble();
        y6 = frontPainData[5].locationY!.toDouble();
        x7 = frontPainData[6].locationX!.toDouble();
        y7 = frontPainData[6].locationY!.toDouble();

      } else if (frontPainData.length == 8) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();
        x5 = frontPainData[4].locationX!.toDouble();
        y5 = frontPainData[4].locationY!.toDouble();
        x6 = frontPainData[5].locationX!.toDouble();
        y6 = frontPainData[5].locationY!.toDouble();
        x7 = frontPainData[6].locationX!.toDouble();
        y7 = frontPainData[6].locationY!.toDouble();
        x8 = frontPainData[7].locationX!.toDouble();
        y8 = frontPainData[7].locationY!.toDouble();

      } else if (frontPainData.length == 9) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();
        x5 = frontPainData[4].locationX!.toDouble();
        y5 = frontPainData[4].locationY!.toDouble();
        x6 = frontPainData[5].locationX!.toDouble();
        y6 = frontPainData[5].locationY!.toDouble();
        x7 = frontPainData[6].locationX!.toDouble();
        y7 = frontPainData[6].locationY!.toDouble();
        x8 = frontPainData[7].locationX!.toDouble();
        y8 = frontPainData[7].locationY!.toDouble();
        x9 = frontPainData[8].locationX!.toDouble();
        y9 = frontPainData[8].locationY!.toDouble();

      } else if (frontPainData.length == 10) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();
        x5 = frontPainData[4].locationX!.toDouble();
        y5 = frontPainData[4].locationY!.toDouble();
        x6 = frontPainData[5].locationX!.toDouble();
        y6 = frontPainData[5].locationY!.toDouble();
        x7 = frontPainData[6].locationX!.toDouble();
        y7 = frontPainData[6].locationY!.toDouble();
        x8 = frontPainData[7].locationX!.toDouble();
        y8 = frontPainData[7].locationY!.toDouble();
        x9 = frontPainData[8].locationX!.toDouble();
        y9 = frontPainData[8].locationY!.toDouble();
        x10 = frontPainData[9].locationX!.toDouble();
        y10 = frontPainData[9].locationY!.toDouble();
      } else {


      }

      if (backPainData.length == 1) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();

      } else if (backPainData.length == 2) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();

      } else if (backPainData.length == 3) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();

      } else if (backPainData.length == 4) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();

      } else if (backPainData.length == 5) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();
        xx5 = backPainData[4].locationX!.toDouble();
        yy5 = backPainData[4].locationY!.toDouble();

      } else if (backPainData.length == 6) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();
        xx5 = backPainData[4].locationX!.toDouble();
        yy5 = backPainData[4].locationY!.toDouble();
        xx6 = backPainData[5].locationX!.toDouble();
        yy6 = backPainData[5].locationY!.toDouble();

      } else if (backPainData.length == 7) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();
        xx5 = backPainData[4].locationX!.toDouble();
        yy5 = backPainData[4].locationY!.toDouble();
        xx6 = backPainData[5].locationX!.toDouble();
        yy6 = backPainData[5].locationY!.toDouble();
        xx7 = backPainData[6].locationX!.toDouble();
        yy7 = backPainData[6].locationY!.toDouble();

      } else if (backPainData.length == 8) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();
        xx5 = backPainData[4].locationX!.toDouble();
        yy5 = backPainData[4].locationY!.toDouble();
        xx6 = backPainData[5].locationX!.toDouble();
        yy6 = backPainData[5].locationY!.toDouble();
        xx7 = backPainData[6].locationX!.toDouble();
        yy7 = backPainData[6].locationY!.toDouble();
        xx8 = backPainData[7].locationX!.toDouble();
        yy8 = backPainData[7].locationY!.toDouble();

      } else if (backPainData.length == 9) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();
        xx5 = backPainData[4].locationX!.toDouble();
        yy5 = backPainData[4].locationY!.toDouble();
        xx6 = backPainData[5].locationX!.toDouble();
        yy6 = backPainData[5].locationY!.toDouble();
        xx7 = backPainData[6].locationX!.toDouble();
        yy7 = backPainData[6].locationY!.toDouble();
        xx8 = backPainData[7].locationX!.toDouble();
        yy8 = backPainData[7].locationY!.toDouble();
        xx9 = backPainData[8].locationX!.toDouble();
        yy9 = backPainData[8].locationY!.toDouble();

      } else if (backPainData.length == 10) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();
        xx5 = backPainData[4].locationX!.toDouble();
        yy5 = backPainData[4].locationY!.toDouble();
        xx6 = backPainData[5].locationX!.toDouble();
        yy6 = backPainData[5].locationY!.toDouble();
        xx7 = backPainData[6].locationX!.toDouble();
        yy7 = backPainData[6].locationY!.toDouble();
        xx8 = backPainData[7].locationX!.toDouble();
        yy8 = backPainData[7].locationY!.toDouble();
        xx9 = backPainData[8].locationX!.toDouble();
        yy9 = backPainData[8].locationY!.toDouble();
        xx10 = backPainData[9].locationX!.toDouble();
        yy10 = backPainData[9].locationY!.toDouble();
      } else {

      }

    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
    if (mounted) {
      setState(() {});
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
    double xxx = 0.0;
    double yyy = 0.0;
    if (Constants.isBackBody) {
      xxx = xx0;
      yyy = yy0;
    } else {
      xxx = x0;
      yyy = y0;
    }
    Map<String, dynamic> body = {
      "usersPainId": usersPainId,
      "bodyPartId": bodyPartId,
      "locationX": xxx,
      "locationY": yyy,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "current": current,
      "isBack": Constants.isBackBody,
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
      CommonUtils.showGreenToastMessage(res["message"]);
      Navigator.pop(context);
      getPainApi();
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

}
