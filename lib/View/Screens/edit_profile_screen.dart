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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
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
              "Edit Profile",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 22),
            Center(child: SvgPicture.asset("assets/images/bg_editProfile.svg")),
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
                        height: MediaQuery.of(context).size.height/1.4,
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
                        "First Name",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: D.H / 120),
                      CustomTextFormField(
                        controller: fNameController,
                        readOnly: false,
                        validators: (e) {
                          if (fNameController.text == null ||
                              fNameController.text == '') {
                            return '*Please enter FirstName';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                      SizedBox(height: D.H / 40),
                      Text(
                        "Last Name",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: D.H / 120),
                      CustomTextFormField(
                        controller: lNameController,
                        readOnly: false,
                        validators: (e) {
                          if (lNameController.text == null ||
                              lNameController.text == '') {
                            return '*Please enter LastName';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                      SizedBox(height: D.H / 40),
                      Text(
                        "Email",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: D.H / 120),
                      CustomTextFormField(
                        controller: emailController,
                        readOnly: false,
                        validators: (e) {
                          if (emailController.text == null ||
                              emailController.text == '') {
                            return '*Please enter Email';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                      SizedBox(height: D.H / 40),
                      Text(
                        "Phone",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      CustomTextFormField(
                        controller: phoneController,
                        readOnly: false,
                        validators: (e) {
                          if (phoneController.text == null ||
                              phoneController.text == '') {
                            return '*Please enter Phone';
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
