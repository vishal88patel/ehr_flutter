import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehr/Constants/api_endpoint.dart';
import 'package:ehr/View/Screens/how_data_protected_screen.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/otp_verification_model.dart';
import 'package:ehr/View/Screens/add_medication_screen.dart';
import 'package:ehr/View/Screens/lab_screen.dart';
import 'package:ehr/View/Screens/lab_list_screen.dart';
import 'package:ehr/View/Screens/medication_screen.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_downloader/image_downloader.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import 'body_detail_screen.dart';
import 'change_pass_screen.dart';
import 'comment_screen.dart';
import 'edit_profile_screen.dart';
import 'help_screen.dart';
import 'login_screen.dart';
import 'medication_detail_screen.dart';
import 'otp_screen.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ccController = TextEditingController();
  late OtpVerificationModel dataModel;
  String imageUrll = "";
  String uploadedphoto = "";
  String pickedfilepath = '';
  bool photouploaded = false;
  var bytesss;
  String isFromAnotherScreen = "0";
  var userName = "User Name";
  var pageContent = "";

  @override
  void initState() {
    getData();
    fetchHelp();

    super.initState();
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
              "Profile",
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
            Padding(
              padding: EdgeInsets.only(left: D.H / 24, right: D.H / 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: D.H / 22),
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/bg_profile.png",
                        height: D.H / 6,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: D.H / 12),
                        child: GestureDetector(
                          onTap: () {
                            _getFromGallery();
                          },
                          child: Center(
                            child: isFromAnotherScreen == "0"
                                ? Container(
                                    height: D.H / 7,
                                    width: D.H / 7,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80.0),
                                      child: CachedNetworkImage(
                                        height: 110,
                                        width: 120,
                                        fit: BoxFit.fill,
                                        imageUrl: imageUrll,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                                color: ColorConstants
                                                    .primaryBlueColor,
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator(
                                              color: ColorConstants
                                                  .primaryBlueColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : isFromAnotherScreen == "1"
                                    ? Container(
                                        height: D.H / 7,
                                        width: D.H / 7,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(80)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          child: Image.file(
                                            File(pickedfilepath),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: D.H / 7,
                                        width: D.H / 7,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(80)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80.0),
                                            child: SvgPicture.asset(
                                              "assets/images/profile_pic.svg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: D.H / 40),
                  Text(
                    userName,
                    style: GoogleFonts.inter(
                        fontSize: D.H / 40, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: D.H / 16),
                ],
              ),
            ),
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
                      Padding(
                        padding:
                            EdgeInsets.only(left: D.H / 24, right: D.H / 24),
                        child: InkWell(
                          onTap: () {
                            NavigationHelpers.redirect(
                                context, EditProfileScreen());
                          },
                          child: Container(
                            height: D.H / 12,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_edit_profile.svg",
                                  width: 15,
                                  height: 23,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Text(
                                    "Edit Profile",
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
                            // NavigationHelpers.redirect(
                            //     context, HelpScreen(pageContent));

                            NavigationHelpers.redirect(
                                context, HowDataProtectScreen(pageContent));
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
                                    "How your Data is Protected",
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
                        child: Container(
                          height: D.H / 12,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/ic_logout.svg",
                                width: 20,
                                height: 23,
                              ),
                              GestureDetector(
                                onTap: () {
                                  logout();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 11.0),
                                  child: Text(
                                    "Logout",
                                    style: GoogleFonts.inter(
                                        fontSize: D.H / 45,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
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
                        child: Container(
                          height: D.H / 12,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/ic_delete.svg",
                                width: 20,
                                height: 23,
                                color: ColorConstants.skyBlue,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // deleteAccount();
                                  showAlertDialog(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 11.0),
                                  child: Text(
                                    "Delete Account",
                                    style: GoogleFonts.inter(
                                        fontSize: D.H / 45,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
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


  logout() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.logout;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    Response response = await get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressDialog(context);
      PreferenceUtils.clear();
      CommonUtils.showGreenToastMessage("logout successfully");
      NavigationHelpers.redirectto(context, LogInScreen());
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage("error");
    }
  }

  deleteAccount() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.delete_account;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };


    Response response = await delete(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      CommonUtils.hideProgressDialog(context);
      PreferenceUtils.clear();
      CommonUtils.showGreenToastMessage("Account Deleted Successfully");
      NavigationHelpers.redirectto(context, LogInScreen());
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage("error");
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        photouploaded = true;
        uploadedphoto = pickedFile.path;
        pickedfilepath = pickedFile.path;
        multipartProdecudre();
      });
    }
  }

  getData() async {
    final uri = ApiEndPoint.getProfile;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    print(await PreferenceUtils.getString("ACCESSTOKEN"));
    Response response = await get(
      uri,
      headers: headers,
    );
    dataModel = OtpVerificationModel.fromJson(jsonDecode(response.body));
    userName = dataModel.firstName! + " " + dataModel.lastName.toString();
    if (dataModel.profilePicture!.isEmpty) {
      imageUrll =
          "https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255532-stock-illustration-profile-placeholder-male-default-profile.jpg";
    } else {
      imageUrll = dataModel.profilePicture!;
    }
    setState(() {});
    //
    // if(dataModel!=null){
    //   imageUrl=dataModel.profilePicture!;
    //   try {
    //     var imageId = await ImageDownloader.downloadImage(dataModel.profilePicture.toString());
    //     if (imageId == null) {
    //       return;
    //     }
    //      imageUrll = (await ImageDownloader.findPath(imageId))!;
    //     setState(() {
    //
    //     });
    //   } on PlatformException catch (error) {
    //     print(error);
    //   }
  }

  fetchHelp() async {
    final uri = ApiEndPoint.getHelp;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    Response response = await get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      pageContent = res["pageContent"];
    } else {}
  }

  multipartProdecudre() async {
    CommonUtils.showProgressDialog(context);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    //for multipartrequest
    var request = http.MultipartRequest('POST', ApiEndPoint.uploadPhoto);

    //for token
    request.headers.addAll(headers);

    //for image and videos and files

    request.files.add(
        await http.MultipartFile.fromPath("profilePicture", pickedfilepath));

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage(responseData["message"]);
      isFromAnotherScreen = "1";
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);
    }
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.pop(context);
        deleteAccount();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure You want to delete this account"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
