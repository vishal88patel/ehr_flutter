import 'dart:math';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_big_textform_field.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_textform_field.dart';
import 'otp_screen.dart';
import 'otp_verification_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final fNameController = TextEditingController();
  
  var _selectedGender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Text(
              "Help",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 22),
            Center(child: SvgPicture.asset("assets/images/bg_help.svg")),
            SizedBox(height: D.H / 24),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                  child: Card(
                    color: ColorConstants.blueBtn,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(48),
                          topRight: Radius.circular(48)),

                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height:40,

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                      margin: const EdgeInsets.symmetric(horizontal:0),
                      color: ColorConstants.lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            topRight: Radius.circular(48)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: D.W / 10, right: D.W / 10, top: D.H / 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Comments",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 52, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: D.H / 120),
                            CustomBigTextFormField(
                              maxlength: 200,
                              controller: fNameController,
                              readOnly: false,
                              validators: (e) {
                                if (fNameController.text == null ||
                                    fNameController.text == '') {
                                  return '*Please enter FirstName';
                                }
                              },
                              keyboardTYPE: TextInputType.text,
                              obscured: false, maxline: 10,
                            ),
                            SizedBox(height: D.H / 36),
                            CustomButton(
                              color: ColorConstants.blueBtn,
                              onTap: () {
                                NavigationHelpers.redirect(context, OtpVerificationScreen());
                              },
                              text: "Send",
                              textColor: Colors.white,
                            ),
                            SizedBox(height: D.H / 12),
                          ],
                        ),
                      )
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
