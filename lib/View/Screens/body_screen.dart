import 'dart:convert';

import 'package:ehr/Constants/constants.dart';
import 'package:ehr/Model/pain_dashboard_model.dart';
import 'package:ehr/Utils/navigation_helper.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
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
  bool showdialog = false;
  bool showdialoggg = false;
  Color colorrr = Colors.blue;
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
            Text(
              "Home",
              style: GoogleFonts.heebo(fontWeight: FontWeight.normal),
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
                            height:421,
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
                                          var offsetX =
                                              details.localPosition.dx - 10;
                                          var offsetY =
                                              details.localPosition.dy;
                                          print(offsetX.toString() +
                                              ":" +
                                              offsetY.toString());
                                          if ((offsetX.toInt() >= 53 &&
                                                  offsetX.toInt() <= 68 &&
                                                  offsetY.toInt() >= 130 &&
                                                  offsetY.toInt() <= 145) ||
                                              (offsetX.toInt() >= 179 &&
                                                  offsetX.toInt() <= 193 &&
                                                  offsetY.toInt() >= 130 &&
                                                  offsetY.toInt() <= 145)) {
                                            print("BodyPart:" + "elbow");
                                            bodyPartName = "Elbow";
                                          } else if ((offsetX.toInt() >= 111 &&
                                                  offsetX.toInt() <= 116 &&
                                                  offsetY.toInt() >= 373 &&
                                                  offsetY.toInt() <= 384) ||
                                              offsetX.toInt() >= 143 &&
                                                  offsetX.toInt() <= 148 &&
                                                  offsetY.toInt() >= 373 &&
                                                  offsetY.toInt() <= 384) {
                                            print("BodyPart:" + "ankle");
                                            bodyPartName = "Ankle";
                                          } else if ((offsetX.toInt() >= 120 &&
                                                  offsetX.toInt() <= 127 &&
                                                  offsetY.toInt() >= 380 &&
                                                  offsetY.toInt() <= 395) ||
                                              (offsetX.toInt() >= 133 &&
                                                  offsetX.toInt() <= 140 &&
                                                  offsetY.toInt() >= 380 &&
                                                  offsetY.toInt() <= 395)) {
                                            print("BodyPart:" + "heel");
                                            bodyPartName = "Heel";
                                          } else if ((offsetX.toInt() >= 90 &&
                                                  offsetX.toInt() <= 113 &&
                                                  offsetY.toInt() >= 385 &&
                                                  offsetY.toInt() <= 397) ||
                                              (offsetX.toInt() >= 144 &&
                                                  offsetX.toInt() <= 156 &&
                                                  offsetY.toInt() >= 385 &&
                                                  offsetY.toInt() <= 397)) {
                                            print("BodyPart:" + "feet");
                                            bodyPartName = "Feet";
                                          } else if ((offsetX.toInt() >= 100 &&
                                                  offsetX.toInt() <= 160 &&
                                                  offsetY.toInt() >= 280 &&
                                                  offsetY.toInt() <= 295) ||
                                              (offsetX.toInt() >= 132 &&
                                                  offsetX.toInt() <= 157 &&
                                                  offsetY.toInt() >= 280 &&
                                                  offsetY.toInt() <= 295)) {
                                            print("BodyPart:" + "Knee");
                                            bodyPartName = "Knee";
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
                                            print("BodyPart:" + "chest");
                                            bodyPartName = "Chest";
                                          } else if ((offsetX.toInt() >= 20 &&
                                                  offsetX.toInt() <= 96 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168) ||
                                              (offsetX.toInt() >= 182 &&
                                                  offsetX.toInt() <= 225 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168)) {
                                            print("BodyPart:" + "Arm");
                                            bodyPartName = "Arms";
                                          } else if ((offsetX.toInt() >= 70 &&
                                                  offsetX.toInt() <= 96 &&
                                                  offsetY.toInt() >= 60 &&
                                                  offsetY.toInt() <= 102) ||
                                              (offsetX.toInt() >= 163 &&
                                                  offsetX.toInt() <= 185 &&
                                                  offsetY.toInt() >= 60 &&
                                                  offsetY.toInt() <= 102)) {
                                            print("BodyPart:" + "Shoulder");
                                            bodyPartName = "Shoulders";
                                          } else if ((offsetX.toInt() >= 90 &&
                                                  offsetX.toInt() <= 125 &&
                                                  offsetY.toInt() >= 215 &&
                                                  offsetY.toInt() <= 275) ||
                                              (offsetX.toInt() >= 128 &&
                                                  offsetX.toInt() <= 165 &&
                                                  offsetY.toInt() >= 215 &&
                                                  offsetY.toInt() <= 275)) {
                                            print("BodyPart:" + "Thighs");
                                            bodyPartName = "Thigh";
                                          } else {
                                            bodyPartName = "None";
                                            print("BodyPart:" + "None");
                                          }

                                          if (bodyPartName != "None") {
                                            if (painData.length > 10) {
                                              CommonUtils.showRedToastMessage(
                                                  "you can not add pain more than 10");
                                            }
                                           else{
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
                                          }
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
                                        showDrag
                                            ? Positioned(
                                                left: x0,
                                                top: y0,
                                                child: InkWell(
                                                  onTap: () {
                                                    showDrag = false;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BodyDetailScreen(
                                                                    bodyPartName:
                                                                        bodyPartName,
                                                                    isBack: Constants
                                                                        .isBackBody,
                                                                    x: x0,
                                                                    y: y0))).then(
                                                        (value) =>
                                                            getPainApi());
                                                  },
                                                  child: Draggable(
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
                                                          color: colorrr),
                                                      child: Center(
                                                          child: Text("?")),
                                                    ),
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        x0 = dragDetails
                                                                .offset.dx - 52;
                                                        y0 = dragDetails
                                                                .offset.dy - 245;

                                                        print(x0.toString() +
                                                            "," +
                                                            y0.toString());
                                                        if ((x0.toInt() >= 53 &&
                                                                x0.toInt() <=
                                                                    68 &&
                                                                y0.toInt() >=
                                                                    130 &&
                                                                y0.toInt() <=
                                                                    145) ||
                                                            (x0.toInt() >=
                                                                    179 &&
                                                                x0.toInt() <=
                                                                    193 &&
                                                                y0.toInt() >=
                                                                    130 &&
                                                                y0.toInt() <=
                                                                    145)) {
                                                          print("BodyPart:" +
                                                              "elbow");
                                                          bodyPartName =
                                                              "Elbow";
                                                        } else if ((x0.toInt() >=
                                                                    111 &&
                                                                x0.toInt() <=
                                                                    116 &&
                                                                y0.toInt() >=
                                                                    373 &&
                                                                y0.toInt() <=
                                                                    384) ||
                                                            x0.toInt() >= 143 &&
                                                                x0.toInt() <=
                                                                    148 &&
                                                                y0.toInt() >=
                                                                    373 &&
                                                                y0.toInt() <=
                                                                    384) {
                                                          print("BodyPart:" +
                                                              "ankle");
                                                          bodyPartName =
                                                              "Ankle";
                                                        } else if ((x0.toInt() >=
                                                                    120 &&
                                                                x0.toInt() <=
                                                                    127 &&
                                                                y0.toInt() >=
                                                                    380 &&
                                                                y0.toInt() <=
                                                                    395) ||
                                                            (x0.toInt() >= 133 &&
                                                                x0.toInt() <=
                                                                    140 &&
                                                                y0.toInt() >=
                                                                    380 &&
                                                                y0.toInt() <=
                                                                    395)) {
                                                          print("BodyPart:" +
                                                              "heel");
                                                          bodyPartName = "Heel";
                                                        } else if ((x0.toInt() >=
                                                                    90 &&
                                                                x0.toInt() <=
                                                                    113 &&
                                                                y0.toInt() >=
                                                                    385 &&
                                                                y0.toInt() <=
                                                                    397) ||
                                                            (x0.toInt() >=
                                                                    144 &&
                                                                x0.toInt() <=
                                                                    156 &&
                                                                y0.toInt() >=
                                                                    385 &&
                                                                y0.toInt() <=
                                                                    397)) {
                                                          print("BodyPart:" +
                                                              "feet");
                                                          bodyPartName = "Feet";
                                                        } else if ((x0.toInt() >=
                                                                    100 &&
                                                                x0.toInt() <=
                                                                    160 &&
                                                                y0.toInt() >=
                                                                    280 &&
                                                                y0.toInt() <=
                                                                    295) ||
                                                            (x0.toInt() >= 132 &&
                                                                x0.toInt() <=
                                                                    157 &&
                                                                y0.toInt() >=
                                                                    280 &&
                                                                y0.toInt() <=
                                                                    295)) {
                                                          print("BodyPart:" +
                                                              "Knee");
                                                          bodyPartName = "Knee";
                                                        } else if ((x0.toInt() >=
                                                                    102 &&
                                                                x0.toInt() <=
                                                                    123 &&
                                                                y0.toInt() >=
                                                                    290 &&
                                                                y0.toInt() <=
                                                                    370) ||
                                                            (x0.toInt() >= 130 &&
                                                                x0.toInt() <=
                                                                    158 &&
                                                                y0.toInt() >=
                                                                    290 &&
                                                                y0.toInt() <=
                                                                    370)) {
                                                          print("BodyPart:" +
                                                              "leg");
                                                          bodyPartName = "Leg";
                                                        } else if (x0.toInt() >=
                                                                97 &&
                                                            x0.toInt() <= 160 &&
                                                            y0.toInt() >= 80 &&
                                                            y0.toInt() <= 112) {
                                                          print("BodyPart:" +
                                                              "chest");
                                                          bodyPartName =
                                                              "Chest";
                                                        } else if ((x0.toInt() >=
                                                                    20 &&
                                                                x0.toInt() <=
                                                                    96 &&
                                                                y0.toInt() >=
                                                                    96 &&
                                                                y0.toInt() <=
                                                                    168) ||
                                                            (x0.toInt() >= 190 &&
                                                                x0.toInt() <=
                                                                    225 &&
                                                                y0.toInt() >=
                                                                    96 &&
                                                                y0.toInt() <=
                                                                    168)) {
                                                          print("BodyPart:" +
                                                              "Arm");
                                                          bodyPartName = "Arms";
                                                        } else if ((x0.toInt() >=
                                                                    70 &&
                                                                x0.toInt() <=
                                                                    96 &&
                                                                y0.toInt() >=
                                                                    60 &&
                                                                y0.toInt() <=
                                                                    102) ||
                                                            (x0.toInt() >= 163 &&
                                                                x0.toInt() <=
                                                                    185 &&
                                                                y0.toInt() >=
                                                                    60 &&
                                                                y0.toInt() <=
                                                                    102)) {
                                                          print("BodyPart:" +
                                                              "Shoulder");
                                                          bodyPartName =
                                                              "Shoulders";
                                                        } else if ((x0.toInt() >=
                                                                    90 &&
                                                                x0.toInt() <=
                                                                    125 &&
                                                                y0.toInt() >=
                                                                    215 &&
                                                                y0.toInt() <=
                                                                    275) ||
                                                            (x0.toInt() >=
                                                                    128 &&
                                                                x0.toInt() <=
                                                                    165 &&
                                                                y0.toInt() >=
                                                                    215 &&
                                                                y0.toInt() <=
                                                                    275)) {
                                                          print("BodyPart:" +
                                                              "Thighs");
                                                          bodyPartName =
                                                              "Thigh";
                                                        } else {
                                                          bodyPartName="None";
                                                          print("BodyPart:" +
                                                              "None");
                                                        }
                                                        var dialog =
                                                            CustomAlertDialog(
                                                                title: "Alert",
                                                                message:
                                                                    "Are you sure, do you want save pain here?",
                                                                positiveBtnText:
                                                                    'Yes',
                                                                negativeBtnText:
                                                                    'No',
                                                                onPostivePressed:
                                                                    () {
                                                                  showDrag =
                                                                      false;
                                                                  savePain();
                                                                },
                                                                onNegativePressed:
                                                                    () {});

                                                        if(bodyPartName=="None"){
                                                           x0 = 128.0;
                                                           y0 = 136.0;
                                                           CommonUtils.showRedToastMessage('Please select valid body part');
                                                        }
                                                        else{
                                                          showdialog
                                                              ? showDialog(
                                                              context:
                                                              context,
                                                              builder:
                                                                  (BuildContext
                                                              context) =>
                                                              dialog)
                                                              : Container();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 1
                                            ? Positioned(
                                                left: x1,
                                                top: y1,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x1 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y1 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 1
                                            ? Positioned(
                                                left: x1,
                                                top: y1,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 0,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 2
                                            ? Positioned(
                                                left: x2,
                                                top: y2,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x2 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y2 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 2
                                            ? Positioned(
                                                left: x2,
                                                top: y2,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 1,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 3
                                            ? Positioned(
                                                left: x3,
                                                top: y3,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x3 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y3 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 3
                                            ? Positioned(
                                                left: x3,
                                                top: y3,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 2,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 4
                                            ? Positioned(
                                                left: x4,
                                                top: y4,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x4 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y4 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 4
                                            ? Positioned(
                                                left: x4,
                                                top: y4,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 3,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 5
                                            ? Positioned(
                                                left: x5,
                                                top: y5,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x5 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y5 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 5
                                            ? Positioned(
                                                left: x5,
                                                top: y5,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 4,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 6
                                            ? Positioned(
                                                left: x6,
                                                top: y6,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x6 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y6 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 6
                                            ? Positioned(
                                                left: x6,
                                                top: y6,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 5,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 7
                                            ? Positioned(
                                                left: x7,
                                                top: y7,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x7 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y7 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 7
                                            ? Positioned(
                                                left: x7,
                                                top: y7,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 6,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 8
                                            ? Positioned(
                                                left: x8,
                                                top: y8,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x8 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y8 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 8
                                            ? Positioned(
                                                left: x8,
                                                top: y8,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 7,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 9
                                            ? Positioned(
                                                left: x9,
                                                top: y9,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x9 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y9 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 9
                                            ? Positioned(
                                                left: x9,
                                                top: y9,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 8,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        frontLength >= 10
                                            ? Positioned(
                                                left: x10,
                                                top: y10,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.indigo),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        x10 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        y10 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        frontLength >= 10
                                            ? Positioned(
                                                left: x10,
                                                top: y10,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 9,
                                                        list: frontPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container()
                                      ],
                                    ),
                                  ],
                                ),
                                back: Stack(
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onTapUp: (TapUpDetails details) {
                                          var offsetX =
                                              details.localPosition.dx;
                                          var offsetY =
                                              details.localPosition.dy + 14.00;
                                          print(offsetX.toString() +
                                              ":" +
                                              offsetY.toString());
                                          if ((offsetX.toInt() >= 53 &&
                                                  offsetX.toInt() <= 68 &&
                                                  offsetY.toInt() >= 130 &&
                                                  offsetY.toInt() <= 145) ||
                                              (offsetX.toInt() >= 179 &&
                                                  offsetX.toInt() <= 193 &&
                                                  offsetY.toInt() >= 130 &&
                                                  offsetY.toInt() <= 145)) {
                                            print("BodyPart:" + "elbow");
                                            bodyPartName = "Elbow";
                                          } else if ((offsetX.toInt() >= 111 &&
                                                  offsetX.toInt() <= 116 &&
                                                  offsetY.toInt() >= 373 &&
                                                  offsetY.toInt() <= 384) ||
                                              offsetX.toInt() >= 143 &&
                                                  offsetX.toInt() <= 148 &&
                                                  offsetY.toInt() >= 373 &&
                                                  offsetY.toInt() <= 384) {
                                            print("BodyPart:" + "ankle");
                                            bodyPartName = "Ankle";
                                          } else if ((offsetX.toInt() >= 120 &&
                                                  offsetX.toInt() <= 127 &&
                                                  offsetY.toInt() >= 380 &&
                                                  offsetY.toInt() <= 395) ||
                                              (offsetX.toInt() >= 133 &&
                                                  offsetX.toInt() <= 140 &&
                                                  offsetY.toInt() >= 380 &&
                                                  offsetY.toInt() <= 395)) {
                                            print("BodyPart:" + "heel");
                                            bodyPartName = "Heel";
                                          } else if ((offsetX.toInt() >= 90 &&
                                                  offsetX.toInt() <= 113 &&
                                                  offsetY.toInt() >= 385 &&
                                                  offsetY.toInt() <= 397) ||
                                              (offsetX.toInt() >= 144 &&
                                                  offsetX.toInt() <= 156 &&
                                                  offsetY.toInt() >= 385 &&
                                                  offsetY.toInt() <= 397)) {
                                            print("BodyPart:" + "feet");
                                            bodyPartName = "Feet";
                                          } else if ((offsetX.toInt() >= 100 &&
                                                  offsetX.toInt() <= 160 &&
                                                  offsetY.toInt() >= 280 &&
                                                  offsetY.toInt() <= 295) ||
                                              (offsetX.toInt() >= 132 &&
                                                  offsetX.toInt() <= 157 &&
                                                  offsetY.toInt() >= 280 &&
                                                  offsetY.toInt() <= 295)) {
                                            print("BodyPart:" + "Knee");
                                            bodyPartName = "Knee";
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
                                            print("BodyPart:" + "chest");
                                            bodyPartName = "Chest";
                                          } else if ((offsetX.toInt() >= 20 &&
                                                  offsetX.toInt() <= 96 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168) ||
                                              (offsetX.toInt() >= 182 &&
                                                  offsetX.toInt() <= 225 &&
                                                  offsetY.toInt() >= 96 &&
                                                  offsetY.toInt() <= 168)) {
                                            print("BodyPart:" + "Arm");
                                            bodyPartName = "Arms";
                                          } else if ((offsetX.toInt() >= 70 &&
                                                  offsetX.toInt() <= 96 &&
                                                  offsetY.toInt() >= 60 &&
                                                  offsetY.toInt() <= 102) ||
                                              (offsetX.toInt() >= 163 &&
                                                  offsetX.toInt() <= 185 &&
                                                  offsetY.toInt() >= 60 &&
                                                  offsetY.toInt() <= 102)) {
                                            print("BodyPart:" + "Shoulder");
                                            bodyPartName = "Shoulders";
                                          } else if ((offsetX.toInt() >= 90 &&
                                                  offsetX.toInt() <= 125 &&
                                                  offsetY.toInt() >= 215 &&
                                                  offsetY.toInt() <= 275) ||
                                              (offsetX.toInt() >= 128 &&
                                                  offsetX.toInt() <= 165 &&
                                                  offsetY.toInt() >= 215 &&
                                                  offsetY.toInt() <= 275)) {
                                            print("BodyPart:" + "Thighs");
                                            bodyPartName = "Thigh";
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
                                          }
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
                                        showDrag
                                            ? Positioned(
                                                left: xx0,
                                                top: yy0,
                                                child: InkWell(
                                                  onTap: () {
                                                    showDrag = false;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BodyDetailScreen(
                                                                    bodyPartName:
                                                                        bodyPartName,
                                                                    isBack: Constants
                                                                        .isBackBody,
                                                                    x: xx0,
                                                                    y: yy0))).then(
                                                        (value) =>
                                                            getPainApi());
                                                  },
                                                  child: Draggable(
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
                                                          color: colorrr),
                                                      child: Center(
                                                          child: Text("?")),
                                                    ),
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        xx0 = dragDetails
                                                                .offset.dx -
                                                            52;
                                                        yy0 = dragDetails
                                                                .offset.dy -
                                                            245;

                                                        print(xx0.toString() +
                                                            "," +
                                                            yy0.toString());
                                                        if ((xx0.toInt() >=
                                                                    53 &&
                                                                xx0.toInt() <=
                                                                    68 &&
                                                                yy0.toInt() >=
                                                                    130 &&
                                                                yy0.toInt() <=
                                                                    145) ||
                                                            (xx0.toInt() >=
                                                                    179 &&
                                                                xx0.toInt() <=
                                                                    193 &&
                                                                yy0.toInt() >=
                                                                    130 &&
                                                                yy0.toInt() <=
                                                                    145)) {
                                                          print("BodyPart:" +
                                                              "elbow");
                                                          bodyPartName =
                                                              "Elbow";
                                                        } else if ((xx0.toInt() >=
                                                                    111 &&
                                                                xx0.toInt() <=
                                                                    116 &&
                                                                yy0.toInt() >=
                                                                    373 &&
                                                                yy0.toInt() <=
                                                                    384) ||
                                                            xx0.toInt() >=
                                                                    143 &&
                                                                xx0.toInt() <=
                                                                    148 &&
                                                                yy0.toInt() >=
                                                                    373 &&
                                                                yy0.toInt() <=
                                                                    384) {
                                                          print("BodyPart:" +
                                                              "ankle");
                                                          bodyPartName =
                                                              "Ankle";
                                                        } else if ((xx0.toInt() >=
                                                                    120 &&
                                                                xx0.toInt() <=
                                                                    127 &&
                                                                yy0.toInt() >=
                                                                    380 &&
                                                                yy0.toInt() <=
                                                                    395) ||
                                                            (xx0.toInt() >=
                                                                    133 &&
                                                                xx0.toInt() <=
                                                                    140 &&
                                                                yy0.toInt() >=
                                                                    380 &&
                                                                yy0.toInt() <=
                                                                    395)) {
                                                          print("BodyPart:" +
                                                              "heel");
                                                          bodyPartName = "Heel";
                                                        } else if ((xx0.toInt() >=
                                                                    90 &&
                                                                xx0.toInt() <=
                                                                    113 &&
                                                                yy0.toInt() >=
                                                                    385 &&
                                                                yy0.toInt() <=
                                                                    397) ||
                                                            (xx0.toInt() >=
                                                                    144 &&
                                                                xx0.toInt() <=
                                                                    156 &&
                                                                yy0.toInt() >=
                                                                    385 &&
                                                                yy0.toInt() <=
                                                                    397)) {
                                                          print("BodyPart:" +
                                                              "feet");
                                                          bodyPartName = "Feet";
                                                        } else if ((xx0.toInt() >=
                                                                    100 &&
                                                                xx0.toInt() <=
                                                                    160 &&
                                                                yy0.toInt() >=
                                                                    280 &&
                                                                yy0.toInt() <=
                                                                    295) ||
                                                            (xx0.toInt() >=
                                                                    132 &&
                                                                xx0.toInt() <=
                                                                    157 &&
                                                                yy0.toInt() >=
                                                                    280 &&
                                                                yy0.toInt() <=
                                                                    295)) {
                                                          print("BodyPart:" +
                                                              "Knee");
                                                          bodyPartName = "Knee";
                                                        } else if ((xx0.toInt() >=
                                                                    102 &&
                                                                xx0.toInt() <=
                                                                    123 &&
                                                                yy0.toInt() >=
                                                                    290 &&
                                                                yy0.toInt() <=
                                                                    370) ||
                                                            (xx0.toInt() >=
                                                                    130 &&
                                                                xx0.toInt() <=
                                                                    158 &&
                                                                yy0.toInt() >=
                                                                    290 &&
                                                                yy0.toInt() <=
                                                                    370)) {
                                                          print("BodyPart:" +
                                                              "leg");
                                                          bodyPartName = "Leg";
                                                        } else if (xx0.toInt() >=
                                                                97 &&
                                                            xx0.toInt() <=
                                                                160 &&
                                                            yy0.toInt() >= 80 &&
                                                            yy0.toInt() <=
                                                                112) {
                                                          print("BodyPart:" +
                                                              "chest");
                                                          bodyPartName =
                                                              "Chest";
                                                        } else if ((xx0.toInt() >=
                                                                    20 &&
                                                                xx0.toInt() <=
                                                                    96 &&
                                                                yy0.toInt() >=
                                                                    96 &&
                                                                yy0.toInt() <=
                                                                    168) ||
                                                            (xx0.toInt() >=
                                                                    190 &&
                                                                xx0.toInt() <=
                                                                    225 &&
                                                                yy0.toInt() >=
                                                                    96 &&
                                                                yy0.toInt() <=
                                                                    168)) {
                                                          print("BodyPart:" +
                                                              "Arm");
                                                          bodyPartName = "Arms";
                                                        } else if ((xx0.toInt() >=
                                                                    70 &&
                                                                xx0.toInt() <=
                                                                    96 &&
                                                                yy0.toInt() >=
                                                                    60 &&
                                                                yy0.toInt() <=
                                                                    102) ||
                                                            (xx0.toInt() >=
                                                                    163 &&
                                                                xx0.toInt() <=
                                                                    185 &&
                                                                yy0.toInt() >=
                                                                    60 &&
                                                                yy0.toInt() <=
                                                                    102)) {
                                                          print("BodyPart:" +
                                                              "Shoulder");
                                                          bodyPartName =
                                                              "Shoulders";
                                                        } else if ((xx0.toInt() >=
                                                                    90 &&
                                                                xx0.toInt() <=
                                                                    125 &&
                                                                yy0.toInt() >=
                                                                    215 &&
                                                                yy0.toInt() <=
                                                                    275) ||
                                                            (xx0.toInt() >=
                                                                    128 &&
                                                                xx0.toInt() <=
                                                                    165 &&
                                                                yy0.toInt() >=
                                                                    215 &&
                                                                yy0.toInt() <=
                                                                    275)) {
                                                          print("BodyPart:" +
                                                              "Thighs");
                                                          bodyPartName =
                                                              "Thigh";
                                                        } else {
                                                          bodyPartName="None";
                                                        }
                                                        var dialog =
                                                            CustomAlertDialog(
                                                                title: "Alert",
                                                                message:
                                                                    "Are you sure, do you want save pain here?",
                                                                positiveBtnText:
                                                                    'Yes',
                                                                negativeBtnText:
                                                                    'No',
                                                                onPostivePressed:
                                                                    () {
                                                                  showDrag =
                                                                      false;
                                                                  savePain();
                                                                },
                                                                onNegativePressed:
                                                                    () {});
                                                        if(bodyPartName=="None"){
                                                          x0 = 128.0;
                                                          y0 = 136.0;
                                                          CommonUtils.showRedToastMessage('Please select valid body part');
                                                        }
                                                        else{
                                                          showdialog
                                                              ? showDialog(
                                                              context:
                                                              context,
                                                              builder:
                                                                  (BuildContext
                                                              context) =>
                                                              dialog)
                                                              : Container();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 1
                                            ? Positioned(
                                                left: xx1,
                                                top: yy1,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx1 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy1 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 1
                                            ? Positioned(
                                                left: xx1,
                                                top: yy1,
                                                child: InkWell(
                                                    onTap: () {
                                                    gotoNextPage(
                                                        index: 0,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 2
                                            ? Positioned(
                                                left: xx2,
                                                top: yy2,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx2 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy2 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 2
                                            ? Positioned(
                                                left: xx2,
                                                top: yy2,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 1,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 3
                                            ? Positioned(
                                                left: xx3,
                                                top: yy3,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx3 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy3 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 3
                                            ? Positioned(
                                                left: xx3,
                                                top: yy3,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 2,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 4
                                            ? Positioned(
                                                left: xx4,
                                                top: yy4,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx4 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy4 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 4
                                            ? InkWell(
                                          onTap: () {
                                            gotoNextPage(
                                                index: 3,
                                                list: backPainData);
                                          },
                                              child: Positioned(
                                                  left: xx4,
                                                  top: yy4,
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  )),
                                            )
                                            : Container(),
                                        backLength >= 5
                                            ? Positioned(
                                                left: xx5,
                                                top: yy5,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx5 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy5 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 5
                                            ? Positioned(
                                                left: xx5,
                                                top: yy5,
                                                child: InkWell(
                                                    onTap: () {
                                                    gotoNextPage(
                                                        index: 4,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 6
                                            ? Positioned(
                                                left: xx6,
                                                top: yy6,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx6 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy6 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 6
                                            ? Positioned(
                                                left: xx6,
                                                top: yy6,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 5,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 7
                                            ? Positioned(
                                                left: xx7,
                                                top: yy7,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx7 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy7 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 7
                                            ? Positioned(
                                                left: xx7,
                                                top: yy7,
                                                child: InkWell(
                                                    onTap: () {
                                                    gotoNextPage(
                                                        index: 6,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 8
                                            ? Positioned(
                                                left: xx8,
                                                top: yy8,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx8 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy8 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 8
                                            ? Positioned(
                                                left: xx8,
                                                top: yy8,
                                                child: InkWell(
                                                  onTap: () {
                                                    gotoNextPage(
                                                        index: 7,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 9
                                            ? Positioned(
                                                left: xx9,
                                                top: yy9,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx9 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy9 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 9
                                            ? Positioned(
                                                left: xx9,
                                                top: yy9,
                                                child: InkWell(
                                                    onTap: () {
                                                    gotoNextPage(
                                                        index: 8,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container(),
                                        backLength >= 10
                                            ? Positioned(
                                                left: xx10,
                                                top: yy10,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Draggable(
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
                                                    feedback: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.indigo),
                                                    ),
                                                    childWhenDragging:
                                                        Container(),
                                                    onDragEnd: (dragDetails) {
                                                      setState(() {
                                                        double width =
                                                            D.W - D.W / 1.6;
                                                        double height =
                                                            D.H - D.H / 1.9;
                                                        print(width.toString() +
                                                            "," +
                                                            height.toString());
                                                        xx10 = dragDetails
                                                                .offset.dx -
                                                            width / 2.6;
                                                        yy10 = dragDetails
                                                                .offset.dy -
                                                            height / 1.56;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        backLength >= 10
                                            ? Positioned(
                                                left: xx10,
                                                top: yy10,
                                                child: InkWell(
                                                    onTap: () {
                                                    gotoNextPage(
                                                        index: 9,
                                                        list: backPainData);
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ))
                                            : Container()
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.primaryBlueColor,
        onPressed: () {
          // showDrag=false;
          if (showDrag) {
            CommonUtils.showRedToastMessage("Please save the pain first");
          } else if (painData.length > 10) {
            CommonUtils.showRedToastMessage(
                "you can not add pain more than 10");
          } else {
            showDrag = false;
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
        child: Icon(Icons.add),
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
    var tempFirstSortedYearList=[];
     tempFirstSortedYearList.clear();
    if (statusCode == 200) {

      for (int i = 0; i < res.length; i++) {
        var mydtStart = DateTime.fromMillisecondsSinceEpoch(res[i]["created"].toInt());
        var myd24Start = DateFormat('yyyy').format(mydtStart);
       if(myd24Start.toString()==_chosenValueOfYear){
         tempFirstSortedYearList.add((res[i]));
       }
      }

      for (int i = 0; i < tempFirstSortedYearList.length; i++) {
        painData.add(PainDashboardModel(
            bodyPart: res[i]["bodyPart"],
            bodyPartId: res[i]["bodyPartId"],
            created: res[i]["created"],
            current: res[i]["current"],
            description: res[i]["description"],
            endDate: res[i]["endDate"],
            locationX: res[i]["locationX"],
            locationY: res[i]["locationY"],
            isBack: res[i]["isBack"],
            startDate: res[i]["startDate"],
            usersPainId: res[i]["usersPainId"]));
      }
      print("total length:" + painData.length.toString());

      for (int i = 0; i < painData.length; i++) {
        if (painData[i].isBack == true) {
          backPainData.add(painData[i]);
        } else {
          frontPainData.add(painData[i]);
        }
      }

      for (int i = 0; i < frontPainData.length; i++) {
        if (frontPainData[i].locationX == 0.0 &&
            frontPainData[i].locationY == 0.0) {
          index = i;
          showDrag = true;
          showdialog = true;
          usersPainId = frontPainData[index].usersPainId!;
          bodyPartId = frontPainData[index].bodyPartId.toString();
          description = frontPainData[index].description.toString();
          startDate = frontPainData[index].startDate.toString();
          endDate = frontPainData[index].endDate.toString();
          current = frontPainData[index].current!;
          frontPainData.removeAt(index);
        }
      }

      for (int i = 0; i < backPainData.length; i++) {
        if (backPainData[i].locationX == 0.0 &&
            backPainData[i].locationY == 0.0) {
          index = i;
          showDrag = true;
          showdialog = true;
          usersPainId = backPainData[index].usersPainId!;
          bodyPartId = backPainData[index].bodyPartId.toString();
          description = backPainData[index].description.toString();
          startDate = backPainData[index].startDate.toString();
          endDate = backPainData[index].endDate.toString();
          current = backPainData[index].current!;
          backPainData.removeAt(index);
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
        colorrr = Colors.red;
      } else if (frontPainData.length == 2) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        colorrr = Colors.yellow;
      } else if (frontPainData.length == 3) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        colorrr = Colors.orange;
      } else if (frontPainData.length == 4) {
        x1 = frontPainData[0].locationX!.toDouble();
        y1 = frontPainData[0].locationY!.toDouble();
        x2 = frontPainData[1].locationX!.toDouble();
        y2 = frontPainData[1].locationY!.toDouble();
        x3 = frontPainData[2].locationX!.toDouble();
        y3 = frontPainData[2].locationY!.toDouble();
        x4 = frontPainData[3].locationX!.toDouble();
        y4 = frontPainData[3].locationY!.toDouble();
        colorrr = Colors.green;
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
        colorrr = Colors.grey;
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
        colorrr = Colors.black;
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
        colorrr = Colors.tealAccent;
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
        colorrr = Colors.deepPurpleAccent;
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
        colorrr = Colors.indigo;
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
        colorrr = Colors.blue;
      }

      if (backPainData.length == 1) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        colorrr = Colors.red;
      } else if (backPainData.length == 2) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        colorrr = Colors.yellow;
      } else if (backPainData.length == 3) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        colorrr = Colors.orange;
      } else if (backPainData.length == 4) {
        xx1 = backPainData[0].locationX!.toDouble();
        yy1 = backPainData[0].locationY!.toDouble();
        xx2 = backPainData[1].locationX!.toDouble();
        yy2 = backPainData[1].locationY!.toDouble();
        xx3 = backPainData[2].locationX!.toDouble();
        yy3 = backPainData[2].locationY!.toDouble();
        xx4 = backPainData[3].locationX!.toDouble();
        yy4 = backPainData[3].locationY!.toDouble();
        colorrr = Colors.green;
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
        colorrr = Colors.grey;
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
        colorrr = Colors.black;
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
        colorrr = Colors.tealAccent;
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
        colorrr = Colors.deepPurpleAccent;
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
        colorrr = Colors.indigo;
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
        colorrr = Colors.blue;
      }

      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
    setState(() {});
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
      CommonUtils.showGreenToastMessage("save Pain Successfully");
      Navigator.pop(context);
      getPainApi();
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  gotoNextPage({required int index, required List<PainDashboardModel> list}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BodyDetailScreen(
                  bodyPartName: list[index].bodyPart.toString(),
                  isBack: list[index].isBack!,
                  x: list[index].locationX,
                  y: list[index].locationY,
                  description: list[index].description.toString(),
                  startdate: list[index].startDate,
                  enddate: list[index].endDate,
                  userPainId: list[index].usersPainId,
                  iscurrent: list[index].current,
                  isUpdate: true,
                )));
  }
}
