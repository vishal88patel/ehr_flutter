import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.textColor,
      required this.onTap})
      : super(key: key);
  String text;
  Color color;
  Color textColor;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        height: D.H / 14,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.heebo(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: D.H / 40,
            ),
          ),
        ),
      ),
    );
  }
}
