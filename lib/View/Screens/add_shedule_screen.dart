import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import 'otp_screen.dart';

class AddSheduleScreen extends StatefulWidget {
  const AddSheduleScreen({Key? key}) : super(key: key);

  @override
  State<AddSheduleScreen> createState() => _AddSheduleScreenState();
}

class _AddSheduleScreenState extends State<AddSheduleScreen> {
  final valueController = TextEditingController();
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        title: Center(
            child: Text(
              "Add Schedule",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            )),
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 2),
            Container(
              color: ColorConstants.lightPurple,
              child: Column(
                children: [
                  SizedBox(height: D.H / 26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: D.W / 18),
                            child: Text(
                              "Select Time",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 52,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: D.H / 240),
                          Padding(
                            padding: EdgeInsets.only(left: D.W / 18),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: D.W / 30, right: D.W / 60),
                              width: MediaQuery.of(context).size.width / 1.8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Colors.white,
                                value: _chosenValue,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: ColorConstants.lightGrey,
                                icon: Icon(Icons.arrow_drop_down_sharp),
                                iconSize: 32,
                                underline: Container(color: Colors.transparent),
                                items: <String>[
                                  'Abc',
                                  'Bcd',
                                  'Cde',
                                  'Def',
                                  'Efg',
                                  'Fgh',
                                  'Ghi',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: D.H / 48,
                                      fontWeight: FontWeight.w400),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: D.W / 18, right: D.W / 18),
                            child: Text(
                              "Select Time",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 52,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: D.H / 240),
                          Padding(
                            padding: EdgeInsets.only(
                                left: D.W / 18, right: D.W / 18),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: D.W / 30, right: D.W / 60),
                              width: MediaQuery.of(context).size.width / 3.65,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Colors.white,
                                value: _chosenValue,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: ColorConstants.lightGrey,
                                icon: Icon(Icons.arrow_drop_down_sharp),
                                iconSize: 32,
                                underline: Container(color: Colors.transparent),
                                items: <String>[
                                  'Abc',
                                  'Bcd',
                                  'Cde',
                                  'Def',
                                  'Efg',
                                  'Fgh',
                                  'Ghi',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: D.H / 48,
                                      fontWeight: FontWeight.w400),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: D.H / 60),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: D.W / 18, right: D.W / 18),
                        child: Text(
                          "Comment",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: D.W / 18, right: D.W / 18),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: CustomTextFormField(
                        controller: valueController,
                        readOnly: false,
                        validators: (e) {
                          if (valueController.text == null ||
                              valueController.text == '') {
                            return '*Value';
                          }
                        },
                        keyboardTYPE: TextInputType.text,
                        obscured: false,
                      ),
                    ),
                  ),
                  SizedBox(height: D.H / 26),
                  Padding(
                    padding: EdgeInsets.only(left: D.W / 10, right: D.W / 10),
                    child: CustomButton(
                      color: ColorConstants.blueBtn,
                      onTap: () {
                        NavigationHelpers.redirect(context, OtpScreen());
                      },
                      text: "Save",
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: D.H / 26),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
