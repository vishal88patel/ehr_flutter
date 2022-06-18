import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_date_field.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final mNameController = TextEditingController();
  final dosageController = TextEditingController();
  final sDateController = TextEditingController();
  final eDateController = TextEditingController();
  var _selectedFood = "after";
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        title: Padding(
          padding: EdgeInsets.only(right: D.W / 8),
          child: Center(
            child: Text(
              "Add Medication",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
      ),
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: D.H / 24, right: D.H / 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: D.H / 22),
                  Center(
                      child:
                          SvgPicture.asset("assets/images/bg_add_medication.svg")),
                  SizedBox(height: D.H / 24),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal:0),
              color: ColorConstants.lightPurple,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48)),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height/1.4,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: D.W / 10, right: D.W / 10, top: D.H / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        Container(
                          padding: EdgeInsets.only(left:D.W/30,right: D.W/60),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: ColorConstants.innerColor,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                              style: BorderStyle.solid,
                            ),

                          ),
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
                              "Please choose a Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: D.H/48,
                                  fontWeight: FontWeight.w400),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: D.H / 60),
                        Text(
                          "Medication Name",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: mNameController,
                          readOnly: false,
                          validators: (e) {
                            if (mNameController.text == null ||
                                mNameController.text == '') {
                              return '*Medication Name';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 60),
                        Text(
                          "Dosage",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: dosageController,
                          readOnly: false,
                          validators: (e) {
                            if (dosageController.text == null ||
                                dosageController.text == '') {
                              return '*Please enter Dosage';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 60),
                        Text(
                          "Food",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:D.W/19,
                              width: D.W/19,
                              decoration: new BoxDecoration(
                                color: ColorConstants.innerColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              "With Food",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 29,
                            ),
                            Container(
                              height:D.W/19,
                              width: D.W/19,
                              decoration: new BoxDecoration(
                                color: ColorConstants.innerColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              "Before",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 29,
                            ),
                            Container(
                              height:D.W/19,
                              width: D.W/19,
                              decoration: new BoxDecoration(
                                color: ColorConstants.innerColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            SizedBox(width: D.W / 60),
                            Text(
                              "After",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: D.H / 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Date",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: D.H / 120),
                                Container(
                                  width: D.W / 2.9,

                                  child: CustomDateField(
                                    controller: sDateController,
                                    iconPath: "assets/images/ic_date.svg",
                                    readOnly: false,
                                    validators: (e) {
                                      if (sDateController.text == null ||
                                          sDateController.text == '') {
                                        return '*Please enter Start Date';
                                      }
                                    },
                                    keyboardTYPE: TextInputType.text,
                                    obscured: false,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Date",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: D.H / 120),
                                Container(
                                  width: D.W / 2.9,
                                  child: CustomDateField(
                                    controller: eDateController,
                                    iconPath: "assets/images/ic_date.svg",
                                    readOnly: false,
                                    validators: (e) {
                                      if (eDateController.text == null ||
                                          eDateController.text == '') {
                                        return '*Please enter End Date';
                                      }
                                    },
                                    keyboardTYPE: TextInputType.text,
                                    obscured: false,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: D.H / 32),
                        CustomButton(
                          color: ColorConstants.blueBtn,
                          onTap: () {
                            NavigationHelpers.redirect(
                                context, OtpVerificationScreen());
                          },
                          text: "Done",
                          textColor: Colors.white,
                        ),
                        SizedBox(height: D.H / 28),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
