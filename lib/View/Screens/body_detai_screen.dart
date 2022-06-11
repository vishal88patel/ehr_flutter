import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import 'otpScreen.dart';


class BodyDetailScreen extends StatefulWidget {
  String appBarName;
   BodyDetailScreen({required this.appBarName}) ;

  @override
  State<BodyDetailScreen> createState() => _BodyDetailScreenState();
}

class _BodyDetailScreenState extends State<BodyDetailScreen> {
  final ccController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 4,
        centerTitle: true,
        title: Text(
          widget.appBarName,
          style: GoogleFonts.heebo(fontWeight: FontWeight.normal),
        ),

      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(child: SvgPicture.asset("assets/images/detail_icon.svg")),
            Stack(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:6.0),
                  child: SvgPicture.asset("assets/images/bg_light.svg",fit: BoxFit.fill,height:MediaQuery.of(context).size.height,),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: D.W/10,right: D.W/10,top: D.H/25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Body Area",style: GoogleFonts.heebo(fontSize: D.H/52,fontWeight: FontWeight.normal),),
                      SizedBox(height:D.H/120),
                      CustomTextFormField(keyboardTYPE: TextInputType.name, validators: (String? value) {  }, obscured: false, readOnly: false, controller:ccController ,),
                      SizedBox(height:D.H/22),
                      CustomButton(color: ColorConstants.blueBtn,onTap: (){
                        NavigationHelpers.redirect(context, OtpScreen());
                      },text: "Save",textColor: Colors.white,)
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
