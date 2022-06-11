import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import 'otpScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ccController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        title: Center(
            child: Text(
          "Profile",
          style: GoogleFonts.heebo(
              fontSize: D.H / 44, fontWeight: FontWeight.w500),
        )),
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:D.H / 24,right: D.H / 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: D.H / 22),
              Stack(
                children: [
                  Image.asset("assets/images/bg_profile.png",height: D.H/6,fit: BoxFit.fill,),
                  Padding(
                    padding:  EdgeInsets.only(top: 80.0,bottom: 10),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                          height: D.H/7,
                          width: D.H/7,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
