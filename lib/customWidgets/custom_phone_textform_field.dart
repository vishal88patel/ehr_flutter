import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Utils/dimensions.dart';
import '../Constants/color_constants.dart';
import '../Utils/dimensions.dart';

class CustomPhoneTextFormField extends StatefulWidget {
  CustomPhoneTextFormField(
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
  State<CustomPhoneTextFormField> createState() => _CustomPhoneTextFormFieldState();
}

class _CustomPhoneTextFormFieldState extends State<CustomPhoneTextFormField> {
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
    return TextFormField(
      obscureText: _obscured,
      readOnly: widget.readOnly,
      controller:widget.controller,
      validator: widget.validators,
      onChanged: widget.onChanged,
      maxLength: widget.maxlength,
      cursorColor: ColorConstants.primaryBlueColor,
      decoration: InputDecoration(
        focusColor: ColorConstants.whiteColor,
        filled: true,
        fillColor: ColorConstants.innerColor,
        enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),

        errorMaxLines: 4,
        labelStyle: TextStyle(fontSize: D.H/48, color: Colors.black),
      ),
      keyboardType: widget.keyboardTYPE,
    );
  }
}