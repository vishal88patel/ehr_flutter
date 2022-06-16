import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/add_medication_screen.dart';
import 'package:ehr/View/Screens/medication_detail_screen.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_date_field.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        title: Center(
          child: Text(
            "Medication",
            style: GoogleFonts.heebo(
                fontSize: D.H / 44, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              NavigationHelpers.redirect(
                  context, AddMedicationScreen());
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
      body: Padding(
        padding: EdgeInsets.only(
            left: D.W / 22, right: D.W / 22, top: D.H / 30),
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
          child: GestureDetector(
            onTap: (){
              NavigationHelpers.redirect(
                  context, MedicationDetailScreen());
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
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
                  );
                }),
          ),
        ),
      ),
    );
  }
}
