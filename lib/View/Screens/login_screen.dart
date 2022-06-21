import 'dart:ffi';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_button.dart';
import 'otp_screen.dart';
import 'package:flutter/services.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final ccController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String platform="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        platform="Android";
        deviceData =
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        platform="Ios";
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: D.H / 5),
            Center(child: SvgPicture.asset("assets/images/login_logo.svg")),
            SizedBox(height: D.H / 20),
            Text("WELCOME BACK", style: GoogleFonts.heebo(
                fontSize: D.H / 32, fontWeight: FontWeight.w700),),
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                              Text("Mobile Number", style: GoogleFonts.heebo(
                                  fontSize: D.H / 52,
                                  fontWeight: FontWeight.w400),),
                              SizedBox(height: D.H / 120),
                              CustomTextFormField(
                                keyboardTYPE: TextInputType.number,
                                validators: (String? value) {
                                  if (ccController.text.isEmpty) {
                                    return "Please enter detail";
                                  } else if (ccController.text.length < 10) {
                                    return "Please valid mobile number";
                                  }
                                },
                                obscured: false,
                                readOnly: false,
                                controller: ccController,),
                              SizedBox(height: D.H / 22),
                              CustomButton(
                                color: ColorConstants.blueBtn, onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                                  String version = packageInfo.version;
                                  signInByPhone(countryCode: "+91", appVersion:version,
                                      deviceName:_deviceData["brand"]+" "+_deviceData["device"],
                                  deviceToken: "TEsjdhsjadhaijh94378r5cf3647rtb8375cr6666r27bhtrfhrvyby5rty54646y5v4t6t",
                                    deviceType: platform,
                                    deviceVersion:_deviceData["version.sdkInt"].toString() ,
                                    mobile:ccController.text

                                  );
                                };
                                setState(() {

                                });
                                // NavigationHelpers.redirect(context, OtpScreen());
                              }, text: "Login", textColor: Colors.white,),
                              SizedBox(height: D.H / 4.3),
                            ],
                          ),
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

  Future<void> signInByPhone({ required String countryCode,
    required String mobile,
    required String deviceToken,
    required String deviceType,
    required String deviceName,
    required String appVersion,
    required String deviceVersion,

  }) async {
    // CommonUtils.showProgressDialog(context);
    // final uri = ApiEndPoint.login;
    // final headers = {'Content-Type': 'application/json'};
    // Map<String, dynamic> body = {
    //   "email": email,
    //   "password": password,
    // };
    // String jsonBody = json.encode(body);
    // final encoding = Encoding.getByName('utf-8');
    //
    // Response response = await post(
    //   uri,
    //   headers: headers,
    //   body: jsonBody,
    //   encoding: encoding,
    // );
    // int statusCode = response.statusCode;
    // String responseBody = response.body;
    // var res = jsonDecode(responseBody);
    // if (statusCode == 200 && res["success"]) {
    //   LoginModel responsee = LoginModel.fromJson(res);
    //   PreferenceUtils.putObject("LoginResponse", responsee);
    //
    //   CommonUtils.hideProgressDialog(context);
    //   CommonUtils.showGreenToastMessage("Login Successfully");
    //   NavigationHelpers.redirectto(context, ChooseYourUseScreen());
    //   // if(responsee.user!.first_time==0){
    //   //   NavigationHelpers.redirectFromSplash(context, DashBoardScreen(0));
    //   //
    //   // }else{
    //   //   NavigationHelpers.redirectto(context, ChooseYourUseScreen());
    //   // }
    //
    // } else {
    //   CommonUtils.hideProgressDialog(context);
    //   CommonUtils.showRedToastMessage("Something went wrong");
    // }
  }

}
