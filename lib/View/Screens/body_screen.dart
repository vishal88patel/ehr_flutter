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

import '../../Constants/api_endpoint.dart';
import '../../Constants/color_constants.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/preferences.dart';
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
  Color color = Colors.blue;
  List<PainDashboardModel> painData = [];
  int length = 0;
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
                                        "assets/images/backtestbody.png",
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
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BodyDetailScreen(
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
                                                          color: color),
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
                                                        double width = D.W;
                                                        double height = D.H;
                                                        x0 = dragDetails
                                                                .offset.dx -
                                                            52;
                                                        y0 = dragDetails
                                                                .offset.dy -
                                                            245;
                                                        print(x0.toString() + "," + y0.toString());
                                                        if (x0.toInt() >= 53 && x0.toInt() <= 68 && y0.toInt() >= 130 && y0.toInt() <= 145) {
                                                          print("BodyPart:" + "elbow");
                                                        } else if (x0.toInt() >= 143 && x0.toInt() <= 148 && y0.toInt() >= 373 && y0.toInt() <= 384) {
                                                          print("BodyPart:" + "ankle");
                                                        } else if (x0.toInt() >= 120 && x0.toInt() <= 127 && y0.toInt() >= 380 && y0.toInt() <= 395) {
                                                          print("BodyPart:" + "heel");
                                                        } else if (x0.toInt() >= 90 && x0.toInt() <= 113 && y0.toInt() >= 385 && y0.toInt() <= 397) {
                                                          print("BodyPart:" + "feet");
                                                        } else if (x0.toInt() >= 100 && x0.toInt() <= 160 && y0.toInt() >= 280 && y0.toInt() <= 295) {
                                                          print("BodyPart:" + "Knee");
                                                        } else if (x0.toInt() >= 102 && x0.toInt() <= 123 && y0.toInt() >= 290 && y0.toInt() <= 370) {
                                                          print("BodyPart:" + "leg");
                                                        } else if (x0.toInt() >= 97 && x0.toInt() <= 160 && y0.toInt() >= 80 && y0.toInt() <= 112) {
                                                          print("BodyPart:" + "chest");
                                                        } else if (x0.toInt() >= 20 && x0.toInt() <= 96 && y0.toInt() >= 96 && y0.toInt() <= 168) {
                                                          print("BodyPart:" + "Arm");
                                                        } else if (x0.toInt() >= 70 && x0.toInt() <= 96 && y0.toInt() >= 60 && y0.toInt() <= 102) {
                                                          print("BodyPart:" + "Shoulder");
                                                        } else if (x0.toInt() >= 90 && x0.toInt() <= 125 && y0.toInt() >= 215 && y0.toInt() <= 275) {
                                                          print("BodyPart:" + "Thighs");
                                                        } else {
                                                          print("BodyPart:" + "None");
                                                        }
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
          setState(() {
            showDrag = true;
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  getBodyPartName() {}

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
      length = painData.length;
      print("length:" + length.toString());
      if (length == 1) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        color = Colors.red;
      } else if (length == 2) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        color = Colors.yellow;
      } else if (length == 3) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        color = Colors.orange;
      } else if (length == 4) {
        x1 = painData[0].locationX!.toDouble();
        y1 = painData[0].locationY!.toDouble();
        x2 = painData[1].locationX!.toDouble();
        y2 = painData[1].locationY!.toDouble();
        x3 = painData[2].locationX!.toDouble();
        y3 = painData[2].locationY!.toDouble();
        x4 = painData[3].locationX!.toDouble();
        y4 = painData[3].locationY!.toDouble();
        color = Colors.green;
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
        color = Colors.blue;
      } else {
        color = Colors.blue;
      }
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
