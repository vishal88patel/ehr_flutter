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
    SchedualScreen(),
  ];

  @override
  void initState() {
    //

    super.initState();
  }




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

}
