import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

class NavigationHelpers {

  static Future<dynamic> redirect(BuildContext context,Widget c) async {
    var result = Navigator.of(context).push(PageTransition(
      type: PageTransitionType.rightToLeft,duration: const Duration(milliseconds: 400), child: c,));
    return result;
  }

  static Future<dynamic> redirectFromSplash(BuildContext context,Widget c) async {
    var result = Navigator.of(context).pushAndRemoveUntil(PageTransition(
      type: PageTransitionType.rightToLeft,duration: const Duration(milliseconds: 400), child: c,),(route) => false,);
    return result;
  }
  static Future<dynamic> redirectto(BuildContext context,Widget c) async {
    var result = Navigator.of(context).pushAndRemoveUntil(PageTransition(
      type: PageTransitionType.rightToLeft,duration: const Duration(milliseconds: 400), child: c,),(route) => false,);
    return result;
  }


}