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
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import 'package:video_player/video_player.dart';

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


    changeRoute();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstants.primaryBlueColor,
      statusBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }





  Future changeRoute() async {
    // LoginModel? loginModel=await PreferenceUtils.getLoginObject("LoginResponse");
    // if(loginModel!=null && loginModel.token!.isNotEmpty){
    //   refressToken();
    //   await Future.delayed(Duration(milliseconds: 6500), () {
    //     NavigationHelpers.redirectFromSplash(context, DashBoardScreen(0));
    //   });
    // }else{
    //   await Future.delayed(Duration(milliseconds: 6500), () {
    //     NavigationHelpers.redirectFromSplash(context, WelcomePageMain());
    //   });
    // }

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if(prefs.getBool("isLogin")??false){
    //   await Future.delayed(Duration(milliseconds: 6500), () {
    //     NavigationHelpers.redirectFromSplash(context, DashBoardScreen(0));
    //   });
    // }else{
    //   await Future.delayed(Duration(milliseconds: 6500), () {
    //     NavigationHelpers.redirectFromSplash(context, WelcomePageMain());
    //   });
    // }
    await Future.delayed(Duration(milliseconds: 2000), () {
      NavigationHelpers.redirectFromSplash(context, LogInScreen());
    });
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