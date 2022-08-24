import 'dart:convert';
import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:ehr/View/Screens/register_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../../Constants/api_endpoint.dart';
import '../../Model/otp_verification_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_textform_field.dart';
import 'otp_screen.dart';
import 'otp_verification_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final bdayController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  late OtpVerificationModel dataModel;
  String firstName=" ";
  String lastName=" ";
  String email=" ";
  String phone=" ";
  int birthdate= 0 ;
  int gender=1;
  var _selectedGender = "male";
  OtpVerificationModel? otpModel;
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getDataa();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Text(
              "Edit Profile",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 22),
            Center(child: SvgPicture.asset("assets/images/bg_editProfile.svg")),
            SizedBox(height: D.H / 24),
            Stack(
              children: [
                Center(child: SvgPicture.asset("assets/images/bg_blue.svg")),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/bg_light.svg",
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height/1.1,
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: D.W / 10, right: D.W / 10, top: D.H / 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: fNameController,
                          readOnly: false,
                          validators: (e) {
                            if (fNameController.text == null ||
                                fNameController.text == '') {
                              return '*Please enter FirstName';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 40),
                        Text(
                          "Last Name",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: lNameController,
                          readOnly: false,
                          validators: (e) {
                            if (lNameController.text == null ||
                                lNameController.text == '') {
                              return '*Please enter LastName';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 40),
                        Text(
                          "Date of Birth",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: bdayController,
                          readOnly: false,
                          validators: (e) {
                            if (lNameController.text == null ||
                                lNameController.text == '') {
                              return '*Please enter dob';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 40),
                        Text(
                          "Gender",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: D.H / 120),
                        CustomTextFormField(
                          controller: genderController,
                          readOnly: false,
                          validators: (e) {
                            if (lNameController.text == null ||
                                lNameController.text == '') {
                              return '*Please enter LastName';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 40),
                        Text(
                          "Email",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
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
                          "Phone",
                          style: GoogleFonts.heebo(
                              fontSize: D.H / 52, fontWeight: FontWeight.w400),
                        ),
                        CustomTextFormField(
                          controller: phoneController,
                          readOnly: true,
                          validators: (e) {
                            if (phoneController.text == null ||
                                phoneController.text == '') {
                              return '*Please enter Phone';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                        SizedBox(height: D.H / 36),
                        CustomButton(
                          color: ColorConstants.blueBtn,
                          onTap: () async {
                            if( _formKey.currentState!.validate()){
                              updateProfile(
                                  lastName: lNameController.text.toString(),
                                  firstName: fNameController.text.toString(),
                                  birthdate: birthdate,
                                  email: emailController.text,
                                  gender: 1
                              );
                            }
                            setState(() {

                            });

                          },
                          text: "Update",
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getDataa() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getProfile;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString(
          "ACCESSTOKEN")}',
    };

    Response response = await get(
      uri,
      headers: headers,
    );
    CommonUtils.hideProgressDialog(context);
    dataModel = OtpVerificationModel.fromJson(jsonDecode(response.body));
    fNameController.text = dataModel.firstName.toString();
    lNameController.text = dataModel.lastName.toString();
    bdayController.text = dataModel.birthdate.toString();
    genderController.text = " ";
    emailController.text = dataModel.email.toString();
    phoneController.text = dataModel.phoneNumber.toString();
    setState(() {

    });
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
      CommonUtils.showGreenToastMessage("Data Updated Successfully");
      //Navigator.pop(context);
      NavigationHelpers.redirect(context, OtpVerificationScreen(emailController.text));
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
