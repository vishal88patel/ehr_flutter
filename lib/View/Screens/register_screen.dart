import 'dart:convert';
import 'dart:math';
import 'package:ehr/View/Screens/survey_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Constants/api_endpoint.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_date_field.dart';
import '../../customWidgets/custom_textform_field.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final bDayController = TextEditingController();
  int bDate=0;
  final _formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  int genderId=1;
  bool male=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 10),
            Center(child: SvgPicture.asset("assets/images/login_logo.svg")),
            SizedBox(height: D.H / 24),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Card(
                    color: ColorConstants.blueBtn,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(48),
                          topRight: Radius.circular(48)),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      color: ColorConstants.lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            topRight: Radius.circular(48)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: D.W / 10, right: D.W / 10, top: D.H / 11),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name",
                                style: GoogleFonts.heebo(
                                    fontSize: D.H / 52,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: D.H / 120),
                              CustomTextFormField(
                                controller: fNameController,
                                readOnly: false,
                                validators: (String? value) {
                                  if (fNameController.text == '') {
                                    return '*Please enter FirstName';
                                  }
                                  return null;
                                },
                                keyboardTYPE: TextInputType.text,
                                obscured: false,
                              ),
                              SizedBox(height: D.H / 40),
                              Text(
                                "Last Name",
                                style: GoogleFonts.heebo(
                                    fontSize: D.H / 52,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: D.H / 120),
                              CustomTextFormField(
                                controller: lNameController,
                                readOnly: false,
                                validators: (String? value) {
                                  if (lNameController.text == '') {
                                    return '*Please enter LastName';
                                  }
                                  return null;
                                },
                                keyboardTYPE: TextInputType.text,
                                obscured: false,
                              ),
                              SizedBox(height: D.H / 40),
                              Text(
                                "Email",
                                style: GoogleFonts.heebo(
                                    fontSize: D.H / 52,
                                    fontWeight: FontWeight.w400),

                              ),
                              SizedBox(height: D.H / 120),
                              CustomTextFormField(
                                controller: emailController,
                                readOnly: false,
                                validators: (e) {
                                  if (emailController.text == null ||
                                      emailController.text == '') {
                                    return '*Please enter Email';
                                  } else if (!EmailValidator.validate(
                                      emailController.text)) {
                                    return '*Please enter valid Email';
                                  }
                                },
                                keyboardTYPE: TextInputType.text,
                                obscured: false,
                              ),
                              SizedBox(height: D.H / 40),
                              Text(
                                "Date of birth",
                                style: GoogleFonts.heebo(
                                    fontSize: D.H / 52,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: D.H / 120),
                              Container(
                                width: D.W,
                                child: CustomDateField(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    _selectDate(context, bDayController,bDate);
                                  },
                                  controller: bDayController,
                                  iconPath: "assets/images/ic_date.svg",
                                  readOnly: true,
                                  validators: (e) {
                                    if (bDayController.text == null ||
                                        bDayController.text == '') {
                                      return '*Please enter Start Date';
                                    }
                                  },
                                  keyboardTYPE: TextInputType.text,
                                  obscured: false,
                                ),
                              ),
                              SizedBox(height: D.H / 40),
                              Text(
                                "Gender",
                                style: GoogleFonts.heebo(
                                    fontSize: D.H / 52,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: D.H / 100),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Container(
                                      height: D.W / 19,
                                      width: D.W / 19,
                                      decoration: new BoxDecoration(
                                        color: male?ColorConstants.primaryBlueColor:ColorConstants.innerColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        male=true;
                                        genderId=1;
                                      });
                                    },
                                  ),
                                  SizedBox(width: D.W / 60),
                                  Text(
                                    "Male",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 29,
                                  ),
                                  InkWell(
                                    child: Container(
                                      height: D.W / 19,
                                      width: D.W / 19,
                                      decoration: new BoxDecoration(
                                        color: male?ColorConstants.innerColor:ColorConstants.primaryBlueColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      setState(() {
                                        male=false;
                                        genderId=2;
                                      });
                                    },
                                  ),
                                  SizedBox(width: D.W / 60),
                                  Text(
                                    "Female",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: D.H / 36),
                              CustomButton(
                                color: ColorConstants.blueBtn,
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    updateProfile(
                                      firstName: fNameController.text.toString(),
                                      lastName: lNameController.text.toString(),
                                      birthdate: bDate,
                                      gender: genderId,
                                      email: emailController.text.toString()
                                    );
                                  }
                                },
                                text: "Save",
                                textColor: Colors.white,
                              ),
                              SizedBox(height: D.H / 9.2),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context, final controller,int Date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yyy');
        final String startDate = formatter.format(picked);
        controller.text = startDate.toString();

        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(startDate);
        Date=dateTimeFormat.millisecondsSinceEpoch;
        print("Date:"+Date.toString());
      });
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required int birthdate,
    required int gender,
    required String email,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.updateProfile;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "Birthdate": birthdate,
      "gender": gender,
      "email": email
    };

    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {

      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage(res["message"]);
      NavigationHelpers.redirectto(context, SurveyScreen());
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
