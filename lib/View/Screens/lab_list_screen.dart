import 'package:ehr/Constants/color_constants.dart';
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

class LabListScreen extends StatefulWidget {
  const LabListScreen({Key? key}) : super(key: key);

  @override
  State<LabListScreen> createState() => _LabListScreenState();
}

class _LabListScreenState extends State<LabListScreen> {
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
            "Labs",
            style: GoogleFonts.heebo(
                fontSize: D.H / 44, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          SvgPicture.asset(
            "assets/images/ic_plus.svg",
          ),
          Container(
            width: D.W / 36,
          )
        ],
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
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
                child: ListView.builder(
                    itemCount: 20,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: D.W / 30.0,right: D.W / 30.0, top: D.H / 80),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mitral valve prolapse",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 52,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "98",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 52,
                                          color: ColorConstants.blueText,
                                          fontWeight: FontWeight.w400),
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
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
