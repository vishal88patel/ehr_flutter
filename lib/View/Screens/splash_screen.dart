import 'dart:async';
import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/add_shedule_screen.dart';
import 'package:ehr/View/Screens/dash_board_screen.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:ehr/View/Screens/schedual_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/api_endpoint.dart';
import '../../Constants/constants.dart';
import '../../Model/body_part_response_model.dart';
import '../../Model/otp_verification_model.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import 'package:video_player/video_player.dart';

import '../../Utils/preferences.dart';
import 'login_screen.dart';
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    getBodyPartsApi();



    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstants.primaryBlueColor,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  Future<void> getBodyPartsApi() async {
    final uri = ApiEndPoint.getBodyParts;
    final headers = {'Content-Type': 'application/json',
    };

    Response response = await get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
   // changeRoute();
    var res = jsonDecode(responseBody);
    if (statusCode == 200 ) {
      List<BodyPartListResponseModel> ll=[];
      for(int i=0;i<res.length; i++){
        ll.add(BodyPartListResponseModel(bodyPartId: res[i]["bodyPartId"],bodyPart: res[i]["bodyPart"]));
      }
      Constants.BodyPartsList=ll;
      changeRoute();

    } else {
      // CommonUtils.hideProgressDialog(context);
      // CommonUtils.showRedToastMessage(res["message"]);
    }
  }





  Future changeRoute() async {
    OtpVerificationModel? loginModel=OtpVerificationModel();
    loginModel=await PreferenceUtils.getDataObject("OtpVerificationResponse");
    if(loginModel!=null && loginModel.registrationCompleted!){
      await Future.delayed(Duration(milliseconds: 1500), () {
        NavigationHelpers.redirectFromSplash(context, DashBoardScreen(1));
      });
    }else{
      await Future.delayed(Duration(milliseconds: 1500), () {
        NavigationHelpers.redirectFromSplash(context, LogInScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    D.H=MediaQuery.of(context).size.height;
    D.W=MediaQuery.of(context).size.width;
    D.S=MediaQuery.of(context).size.height*MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConstants.primaryBlueColor,
      body:Center(
        child: Container(
            height: 250,
            child: Center(child:SvgPicture.asset("assets/images/splash_logo.svg"))),
      ),
    );
  }
}