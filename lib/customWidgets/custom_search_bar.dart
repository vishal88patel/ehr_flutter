import 'package:flutter/material.dart';

import '../Constants/color_constants.dart';
import '../Utils/dimensions.dart';

class CUstomSearchBar extends StatelessWidget {
  CUstomSearchBar(
      {Key? key,
      required this.controller,
      required this.readOnly,
      required this.hint,
      required this.validators,
      required this.keyboardTYPE,
      required this.function,
      this.maxlength,
      this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  String hint;
  int? maxlength;
  bool readOnly;
  TextInputType? keyboardTYPE;
  final FormFieldValidator<String> validators;
  final FormFieldValidator<String>? onChanged;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: D.W / 60, vertical: D.H / 100),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          onTap: () {
            function.call();
          },
          readOnly: readOnly,
          controller: controller,
          validator: validators,
          onChanged: onChanged,
          maxLength: maxlength,
          cursorColor: ColorConstants.primaryBlueColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            focusColor: ColorConstants.whiteColor,
            filled: true,
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.grey,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            errorMaxLines: 4,
            hintText: hint,
            hintStyle:  TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(0.3)),
            labelStyle:  TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(0.3)),
          ),
          keyboardType: keyboardTYPE,
        ),
      ),
    );
  }
}
