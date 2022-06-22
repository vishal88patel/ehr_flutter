import 'dart:convert';
import 'dart:math';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../../Constants/api_endpoint.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
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
  final _formkey = GlobalKey<FormState>();
  int _groupValue = -1;
  var _selectedGender = "male";

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
                                validators: (String? value) {
                                  if (emailController.text == '') {
                                    return '*Please enter Email';
                                  }
                                  return null;
                                },
                                keyboardTYPE: TextInputType.text,
                                obscured: false,
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
                                  Container(
                                    height: D.W / 19,
                                    width: D.W / 19,
                                    decoration: new BoxDecoration(
                                      color: ColorConstants.innerColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white.withOpacity(0.5),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
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
                                  Container(
                                    height: D.W / 19,
                                    width: D.W / 19,
                                    decoration: new BoxDecoration(
                                      color: ColorConstants.innerColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white.withOpacity(0.5),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
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
                                      birthdate: 630873000000,
                                      gender: 1,
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

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required int birthdate,
    required int gender,
    required String email,
  }) async {
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
      CommonUtils.showGreenToastMessage("Register Successfully");
      NavigationHelpers.redirectto(context, DashBoardScreen(1));
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
