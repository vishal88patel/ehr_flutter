import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constants/color_constants.dart';

class CommonUtils {
  static bool isShowing = false;
  static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());



    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;


    } else {
      if (connectivityResult == ConnectivityResult.none) {
        CommonUtils.toastMessage("No Internet Connection");
        return false;
      } else {
        return true;
      }
    }
  }

  static toastMessage(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
    );
  }
  static void showProgressDialog(BuildContext context) {
    isShowing = true;
    showDialog(
        barrierDismissible: false,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: const Center(
                child: CircularProgressIndicator(color:  Color(0xFF222F7E)),
              ),
            ),
          );
        });
  }

  static onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(color: bordercolor,width: 2),
              color: ColorConstants.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            padding: EdgeInsets.all(20),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(color: ColorConstants.blackColor,),
                SizedBox(width : 20),
                new Text('Please wait...'),
              ],
            ),
          ),
        );
      },
    );
  }
  static hideDialog(BuildContext context){
    Navigator.pop(context);
  }

  static void hideProgressDialog(BuildContext context) {
    if (isShowing) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      isShowing = false;
    }
  }

  static void showGreenToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,);
  }
  static void showRedToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
    );
  }
}
