import 'package:ehr/Constants/api_endpoint.dart';
import 'package:ehr/View/Screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/color_constants.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';

class HowDataProtectScreen extends StatefulWidget {
  String pageContent;

  HowDataProtectScreen(this.pageContent, {Key? key}) : super(key: key);

  @override
  State<HowDataProtectScreen> createState() => _HowDataProtectScreenState();
}

class _HowDataProtectScreenState extends State<HowDataProtectScreen> {
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
            SizedBox(
              height: 10,
            ),
            Text(
              "How your Data is Protected",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      backgroundColor: ColorConstants.innerColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48)),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(left: D.H / 24,right: D.H / 24),
                      //   child: InkWell(
                      //     onTap: (){
                      //       NavigationHelpers.redirect(context, ChangePasswordScreen());
                      //     },
                      //     child: Container(
                      //       height: D.H/12,
                      //       child: Row(
                      //         children: [
                      //           SvgPicture.asset(
                      //             "assets/images/ic_change_pass.svg", width: 20,height: 23,
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.only(left: 14.0),
                      //             child: Text(
                      //               "Change Password",
                      //               style: GoogleFonts.inter(
                      //                   fontSize: D.H / 45, fontWeight: FontWeight.w500),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: D.H / 28,right: D.H / 28),
                      //   child: Container(
                      //     height: 2,
                      //     color: ColorConstants.lineColor,
                      //   ),
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: D.H / 24, right: D.H / 24),
                        child: InkWell(
                          onTap: () {
                            NavigationHelpers.redirect(
                                context,
                                WebviewScreen(
                                  appBarText: "Terms and Conditions",
                                  url: ApiEndPoint.termConditionWebUrl
                                      .toString(),
                                ));

                            // NavigationHelpers.redirect(
                            //     context, HelpScreen(pageContent));
                          },
                          child: Container(
                            height: D.H / 12,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_help.svg",
                                  width: 20,
                                  height: 23,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Terms and Conditions",
                                    style: GoogleFonts.inter(
                                        fontSize: D.H / 45,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: D.H / 28, right: D.H / 28),
                        child: Container(
                          height: 2,
                          color: ColorConstants.lineColor,
                        ),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(left: D.H / 24, right: D.H / 24),
                        child: InkWell(
                          onTap: () {
                            NavigationHelpers.redirect(
                                context,
                                WebviewScreen(
                                  appBarText: "Privacy Policy",
                                  url: ApiEndPoint.privacyPolicyWebUrl
                                      .toString(),
                                ));
                          },
                          child: Container(
                            height: D.H / 12,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_help.svg",
                                  width: 20,
                                  height: 23,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Privacy Policy",
                                    style: GoogleFonts.inter(
                                        fontSize: D.H / 45,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: D.H / 28, right: D.H / 28),
                        child: Container(
                          height: 2,
                          color: ColorConstants.lineColor,
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
