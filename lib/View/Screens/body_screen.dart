import 'package:ehr/Utils/navigation_helper.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/color_constants.dart';
import 'body_detail_screen.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  _BodyScreenState createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  FlipCardController _flipCardController=FlipCardController();
  bool isFlipped =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Home",
          style: GoogleFonts.heebo(fontWeight: FontWeight.normal),
        ),
        actions: [
          InkWell(
            onTap: (){
              NavigationHelpers.redirectFromSplash(context, ProfileScreen());
            },
            child: SvgPicture.asset(
              "assets/images/avatar.svg",
            ),
          ),
          Container(
            width: 5,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                  onTap: (){
                    if(isFlipped){
                      isFlipped=false;
                      _flipCardController.toggleCard();
                      setState(() {

                      });
                    }else{
                      isFlipped=true;
                      _flipCardController.toggleCard();
                      setState(() {

                      });
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
                            isFlipped?"Frontside":"Backside",
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.primaryBlueColor),
                      ))),
                ),
              ],
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 30,),
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
                  Stack(
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
                             height: 410,width: 230,
                             child: GestureDetector(
                               child: FlipCard(
                                 flipOnTouch: false,
                                fill: Fill.fillBack,
                                controller: _flipCardController,
                                // Fill the back side of the card to make in the same size as the front.

                                direction: FlipDirection.HORIZONTAL,
                                // default
                                front: Container(
                                  height: 410,
                                  width: 230,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        "assets/images/human_body_front.png",

                                      ),
                                      Positioned(
                                        top: 57,left: 75,
                                        child: InkWell(
                                          onTap: (){
      
                                            NavigationHelpers.redirect(context, BodyDetailScreen(appBarName: "Chest"));
                                          },
                                          child: Container(
                                            height: 12,
                                            width: 12,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 80,left: 120,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.greenAccent),
                                        ),
                                      ),
                                      Positioned(
                                        top: 130,left: 102,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                        ),
                                      ),
                                      Positioned(
                                        top: 245,left: 113,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF6FC7BA)),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                back: Container(
                                  child: Image.asset(
                                    "assets/images/human_body_back.png",
                                  ),
                                ),
                          ),
                             ),
                           ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
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
                            "Arms",
                            style: GoogleFonts.heebo(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Chest",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Shoulders",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Ankle",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Leg",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Foot",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Knee",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Elbow",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Heel",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Thigh",
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.primaryBlueColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
