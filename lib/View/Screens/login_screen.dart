import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import 'otpScreen.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final ccController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                Center(child: SvgPicture.asset("assets/images/bg_blue.svg")),
                Padding(
                  padding: const EdgeInsets.only(top:6.0),
                  child: SvgPicture.asset("assets/images/bg_light.svg",fit: BoxFit.fill,height:MediaQuery.of(context).size.height,),
                ),
                Padding(
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
                      },text: "Login",textColor: Colors.white,)
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
