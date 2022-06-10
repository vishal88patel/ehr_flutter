import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/color_constants.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  _BodyScreenState createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 4,
        centerTitle: true,
        title:Text("Home",style: GoogleFonts.heebo(fontWeight: FontWeight.normal),),
        actions: [
          SvgPicture.asset("assets/images/avatar.svg",),
          Container(
            width: 5,
          )
        ],
      ),
    );
  }
}

