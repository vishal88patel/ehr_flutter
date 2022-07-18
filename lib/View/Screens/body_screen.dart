import 'package:ehr/Constants/constants.dart';
import 'package:ehr/Utils/navigation_helper.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/color_constants.dart';
import '../../Utils/dimensions.dart';
import 'body_detail_screen.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  _BodyScreenState createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  FlipCardController _flipCardController = FlipCardController();
  bool isFlipped = false;
  double _x=98.0;
  double _y=123.0;

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "2020",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2019",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2018",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2017",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2016",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2015",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2014",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2013",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2012",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2011",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2010",
                          style: GoogleFonts.heebo(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 270,
                        ),
                        SizedBox(
                            width: 90,
                            height: 320,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: Constants.BodyPartsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.greenAccent),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          Constants.BodyPartsList[index].bodyPart.toString(),
                                          style: GoogleFonts.heebo(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                );
                              },
                            )),

                      ],
                    ),
                  ],
                ),
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
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            height: D.H/1.9,
                            width: D.W/1.6,
                            child: GestureDetector(
                              child: FlipCard(
                                flipOnTouch: false,
                                fill: Fill.fillBack,
                                controller: _flipCardController,
                                direction: FlipDirection.HORIZONTAL,
                                front: Container(
                                  height: D.H/1.9,
                                  width: D.W/1.6,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        "assets/images/human_body_front.png",
                                      ),
                                      Positioned(
                                        left: _x,
                                        top: _y,
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BodyDetailScreen()),
                                            );
                                          },
                                          child: Draggable(
                                            child:  Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blue),
                                            ),
                                            feedback:  Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blue),
                                            ),
                                            childWhenDragging: Container(),
                                            onDragEnd: (dragDetails) {
                                              setState(() {
                                                double width= D.W-D.W/1.6;
                                                double height= D.H-D.H/1.9;
                                                print(width.toString()+","+height.toString());
                                                _x = dragDetails.offset.dx-width/2;
                                                _y = dragDetails.offset.dy-height/1.56;
                                                print(_x.toString()+" , "+_y.toString());
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                back: Container(
                                  height: D.H/1.9,
                                  width: D.W/1.6,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        "assets/images/human_body_back.png",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


                // Column(
                //   children: [
                //     SizedBox(
                //       height: 300,
                //     ),
                //     Row(
                //       children: [
                //         Container(
                //           height: 12,
                //           width: 12,
                //           decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: Colors.greenAccent),
                //         ),
                //         SizedBox(
                //           width: 6,
                //         ),
                //         Text(
                //           "Arms",
                //           style: GoogleFonts.heebo(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Chest",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Shoulders",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Ankle",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Leg",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Foot",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Knee",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Elbow",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Heel",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //     Text(
                //       "Thigh",
                //       style: GoogleFonts.heebo(
                //           fontWeight: FontWeight.bold, color: Colors.grey),
                //     ),
                //     SizedBox(
                //       height: 8,
                //     ),
                //   ],
                // )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.primaryBlueColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BodyDetailScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
