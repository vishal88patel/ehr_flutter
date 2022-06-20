import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/color_constants.dart';
import '../Utils/dimensions.dart';

class CUstomSearchBar2 extends StatelessWidget {
  CUstomSearchBar2(
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
        height: 46.0,
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
            suffixIcon: IconButton(
              onPressed: (){},
              iconSize: 35,
              color: Colors.black.withOpacity(0.3),
              icon: Icon(Icons.arrow_drop_down_outlined),
            ),
            contentPadding: EdgeInsets.all(8),
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
