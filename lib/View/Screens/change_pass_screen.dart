import 'dart:math';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_textform_field.dart';
import 'otp_screen.dart';
import 'otp_verification_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oPassController = TextEditingController();
  final nPassController = TextEditingController();
  final cPassController = TextEditingController();
  var _selectedGender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        title: Padding(
          padding: EdgeInsets.only(right: D.W/8),
          child: Center(
            child: Text(
              "Change password",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 22),
            Center(child: Image.asset("assets/images/bg_change_pass.png")),
            SizedBox(height: D.H / 24),
            Stack(
              children: [
                Center(child: SvgPicture.asset("assets/images/bg_blue.svg")),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/bg_light.svg",
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height/1.61,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: D.W / 10, right: D.W / 10, top: D.H / 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Old Password",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: D.H / 120),
                      CustomTextFormField(
                        controller: oPassController,
                        readOnly: false,
                        validators: (e) {
                          if (oPassController.text == null ||
                              oPassController.text == '') {
                            return '*Please enter Old Password';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                      SizedBox(height: D.H / 40),
                      Text(
                        "New Password",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: D.H / 120),
                      CustomTextFormField(
                        controller: nPassController,
                        readOnly: false,
                        validators: (e) {
                          if (nPassController.text == null ||
                              nPassController.text == '') {
                            return '*Please enter New Password';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                      SizedBox(height: D.H / 40),
                      Text(
                        "Confirm Password",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: D.H / 120),
                      CustomTextFormField(
                        controller: cPassController,
                        readOnly: false,
                        validators: (e) {
                          if (cPassController.text == null ||
                              cPassController.text == '') {
                            return '*Please enter Confirm Password';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                      SizedBox(height: D.H / 36),
                      CustomButton(
                        color: ColorConstants.blueBtn,
                        onTap: () {
                          NavigationHelpers.redirect(context, OtpVerificationScreen());
                        },
                        text: "Update",
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
