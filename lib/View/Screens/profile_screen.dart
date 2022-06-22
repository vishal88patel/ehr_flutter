import 'dart:io';
import 'package:ehr/Constants/api_endpoint.dart';
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
  String imageUrl="";
   String uploadedphoto = "";
  String pickedfilepath = '';
  bool photouploaded = false;

  @override
  void initState() {
    getData();
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
            SizedBox(height: 10,),
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
              padding: EdgeInsets.only(left:D.H / 24,right: D.H / 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: D.H / 22),
                  Stack(
                    children: [
                      Image.asset("assets/images/bg_profile.png",height: D.H/6,fit: BoxFit.fill,),
                      Padding(
                        padding:  EdgeInsets.only(top: D.H/12),
                        child: GestureDetector(
                          onTap: (){
                            _getFromGallery();
                          },
                          child: Center(
                            child: uploadedphoto!=null?Container(
                              height: D.H/7,
                              width: D.H/7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius: BorderRadius.circular(80)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80.0),
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ):Container(
                              height: D.H/7,
                              width: D.H/7,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(80)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80.0),
                                  child: Image.asset(
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
                    "Mark Peterson",
                    style: GoogleFonts.inter(
                        fontSize: D.H / 40, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: D.H / 16),
                ],
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal:0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48)),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 24,right: D.H / 24),
                        child: InkWell(
                          onTap: (){
                            NavigationHelpers.redirect(context, EditProfileScreen());
                          },
                          child: Container(
                            height: D.H/12,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_edit_profile.svg",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "Edit Profile",
                                    style: GoogleFonts.inter(
                                        fontSize: D.H / 45, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 28,right: D.H / 28),
                        child: Container(
                          height: 2,
                          color: ColorConstants.lineColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 24,right: D.H / 24),
                        child: InkWell(
                          onTap: (){
                            NavigationHelpers.redirect(context, ChangePasswordScreen());
                          },
                          child: Container(
                            height: D.H/12,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_change_pass.svg",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "Change Password",
                                    style: GoogleFonts.inter(
                                        fontSize: D.H / 45, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 28,right: D.H / 28),
                        child: Container(
                          height: 2,
                          color: ColorConstants.lineColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 24,right: D.H / 24),
                        child: InkWell(
                          onTap: (){
                            NavigationHelpers.redirect(context, HelpScreen());
                          },
                          child: Container(
                            height: D.H/12,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_help.svg",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "Help",
                                    style: GoogleFonts.inter(
                                        fontSize: D.H / 45, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 28,right: D.H / 28),
                        child: Container(
                          height: 2,
                          color: ColorConstants.lineColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: D.H / 24,right: D.H / 24),
                        child: Container(
                          height: D.H/12,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/ic_logout.svg",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  "Logout",
                                  style: GoogleFonts.inter(
                                      fontSize: D.H / 45, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
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
        uploadedphoto =  pickedFile.path;
        pickedfilepath = pickedFile.path;
        if(pickedfilepath!=null){
          multipartProdecudre();
        }
      });
    }
  }


  getData() async {
    dataModel = (await PreferenceUtils.getDataObject('OtpVerificationResponse'))!;

    if(dataModel!=null){
      imageUrl=dataModel.profilePicture!;
    }else{

    }
    setState(() {

    });
  }

  multipartProdecudre() async {
    CommonUtils.showProgressDialog(context);
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    //for multipartrequest
    var request = http.MultipartRequest('POST', ApiEndPoint.uploadPhoto);

    //for token
    request.headers.addAll(headers);

    //for image and videos and files

    request.files.add(await http.MultipartFile.fromPath("profilePicture", pickedfilepath));

    var response =await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);


    if (response.statusCode==200) {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage(responseData["message"]);
      setState(() {

      });

    }
    else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);

    }
  }


}
