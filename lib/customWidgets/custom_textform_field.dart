import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Utils/dimensions.dart';
import '../Constants/color_constants.dart';
import '../Utils/dimensions.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {Key? key,
        required this.controller,
        required this.readOnly,
        required this.validators,
        required this.keyboardTYPE,
        this.maxlength, this.onChanged,
        required this.obscured,});

  final TextEditingController controller;
  int? maxlength;
  bool readOnly;
  bool obscured;
  TextInputType? keyboardTYPE;
  final FormFieldValidator<String> validators;
  final FormFieldValidator<String>? onChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
          contentPadding: EdgeInsets.only(left:D.W/30,right: D.W/30),
          focusColor: ColorConstants.whiteColor,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          errorBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          disabledBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
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