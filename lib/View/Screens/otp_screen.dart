import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 24.0,
          color: Colors.black,
        )),
        backgroundColor: ColorConstants.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 4),
            Padding(
              padding: EdgeInsets.only(left: D.W / 12),
              child: Text(
                "Phone Verification",
                style: GoogleFonts.inter(
                    fontSize: D.H / 32, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: D.H / 120),
            Padding(
              padding: EdgeInsets.only(left: D.W / 12),
              child: Text(
                "Enter your OTP code here",
                style: GoogleFonts.inter(
                    fontSize: D.H / 48,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.lightText),
              ),
            ),
            SizedBox(height: D.H / 20),
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
                      child:Padding(
                        padding: EdgeInsets.only(
                            left: D.W / 10, right: D.W / 10, top: D.H / 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PinCodeTextField(
                              length: 4,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              cursorColor: ColorConstants.blueBtn,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: D.H / 14,
                                  fieldWidth: D.H / 13,
                                  activeFillColor: ColorConstants.innerColor,
                                  disabledColor: ColorConstants.innerColor,
                                  errorBorderColor: Colors.white.withOpacity(0.5),
                                  activeColor: Colors.white.withOpacity(0.5),
                                  selectedColor: Colors.white.withOpacity(0.5),
                                  inactiveColor: Colors.white.withOpacity(0.5),
                                  inactiveFillColor: ColorConstants.innerColor,
                                  selectedFillColor: ColorConstants.innerColor,),
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
                            SizedBox(height: D.H / 80),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Get Otp?",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Resend",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 44,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(height: D.H / 26),
                            CustomButton(
                              color: ColorConstants.blueBtn,
                              onTap: () {
                                NavigationHelpers.redirect(context, RegisterScreen());
                              },
                              text: "Verify",
                              textColor: Colors.white,
                            ),
                            SizedBox(height:D.H/5.9),
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
