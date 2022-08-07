import 'dart:convert';

import 'package:ehr/View/Screens/schedual_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Constants/color_constants.dart';
import 'body_screen.dart';
import 'lab_screen.dart';


class DashBoardScreen extends StatefulWidget {
  int? _currentIndex = 0;
  int? savePrevIndex;


  DashBoardScreen(_currentIndex) {
    this._currentIndex = _currentIndex;
  }

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //
  final List<Widget> _children = [
    LabScreen(),
    BodyScreen(),
    // BodyScreenForTest(),
    SchedualScreen(),
  ];

  @override
  void initState() {
    //

    super.initState();
  }


  // getprefrences() async {
  //   loginModel = (await PreferenceUtils.getLoginObject('LoginResponse'))!;
  //
  //   if(loginModel!=null){
  //     userName=loginModel.user!.firstName??"Adom Shafi";
  //     UserEmail=loginModel.user!.email??"hellobesnik@gmail.com";
  //   }else{
  //
  //   }
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _children[widget._currentIndex!],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        selectedLabelStyle: TextStyle(fontSize: 1),
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorConstants.whiteColor,
          currentIndex: widget._currentIndex!,
          onTap: (value) {
            print(value);
            setState(() {
              widget.savePrevIndex = widget._currentIndex;
              widget._currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/bn_lab_logo_unselected.svg',
                height: 25,
                width: 25,
              ),
              activeIcon:  SvgPicture.asset(
                'assets/images/bn_lab_logo_selected.svg',
                height: 30,
                width: 30,
              ),
              label: "",

            ),
            BottomNavigationBarItem(
              icon:  SvgPicture.asset(
                'assets/images/bn_body_logo_unselected.svg',
                height: 25,
                width: 25,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/bn_body_logo_selected.svg',
                height: 30,
                width: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon:  SvgPicture.asset(
                  'assets/images/bn_calender_logo_unselected.svg',
                  height: 25,
                  width: 25,
                ),
                activeIcon:  SvgPicture.asset(
                  'assets/images/bn_calender_logo_selected.svg',
                  height: 30,
                  width: 30,
                ),
              label: "",

            ),
          ]),
    );
  }

  // Future<void> logout() async {
  //   CommonUtils.showProgressDialog(context);
  //   final token = loginModel.token;
  //   final uri = ApiEndPoint.logout;
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': "Bearer" + " " + token!
  //   };
  //
  //   Response response = await get(
  //     uri,
  //     headers: headers,
  //   );
  //   int statusCode = response.statusCode;
  //   String responseBody = response.body;
  //   var res = jsonDecode(responseBody);
  //   if (statusCode == 200) {
  //     AuthClass().signOut(context);
  //     CommonUtils.hideProgressDialog(context);
  //     Fluttertoast.showToast(msg: "${res['message']}");
  //     PreferenceUtils.clear();
  //     NavigationHelpers.redirectto(context, AuthScreen());
  //     print(res);
  //   } else {
  //     print(res);
  //     Fluttertoast.showToast(
  //         msg: "${res['message']}", toastLength: Toast.LENGTH_LONG);
  //   }
  // }
}
