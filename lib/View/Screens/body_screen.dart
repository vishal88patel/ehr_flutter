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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

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
  bool isFlipped = false;
  bool showDrag = false;
  bool showdialog = false;
  Color colorrr = Colors.blue;
  List<PainDashboardModel> painData = [];
  int length = 0;
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

  var bodyPartName="";


  var usersPainId ="";
  var bodyPartId="";
  var description ="";
  var startDate ="";
  var endDate ="";
  bool current =false;

  @override
  void initState() {
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
                    if (isFlipped) {
                      isFlipped = false;
                      _flipCardController.toggleCard();
                      setState(() {});
                    } else {
                      isFlipped = true;
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
                        isFlipped ? "Frontside" : "Backside",
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.primaryBlueColor),
                      ))),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if(length>=10){
                        CommonUtils.showRedToastMessage("You did not set circle more then 5");
                      }else{
                        showDrag = true;
                        x0 = 128.0;
                        y0 = 136.0;
                        showdialog=false;
                      }
                    });
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.primaryBlueColor,
                            //                   <--- border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: Text(
                            " + ",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.primaryBlueColor),
                          ))),
                ),
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
                          ),
                          Container(
                            height: D.H / 1.9,
                            width: D.W / 1.4,
                            child: GestureDetector(
                              child: FlipCard(
                                flipOnTouch: false,
                                fill: Fill.fillBack,
                                controller: _flipCardController,
                                direction: FlipDirection.HORIZONTAL,
                                front: Stack(
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        "assets/images/front_part.png",
                                        height: 400,
                                        width: 240,
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
                                                    showDrag=false;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BodyDetailScreen(
                                                                    bodyPartName: bodyPartName,
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
                                                                .offset.dx -
                                                            52;
                                                        y0 = dragDetails
                                                                .offset.dy -
                                                            245;

                                                        print(x0.toString() + "," + y0.toString());
                                                        if ((x0.toInt() >= 53 && x0.toInt() <= 68 && y0.toInt() >= 130 && y0.toInt() <= 145)||(x0.toInt() >= 179 && x0.toInt() <= 193 && y0.toInt() >= 130 && y0.toInt() <= 145)) {
                                                          print("BodyPart:" + "elbow");
                                                          bodyPartName="Elbow";

                                                        } else if ((x0.toInt() >= 111 && x0.toInt() <= 116 && y0.toInt() >= 373 && y0.toInt() <= 384)||x0.toInt() >= 143 && x0.toInt() <= 148 && y0.toInt() >= 373 && y0.toInt() <= 384) {
                                                          print("BodyPart:" + "ankle");
                                                          bodyPartName="Ankle";

                                                        } else if ((x0.toInt() >= 120 && x0.toInt() <= 127 && y0.toInt() >= 380 && y0.toInt() <= 395)||(x0.toInt() >= 133 && x0.toInt() <= 140 && y0.toInt() >= 380 && y0.toInt() <= 395)) {
                                                          print("BodyPart:" + "heel");
                                                          bodyPartName="Heel";

                                                        } else if ((x0.toInt() >= 90 && x0.toInt() <= 113 && y0.toInt() >= 385 && y0.toInt() <= 397)||(x0.toInt() >= 144 && x0.toInt() <= 156 && y0.toInt() >= 385 && y0.toInt() <= 397)) {
                                                          print("BodyPart:" + "feet");
                                                          bodyPartName="Feet";


                                                        } else if ((x0.toInt() >= 100 && x0.toInt() <= 160 && y0.toInt() >= 280 && y0.toInt() <= 295)||(x0.toInt() >= 132 && x0.toInt() <= 157 && y0.toInt() >= 280 && y0.toInt() <= 295)) {
                                                          print("BodyPart:" + "Knee");
                                                          bodyPartName="Knee";

                                                        } else if ((x0.toInt() >= 102 && x0.toInt() <= 123 && y0.toInt() >= 290 && y0.toInt() <= 370)||(x0.toInt() >= 130 && x0.toInt() <= 158 && y0.toInt() >= 290 && y0.toInt() <= 370)) {
                                                          print("BodyPart:" + "leg");
                                                          bodyPartName="Leg";

                                                        } else if (x0.toInt() >= 97 && x0.toInt() <= 160 && y0.toInt() >= 80 && y0.toInt() <= 112) {
                                                          print("BodyPart:" + "chest");
                                                          bodyPartName="Chest";
                                                        } else if ((x0.toInt() >= 20 && x0.toInt() <= 96 && y0.toInt() >= 96 && y0.toInt() <= 168)||(x0.toInt() >= 190 && x0.toInt() <= 225 && y0.toInt() >= 96 && y0.toInt() <= 168)) {
                                                          print("BodyPart:" + "Arm");
                                                          bodyPartName="Arms";

                                                        } else if ((x0.toInt() >= 70 && x0.toInt() <= 96 && y0.toInt() >= 60 && y0.toInt() <= 102)||(x0.toInt() >= 163 && x0.toInt() <= 185 && y0.toInt() >= 60 && y0.toInt() <= 102)) {
                                                          print("BodyPart:" + "Shoulder");
                                                          bodyPartName="Shoulders";

                                                        } else if ((x0.toInt() >= 90 && x0.toInt() <= 125 && y0.toInt() >= 215 && y0.toInt() <= 275)||(x0.toInt() >= 128 && x0.toInt() <= 165 && y0.toInt() >= 215 && y0.toInt() <= 275)) {
                                                          print("BodyPart:" + "Thighs");
                                                          bodyPartName="Thigh";
                                                        } else {
                                                          print("BodyPart:" + "None");
                                                        }
                                                        var dialog = CustomAlertDialog(
                                                            title: "Alert",
                                                            message: "Are you sure, do you want set button here?",
                                                            positiveBtnText: 'Yes',
                                                            negativeBtnText: 'No',
                                                            onPostivePressed: () {
                                                              savePain();
                                                            },
                                                            onNegativePressed: () {

                                                            }
                                                        );
                                                        showdialog?showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) => dialog):Container();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        length >= 1
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
                                        length >= 1
                                            ? Positioned(
                                                left: x1,
                                                top: y1,
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 20,
                                                  width: 20,
                                                ))
                                            : Container(),
                                        length >= 2
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
                                        length >= 2
                                            ? Positioned(
                                                left: x2,
                                                top: y2,
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 20,
                                                  width: 20,
                                                ))
                                            : Container(),
                                        length >= 3
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
                                        length >= 3
                                            ? Positioned(
                                                left: x3,
                                                top: y3,
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 20,
                                                  width: 20,
                                                ))
                                            : Container(),
                                        length >= 4
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
                                        length >= 4
                                            ? Positioned(
                                                left: x4,
                                                top: y4,
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 20,
                                                  width: 20,
                                                ))
                                            : Container(),
                                        length >= 5
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
                                        length >= 5
                                            ? Positioned(
                                                left: x5,
                                                top: y5,
                                                child: Container(
                                                  color: Colors.transparent,
                                                  height: 20,
                                                  width: 20,
                                                ))
                                            : Container(),
                                        length >= 6
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
                                        length >= 6
                                            ? Positioned(
                                            left: x6,
                                            top: y6,
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 20,
                                              width: 20,
                                            ))
                                            : Container(),
                                        length >= 7
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
                                        length >= 7
                                            ? Positioned(
                                            left: x7,
                                            top: y7,
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 20,
                                              width: 20,
                                            ))
                                            : Container(),
                                        length >= 8
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
                                                    color: Colors.tealAccent),
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
                                        length >= 8
                                            ? Positioned(
                                            left: x8,
                                            top: y8,
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 20,
                                              width: 20,
                                            ))
                                            : Container(),
                                        length >= 9
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
                                                    color: Colors.deepPurpleAccent),
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
                                        length >= 9
                                            ? Positioned(
                                            left: x9,
                                            top: y9,
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 20,
                                              width: 20,
                                            ))
                                            : Container(),
                                        length >= 10
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
                                        length >= 10
                                            ? Positioned(
                                            left: x10,
                                            top: y10,
                                            child: Container(
                                              color: Colors.transparent,
                                              height: 20,
                                              width: 20,
                                            ))
                                            : Container()
                                      ],
                                    ),
                                  ],
                                ),
                                back: Stack(
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        "assets/images/backtestbody.png",
                                        height: 400,
                                        width: 240,
                                      ),
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
          showDrag=false;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BodyDetailScreen(
                          bodyPartName: bodyPartName,
                          x: 0.0,
                          y: 0.0))).then(
                  (value) =>
                  getPainApi());
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
    if (statusCode == 200) {
      for (int i = 0; i < res.length; i++) {
        painData.add(PainDashboardModel(
            bodyPart: res[i]["bodyPart"],
            bodyPartId: res[i]["bodyPartId"],
            created: res[i]["created"],
            current: res[i]["current"],
            description: res[i]["description"],
            endDate: res[i]["endDate"],
            locationX: res[i]["locationX"],
            locationY: res[i]["locationY"],
            startDate: res[i]["startDate"],
            usersPainId: res[i]["usersPainId"]));
      }

      for(int i=0;i<painData.length;i++){
        if(painData[i].locationX==0.0 && painData[i].locationX==0.0){
          index=i;
          showDrag=true;
          showdialog=true;
          usersPainId =painData[index].usersPainId.toString();
          bodyPartId=painData[index].bodyPartId.toString();
          description =painData[index].description.toString();
          startDate =painData[index].startDate.toString();
          endDate =painData[index].endDate.toString();
          current =painData[index].current!;
          painData.removeAt(index);
        }
      }
      painData=painData.reversed.toList();
      length = painData.length;
      print("length:" + length.toString());
      if (length == 1) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        colorrr = Colors.red;
      } else if (length == 2) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        colorrr = Colors.yellow;
      } else if (length == 3) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        colorrr = Colors.orange;
      } else if (length == 4) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        colorrr = Colors.green;
      } else if (length == 5) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        x5 = painData[4].locationX!.toDouble();
        y5 = painData[4].locationY!.toDouble();
        colorrr=Colors.grey;
      } else if (length == 6) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        x5 = painData[4].locationX!.toDouble();
        y5 = painData[4].locationY!.toDouble();
        x6 = painData[5].locationX!.toDouble();
        y6 = painData[5].locationY!.toDouble();
        colorrr=Colors.black;
      } else if (length == 7) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        x5 = painData[4].locationX!.toDouble();
        y5 = painData[4].locationY!.toDouble();
        x6 = painData[5].locationX!.toDouble();
        y6 = painData[5].locationY!.toDouble();
        x7 = painData[6].locationX!.toDouble();
        y7 = painData[6].locationY!.toDouble();
        colorrr=Colors.tealAccent;
      } else if (length == 8) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        x5 = painData[4].locationX!.toDouble();
        y5 = painData[4].locationY!.toDouble();
        x6 = painData[5].locationX!.toDouble();
        y6 = painData[5].locationY!.toDouble();
        x7 = painData[6].locationX!.toDouble();
        y7 = painData[6].locationY!.toDouble();
        x8 = painData[7].locationX!.toDouble();
        y8 = painData[7].locationY!.toDouble();
        colorrr=Colors.deepPurpleAccent;
      } else if (length == 9) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        x5 = painData[4].locationX!.toDouble();
        y5 = painData[4].locationY!.toDouble();
        x6 = painData[5].locationX!.toDouble();
        y6 = painData[5].locationY!.toDouble();
        x7 = painData[6].locationX!.toDouble();
        y7 = painData[6].locationY!.toDouble();
        x8 = painData[7].locationX!.toDouble();
        y8 = painData[7].locationY!.toDouble();
        x9 = painData[8].locationX!.toDouble();
        y9 = painData[8].locationY!.toDouble();
        colorrr = Colors.indigo;

      } else if (length == 10) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        x5 = painData[4].locationX!.toDouble();
        y5 = painData[4].locationY!.toDouble();
        x6 = painData[5].locationX!.toDouble();
        y6 = painData[5].locationY!.toDouble();
        x7 = painData[6].locationX!.toDouble();
        y7 = painData[6].locationY!.toDouble();
        x8 = painData[7].locationX!.toDouble();
        y8 = painData[7].locationY!.toDouble();
        x9 = painData[8].locationX!.toDouble();
        y9 = painData[8].locationY!.toDouble();
        x10 = painData[9].locationX!.toDouble();
        y10 = painData[9].locationY!.toDouble();

      } else {
        colorrr = Colors.blue;
      }
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
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
    Map<String, dynamic> body = {
      "usersPainId": 0,
      "bodyPartId": bodyPartId,
      "locationX": x0,
      "locationY": y0,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "current":current,
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
}
