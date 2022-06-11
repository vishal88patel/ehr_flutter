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
import 'otpScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  int _groupValue = -1;
  var _selectedGender = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 10),
            Center(child: SvgPicture.asset("assets/images/login_logo.svg")),
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
                        height: MediaQuery.of(context).size.height,
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
                        "Gender",
                        style: GoogleFonts.heebo(
                            fontSize: D.H / 52, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Radio(
                            onChanged: (value) {
                              _selectedGender = "male";
                              setState(() {});
                            },
                            groupValue: _selectedGender,
                            value: "male",
                          ),
                          Text(
                            "Male",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Radio(
                            onChanged: (value) {
                              _selectedGender = "Female";
                              setState(() {});
                            },
                            groupValue: _selectedGender,
                            value: "Female",
                          ),
                          Text(
                            "Female",
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      ),
                      SizedBox(height: D.H / 36),
                      CustomButton(
                        color: ColorConstants.blueBtn,
                        onTap: () {
                          NavigationHelpers.redirect(context, OtpScreen());
                        },
                        text: "Save",
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
