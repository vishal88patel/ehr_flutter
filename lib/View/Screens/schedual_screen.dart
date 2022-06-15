import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import 'otp_screen.dart';

class SchedualScreen extends StatefulWidget {
  const SchedualScreen({Key? key}) : super(key: key);

  @override
  State<SchedualScreen> createState() => _SchedualScreenState();
}

class _SchedualScreenState extends State<SchedualScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        title: Center(
            child: Text(
              "Calender",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            )),
      ),
      backgroundColor: ColorConstants.background,
      body:Container(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane:  ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    Padding(
                      padding:EdgeInsets.only(left: 0,right: 0),
                      child: Container(
                        width: 33,
                        child: Center(
                          child: SlidableAction(
                            padding: EdgeInsets.all(0),
                            onPressed: (BuildContext context) { _showSnackBar(context,"edit"); },
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.only(right: D.W/18,left: 0),
                      child: Container(
                        width: 33,
                        child: Center(
                          child: SlidableAction(
                            padding: EdgeInsets.all(0),
                            onPressed: (BuildContext context) { _showSnackBar(context,"Delete"); },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: D.W/20,right: D.W/20,top: D.W/40),
                  child: Card(
                    color: ColorConstants.blueBtn,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: D.W / 30.0, top: D.H / 80),
                              child: Row(
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
                                            padding: EdgeInsets.all(D.W / 42),
                                            child: SvgPicture.asset(
                                                "assets/images/ic_bowl.svg"),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(left:D.H /180),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Chest",
                                              style: GoogleFonts.heebo(
                                                  fontSize: D.H / 52,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "Hil 250 mg 2/Day",
                                              style: GoogleFonts.heebo(
                                                  color: ColorConstants.blueBtn,
                                                  fontSize: D.H / 66,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/ic_doctor.svg"),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 2.0,top:2.0),
                                                  child: Text(
                                                    "Jhon Miler",
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
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right:D.W/24.0,top:D.W /60),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: D.W/24,
                                              width: D.W/24,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                                  color: ColorConstants.lightRed
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: D.H / 160),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Lorem Dummy",
                                              style: GoogleFonts.heebo(
                                                  fontSize: D.H / 66,
                                                  color: ColorConstants.lightText2,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              "27-12-2022",
                                              style: GoogleFonts.heebo(
                                                  color: ColorConstants.lightText2,
                                                  fontSize: D.H / 66,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: D.H / 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0,right: 4.0),
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
                ),
              );
            }),
      )
    );
  }
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
