import 'dart:convert';
import 'dart:math';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:ehr/View/Screens/register_screen.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
   getData();
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
                        height: MediaQuery.of(context).size.height/1.4,
                      ),
                    ],
                  ),
                ),
                Padding(
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
                        readOnly: false,
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
                          updateProfile(
                            lastName: lNameController.text.toString(),
                              firstName: fNameController.text.toString(),
                               birthdate: birthdate,
                            email: emailController.text,
                            gender: 1
                          );
                        },
                        text: "Update",
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getData() async {
    dataModel = (await PreferenceUtils.getDataObject('OtpVerificationResponse'))!;

    if(dataModel!=null){
      firstName=dataModel.firstName!;
      lastName=dataModel.lastName!;
      email=dataModel.email!;
      phone=dataModel.phoneNumber!;
      birthdate=dataModel.birthdate!;

      fNameController.text=firstName;
      lNameController.text=lastName;
      emailController.text=email;
      phoneController.text=phone;
    }else{

    }
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
      CommonUtils.showGreenToastMessage("Register Successfully");
      NavigationHelpers.redirect(context, OtpVerificationScreen());
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
