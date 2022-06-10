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
        title: Text(
          "Home",
          style: GoogleFonts.heebo(fontWeight: FontWeight.normal),
        ),
        actions: [
          SvgPicture.asset(
            "assets/images/avatar.svg",
          ),
          Container(
            width: 5,
          )
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Diagnosis History",
                  style: GoogleFonts.heebo(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  width: 100,

                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstants.primaryBlueColor, //                   <--- border color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    height: 50,
                    child: Center(
                        child: Text(
                      "Backside",
                      style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700,color: ColorConstants.primaryBlueColor),
                    ))),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.primaryBlueColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
