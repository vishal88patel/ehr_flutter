import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Constants/color_constants.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import 'help_screen.dart';

class WebviewScreen extends StatefulWidget {
  String url;
  String appBarText;
  WebviewScreen({required this.url, required this.appBarText});

  @override
  State<WebviewScreen> createState() => _HowDataProtectScreenState();
}

class _HowDataProtectScreenState extends State<WebviewScreen> {

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
            SizedBox(
              height: 10,
            ),
            Text(
              widget.appBarText,
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      backgroundColor: ColorConstants.innerColor,
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
