import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:ehr/View/Screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
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
              "OTP",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 22),
            Center(child: SvgPicture.asset("assets/images/bg_otp_verification.svg")),
            SizedBox(height: D.H / 18),
            Center(
              child: Text(
                "Email Verification",
                style: GoogleFonts.inter(
                    fontSize: D.H / 40, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: D.H / 120),
            Padding(
              padding: EdgeInsets.only(left: D.W / 12,right: D.W / 12),
              child: Text(
                "Check your Email We have sent you the code at ***123@gmail.com",textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: D.H / 48,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.lightText),
              ),
            ),
            SizedBox(height: D.H / 18),
            Padding(
              padding:  EdgeInsets.only(left: D.W / 12,right: D.W / 12),
              child: PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                cursorColor: ColorConstants.blueBtn,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: D.H / 14,
                  fieldWidth: D.H / 13,
                  activeFillColor: ColorConstants.lightPurple,
                  disabledColor: Colors.white,
                  errorBorderColor: Colors.white,
                  activeColor: Colors.white,
                  selectedColor: Colors.white,
                  inactiveColor: ColorConstants.whiteColor,
                  inactiveFillColor: ColorConstants.lightPurple,
                  selectedFillColor: ColorConstants.lightPurple,),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: pinController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
                appContext: context,
              ),
            ),
            SizedBox(height: D.H / 22),
            Padding(
              padding:  EdgeInsets.only(left: D.W / 12,right: D.W / 12),
              child: CustomButton(
                color: ColorConstants.blueBtn,
                onTap: () {
                  NavigationHelpers.redirect(context, ProfileScreen());
                },
                text: "Done",
                textColor: Colors.white,  
              ),
            )
          ],
        ),
      ),
    );
  }
}
