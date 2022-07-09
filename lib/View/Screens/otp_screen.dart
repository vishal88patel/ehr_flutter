import 'dart:async';
import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Utils/common_utils.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:ehr/View/Screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Constants/api_endpoint.dart';
import '../../Model/otp_verification_model.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';

class OtpScreen extends StatefulWidget {

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  Timer? _timer;
  int _time = 60;
  bool resend=false;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_time == 0) {
          setState(() {
            timer.cancel();
            resend=true;
          });
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(
          Icons.arrow_back_ios_rounded,
          size: 24.0,
          color: Colors.black,
        )),
        backgroundColor: ColorConstants.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 4),
            Padding(
              padding: EdgeInsets.only(left: D.W / 12),
              child: Text(
                "Phone Verification",
                style: GoogleFonts.inter(
                    fontSize: D.H / 32, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: D.H / 120),
            Padding(
              padding: EdgeInsets.only(left: D.W / 12),
              child: Text(
                "Enter your OTP code here",
                style: GoogleFonts.inter(
                    fontSize: D.H / 48,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.lightText),
              ),
            ),
            SizedBox(height: D.H / 20),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                  child: Card(
                    color: ColorConstants.blueBtn,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(48),
                          topRight: Radius.circular(48)),

                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height:40,

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                      margin: const EdgeInsets.symmetric(horizontal:0),
                      color: ColorConstants.lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(48),
                            topRight: Radius.circular(48)),
                      ),
                      child:Padding(
                        padding: EdgeInsets.only(
                            left: D.W / 10, right: D.W / 10, top: D.H / 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PinCodeTextField(
                              keyboardType: TextInputType.number,
                              length: 4,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              cursorColor: ColorConstants.blueBtn,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: D.H / 14,
                                  fieldWidth: D.H / 13,
                                  activeFillColor: ColorConstants.innerColor,
                                  disabledColor: ColorConstants.innerColor,
                                  errorBorderColor: Colors.white.withOpacity(0.5),
                                  activeColor: Colors.white.withOpacity(0.5),
                                  selectedColor: Colors.white.withOpacity(0.5),
                                  inactiveColor: Colors.white.withOpacity(0.5),
                                  inactiveFillColor: ColorConstants.innerColor,
                                  selectedFillColor: ColorConstants.innerColor,),
                              animationDuration: Duration(milliseconds: 300),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              controller: pinController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {},
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                return true;
                              },
                              appContext: context,
                            ),
                            SizedBox(height: D.H / 80),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Get Otp? ",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                                resend==true?InkWell(
                                  child: Text(
                                    "Resend",
                                    style: GoogleFonts.heebo(
                                        fontSize: D.H / 52,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  onTap: (){
                                    callResendOtpVerificationApi();

                                  },
                                ):Text(
                                  "00:"+_time.toString(),
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(height: D.H / 26),
                            CustomButton(
                              color: ColorConstants.blueBtn,
                              onTap: () {
                                if(pinController.text.length==4){
                                  callOtpVerificationApi();
                                  // NavigationHelpers.redirect(context, RegisterScreen());

                                }else{
                                  CommonUtils.showRedToastMessage("Please enter all digits");

                                }
                              },
                              text: "Verify",
                              textColor: Colors.white,
                            ),
                            SizedBox(height:D.H/5.9),
                          ],
                        ),
                      )
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> callOtpVerificationApi() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.otpVeryfy;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "code": pinController.text,

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
    if (statusCode == 200 ) {
      OtpVerificationModel model=OtpVerificationModel();
      model=OtpVerificationModel.fromJson(res);
      PreferenceUtils.putObject("OtpVerificationResponse", model);

      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("Login Successfully");
      if(model.registrationCompleted==true){
        _timer!.cancel();
        NavigationHelpers.redirectto(context, DashBoardScreen(1));
      }else{
        _timer!.cancel();
        NavigationHelpers.redirectto(context, RegisterScreen());

      }

    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> callResendOtpVerificationApi() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.resendOtp;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    Response response = await get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200 ) {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("Otp Send Successfully");
      setState(() {
        _time=60;
        startTimer();
        resend=false;
      });
      //NavigationHelpers.redirect(context, RegisterScreen());
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
