import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/add_shedule_screen.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../CustomWidgets/custom_calender.dart';
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
          backgroundColor: ColorConstants.primaryBlueColor,
          elevation: 0,
          toolbarHeight: 45,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text(
                "Calender",
                style: GoogleFonts.heebo(
                    fontSize: D.H / 44, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: (){
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

      backgroundColor: ColorConstants.background,
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:D.W/28,right:D.W/28),
          child: Column(
            children: [
              CustomCalender(),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        NavigationHelpers.redirect(context, AddSheduleScreen());
                      },
                      child: Slidable(
                        key: const ValueKey(0),
                        endActionPane:  ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.all(0),
                              onPressed: (BuildContext context) { _showSnackBar(context,"edit"); },
                              backgroundColor: ColorConstants.primaryBlueColor,
                              foregroundColor: Colors.white,
                              icon: Icons.edit_outlined,
                            ),
                            SlidableAction(
                              padding: EdgeInsets.all(0),
                              onPressed: (BuildContext context) { _showSnackBar(context,"Delete"); },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: D.W/40),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: D.W / 30.0, top: D.H / 80),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/images/ic_time.svg"),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: Text(
                                                          "09:50 AM",
                                                          style: GoogleFonts.heebo(
                                                              color: ColorConstants.skyBlue,
                                                              fontSize: D.H / 54,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: Text(
                                                          "29-12-2021",
                                                          style: GoogleFonts.heebo(
                                                              color: ColorConstants.skyBlue,
                                                              fontSize: D.H / 54,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: D.W/5.5,),
                                                  Text(
                                                    "Sunday",
                                                    style: GoogleFonts.heebo(
                                                        fontSize: D.H / 52,
                                                        color: ColorConstants.blueBtn,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: D.W / 22.0, top: D.H / 140,bottom: D.H/100),
                                      child: Text(
                                        "I have a appointment for dental",
                                        style: GoogleFonts.heebo(
                                            fontSize: D.H / 44,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(height: D.H/40,)
            ],
          ),
        ),
      )
    );
  }
  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
