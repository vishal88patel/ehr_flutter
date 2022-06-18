import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import 'otp_screen.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final ccController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height:D.H/5),
            Center(child: SvgPicture.asset("assets/images/login_logo.svg")),
            SizedBox(height:D.H/20),
            Text("WELCOME BACK",style: GoogleFonts.heebo(fontSize: D.H/32,fontWeight: FontWeight.w700),),
            SizedBox(height:D.H/24),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                  child: Card(
                    margin: EdgeInsets.zero,
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
                  padding: const EdgeInsets.only(top: 6),
                  child: Card(
                      color: ColorConstants.lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            topRight: Radius.circular(48)),
                      ),
                      child:Padding(
                        padding:  EdgeInsets.only(left: D.W/10,right: D.W/10,top: D.H/11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mobile Number",style: GoogleFonts.heebo(fontSize: D.H/52,fontWeight: FontWeight.w400),),
                            SizedBox(height:D.H/120),
                            CustomTextFormField(keyboardTYPE: TextInputType.name, validators: (String? value) {  }, obscured: false, readOnly: false, controller:ccController ,),
                            SizedBox(height:D.H/22),
                            CustomButton(color: ColorConstants.blueBtn,onTap: (){
                              NavigationHelpers.redirect(context, OtpScreen());
                            },text: "Login",textColor: Colors.white,),
                            SizedBox(height:D.H/4.3),
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
