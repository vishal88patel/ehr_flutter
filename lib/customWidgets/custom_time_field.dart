import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Utils/dimensions.dart';
import '../Constants/color_constants.dart';
import '../Utils/dimensions.dart';

class CustomTimeField extends StatefulWidget {
  CustomTimeField(
      {Key? key,
        required this.controller,
        required this.readOnly,
        required this.validators,
        required this.keyboardTYPE,
        this.iconPath,
        this.maxlength, this.onChanged,
        required this.onTap,
        required this.obscured,});

  final TextEditingController controller;
  int? maxlength;
  bool readOnly;
  bool obscured;
  TextInputType? keyboardTYPE;
  String? iconPath;
  Function onTap;
  final FormFieldValidator<String> validators;
  final FormFieldValidator<String>? onChanged;

  @override
  State<CustomTimeField> createState() => _CustomTimeFieldState();
}

class _CustomTimeFieldState extends State<CustomTimeField> {
  bool _obscured = false;

  final textFieldFocusNode = FocusNode();
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  @override
  void initState() {
    _obscured=widget.obscured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: D.H/16,
      child: TextFormField(
        obscureText: _obscured,
        readOnly: widget.readOnly,
        controller:widget.controller,
        validator: widget.validators,
        onChanged: widget.onChanged,
        maxLength: widget.maxlength,
        cursorColor: ColorConstants.primaryBlueColor,
        decoration: InputDecoration(
          suffixIcon:widget.iconPath!=null? IconButton(
            icon: SvgPicture.asset(widget.iconPath.toString()),
            onPressed: () => widget.onTap(),
          ):null,
          contentPadding: EdgeInsets.only(left:D.W/40),
          focusColor: ColorConstants.innerColor,
          filled: true,
          fillColor: ColorConstants.innerColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          errorMaxLines: 4,
          labelStyle: TextStyle(fontSize: D.H/48, color: Colors.black),
        ),
        keyboardType: widget.keyboardTYPE,
      ),
    );
  }
}