import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehr/Model/testResultType_model.dart';
import 'package:ehr/View/Screens/comment_screen.dart';
import 'package:ehr/View/Screens/login_screen.dart';
import 'package:ehr/View/Screens/medication_screen.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Constants/api_endpoint.dart';
import '../../Constants/color_constants.dart';
import '../../CustomWidgets/chart_widget.dart';
import '../../CustomWidgets/custom_search_bar.dart';
import '../../CustomWidgets/custom_search_bar2.dart';
import '../../Model/imageType_model.dart';
import '../../Model/lab_screen_response_model.dart';
import '../../Model/otp_verification_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_white_textform_field.dart';
import 'add_medication_screen.dart';

class LabScreen extends StatefulWidget {
  @override
  _LabScreenState createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late TabController _tabController;
  var _selectedFood = "after";
  String? _choosenCommentValue;
  String? _choosenLabValue;
  String? _choosenimageValue;
  final commentController = TextEditingController();
  final valueController = TextEditingController();
  final discController = TextEditingController();
  var imageId = 0;
  var testTypeId = 0;
  List<ImageTypeModel> imageTypesData = [];
  List<TestResultData> testResultTypesData = [];
  String pickedfilepath1 = '';
  String pickedfilepath2 = '';
  String pickedfilepath3 = '';
  LabScreenResponseModel _labScreenResponseModelodel = LabScreenResponseModel();
  OtpVerificationModel? getUserName = OtpVerificationModel();
  List<String> selectedImagesList = [];

  List<TestResults> hemoglobinList = [];
  List<TestResults> bloodPressureList = [];
  List<TestResults> heartRateList = [];

  List<Widget> tabList = [];
  List<Widget> tabbodyList = [];
  int tabItemCount = 0;

  @override
  void initState() {
    getTestResultTypes();
    getImagineTypes();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getLabScreenApi();
    });
    super.initState();
  }

  Future<void> getLabScreenApi() async {
    getUserName =
        await PreferenceUtils.getDataObject("OtpVerificationResponse");

    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getDashboard;
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
      _labScreenResponseModelodel = LabScreenResponseModel.fromJson(res);
      bloodPressureList.clear();
      hemoglobinList.clear();
      heartRateList.clear();
      for (int i = 0;
          i < _labScreenResponseModelodel.testResults!.length;
          i++) {
        if (_labScreenResponseModelodel.testResults![i].testResultName ==
            "Blood Pressure") {
          bloodPressureList.add(_labScreenResponseModelodel.testResults![i]);
        } else if (_labScreenResponseModelodel.testResults![i].testResultName ==
            "Hemoglobin") {
          hemoglobinList.add(_labScreenResponseModelodel.testResults![i]);
        } else if (_labScreenResponseModelodel.testResults![i].testResultName ==
            "Heart Rate") {
          heartRateList.add(_labScreenResponseModelodel.testResults![i]);
        }
      }
      if (hemoglobinList.isNotEmpty) {
        tabList.add(Container(
          height: 45,
          child: Center(
            child: Text(
              "Hemoglobin",
              style: GoogleFonts.heebo(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ));
        tabbodyList.add(GraphWidget(
          graphList: hemoglobinList,
        ));
      }
      ;
      if (bloodPressureList.isNotEmpty) {
        tabList.add(Container(
          height: 45,
          child: Center(
            child: Text(
              "Blood Pressure",
              textAlign: TextAlign.center,
              style: GoogleFonts.heebo(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ));
        tabbodyList.add(GraphWidget(
          graphList: bloodPressureList,
        ));
      }
      ;
      if (heartRateList.isNotEmpty) {
        tabList.add(Container(
          height: 45,
          child: Center(
            child: Text(
              "Heart Rate",
              style: GoogleFonts.heebo(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ));
        tabbodyList.add(GraphWidget(
          graphList: heartRateList,
        ));
      }
      ;

      tabItemCount = tabList.length;
      _tabController = new TabController(length: tabItemCount, vsync: this);

      CommonUtils.hideProgressDialog(context);
      setState(() {});
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("Data Fetched Successfully");
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> getLabScreenApiWithoutLoader() async {
    getUserName =
        await PreferenceUtils.getDataObject("OtpVerificationResponse");

    final uri = ApiEndPoint.getDashboard;
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
      _labScreenResponseModelodel = LabScreenResponseModel.fromJson(res);
      bloodPressureList.clear();
      hemoglobinList.clear();
      heartRateList.clear();
      tabbodyList.clear();
      tabList.clear();
      for (int i = 0;
      i < _labScreenResponseModelodel.testResults!.length;
      i++) {
        if (_labScreenResponseModelodel.testResults![i].testResultName ==
            "Blood Pressure") {
          bloodPressureList.add(_labScreenResponseModelodel.testResults![i]);
        } else if (_labScreenResponseModelodel.testResults![i].testResultName ==
            "Hemoglobin") {
          hemoglobinList.add(_labScreenResponseModelodel.testResults![i]);
        } else if (_labScreenResponseModelodel.testResults![i].testResultName ==
            "Heart Rate") {
          heartRateList.add(_labScreenResponseModelodel.testResults![i]);
        }
      }
      if (hemoglobinList.isNotEmpty) {
        tabList.add(Container(
          height: 45,
          child: Center(
            child: Text(
              "Hemoglobin",
              style: GoogleFonts.heebo(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ));
        tabbodyList.add(GraphWidget(
          graphList: hemoglobinList,
        ));
      }
      ;
      if (bloodPressureList.isNotEmpty) {
        tabList.add(Container(
          height: 45,
          child: Center(
            child: Text(
              "Blood Pressure",
              textAlign: TextAlign.center,
              style: GoogleFonts.heebo(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ));
        tabbodyList.add(GraphWidget(
          graphList: bloodPressureList,
        ));
      }
      ;
      if (heartRateList.isNotEmpty) {
        tabList.add(Container(
          height: 45,
          child: Center(
            child: Text(
              "Heart Rate",
              style: GoogleFonts.heebo(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ));
        tabbodyList.add(GraphWidget(
          graphList: heartRateList,
        ));
      }
      ;

      tabItemCount = tabList.length;
      _tabController = new TabController(length: tabItemCount, vsync: this);

      CommonUtils.showGreenToastMessage("Result Saved");
      CommonUtils.hideProgressDialog(context);

      Navigator.pop(context);
      setState(() {});
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryBlueColor,
          elevation: 0,
          toolbarHeight: 45,
          centerTitle: true,
          title: Text(
            "James Smith",
            style: GoogleFonts.heebo(
                fontSize: D.H / 44, fontWeight: FontWeight.w500),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                NavigationHelpers.redirect(context, ProfileScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  "assets/images/avatar.svg",
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            Container(
              width: 5,
            )
          ],
        ),
        body: _labScreenResponseModelodel.pains != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CUstomSearchBar(
                                function: () {},
                                controller: controller,
                                readOnly: false,
                                hint: "Search..",
                                validators: (e) {},
                                keyboardTYPE: TextInputType.name),
                          ),
                          Expanded(
                            child: CUstomSearchBar2(
                                function: () {},
                                controller: controller,
                                readOnly: false,
                                hint: "Type",
                                validators: (e) {},
                                keyboardTYPE: TextInputType.name),
                          ),
                        ],
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                            right: D.W / 26,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: D.W / 30.0, left: D.W / 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "Comments",
                                        style: GoogleFonts.heebo(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(18),
                                                ),
                                              ),
                                              content: Container(
                                                width: D.W / 1.25,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: D.W / 40,
                                                          right: D.W / 40),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              size: D.W / 20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Add Comment",
                                                          style:
                                                              GoogleFonts.heebo(
                                                                  fontSize:
                                                                      D.H / 38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: D.H / 40),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Text(
                                                        "Body Parts",
                                                        style:
                                                            GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 120),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: D.W / 30,
                                                                right:
                                                                    D.W / 60),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color:
                                                                    ColorConstants
                                                                        .border),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          focusColor:
                                                              Colors.white,
                                                          value:
                                                              _choosenCommentValue,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          iconEnabledColor:
                                                              ColorConstants
                                                                  .lightGrey,
                                                          icon: Icon(Icons
                                                              .arrow_drop_down_sharp),
                                                          iconSize: 32,
                                                          underline: Container(
                                                              color: Colors
                                                                  .transparent),
                                                          items: <String>[
                                                            'Abc',
                                                            'Bcd',
                                                            'Cde',
                                                            'Def',
                                                            'Efg',
                                                            'Fgh',
                                                            'Ghi',
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          hint: Text(
                                                            "Type",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    D.H / 48,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              _choosenCommentValue =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Text(
                                                        "Comments",
                                                        style:
                                                            GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 120),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child:
                                                          CustomWhiteTextFormField(
                                                        controller:
                                                            commentController,
                                                        readOnly: false,
                                                        maxline: 3,
                                                        validators: (e) {
                                                          if (commentController
                                                                      .text ==
                                                                  null ||
                                                              commentController
                                                                      .text ==
                                                                  '') {
                                                            return '*Comments';
                                                          }
                                                        },
                                                        keyboardTYPE:
                                                            TextInputType.text,
                                                        obscured: false,
                                                        maxlength: 3,
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Container(
                                                      height: 1,
                                                      color:
                                                          ColorConstants.line,
                                                    ),
                                                    SizedBox(height: D.H / 80),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "OK",
                                                          style: GoogleFonts.heebo(
                                                              fontSize:
                                                                  D.H / 33,
                                                              color:
                                                                  ColorConstants
                                                                      .skyBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: D.H / 80),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: SvgPicture.asset(
                                            "assets/images/ic_add_plus.svg"))
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: _labScreenResponseModelodel
                                                  .pains!.length >=
                                              3
                                          ? 3
                                          : _labScreenResponseModelodel
                                              .pains!.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: D.W / 40.0,
                                                      top: D.H / 80),
                                                  child: Row(
                                                    children: [
                                                      Card(
                                                          color: ColorConstants
                                                              .bgImage,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(8),
                                                              topRight: Radius
                                                                  .circular(8),
                                                              bottomLeft: Radius
                                                                  .circular(8),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                          elevation: 0,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    D.W / 50),
                                                            child: SvgPicture.asset(
                                                                "assets/images/ic_message.svg"),
                                                          )),
                                                      SizedBox(width: D.H / 80),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _labScreenResponseModelodel
                                                                .pains![index]
                                                                .bodyPart
                                                                .toString(),
                                                            style: GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Text(
                                                            _labScreenResponseModelodel
                                                                .pains![index]
                                                                .description
                                                                .toString(),
                                                            style: GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: D.H / 80,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0,
                                                          right: 4.0),
                                                  child: Container(
                                                    height: 1.0,
                                                    color: ColorConstants
                                                        .lineColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: TextButton(
                                          onPressed: () {
                                            NavigationHelpers.redirect(
                                                context, CommentScreen());
                                          },
                                          child: Text(
                                            "See more",
                                            style: GoogleFonts.heebo(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstants.skyBlue),
                                          ))),
                                  SizedBox(
                                    height: D.H / 40,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                            right: D.W / 26,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: D.W / 30.0, left: D.W / 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "Medications",
                                        style: GoogleFonts.heebo(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          NavigationHelpers.redirect(
                                              context, AddMedicationScreen());
                                        },
                                        child: SvgPicture.asset(
                                            "assets/images/ic_add_plus.svg"))
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ListView.builder(
                                      itemCount: _labScreenResponseModelodel
                                                  .medications!.length >=
                                              3
                                          ? 3
                                          : _labScreenResponseModelodel
                                              .medications!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var millis = _labScreenResponseModelodel
                                            .medications![index].created;
                                        var dt =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                millis!);
                                        var d24 = DateFormat('dd/MM/yyyy')
                                            .format(dt); // 31/12/2000, 22:00

                                        var userName =
                                            getUserName!.firstName.toString();
                                        var date = d24.toString();
                                        return Container(
                                          padding: EdgeInsets.only(
                                              left: D.W / 40.0, top: D.H / 80),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Card(
                                                        color: ColorConstants
                                                            .bgImage,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                        ),
                                                        elevation: 0,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  D.W / 60),
                                                          child: SvgPicture.asset(
                                                              "assets/images/ic_bowl.svg"),
                                                        )),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.H / 100),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                _labScreenResponseModelodel
                                                                    .medications![
                                                                        index]
                                                                    .medicationName
                                                                    .toString(),
                                                                style: GoogleFonts.heebo(
                                                                    fontSize:
                                                                        D.H /
                                                                            52,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              SizedBox(
                                                                width: 90,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        D.W /
                                                                            30,
                                                                    width: D.W /
                                                                        30,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                25)),
                                                                        color: ColorConstants
                                                                            .lightRed),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    "Lorem Dummy",
                                                                    style: GoogleFonts.heebo(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.3)),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Hill ${_labScreenResponseModelodel.medications![index].dosage! + " " + "${_labScreenResponseModelodel.medications![index].dosageType! + " "}" + "${_labScreenResponseModelodel.medications![index].frequencyType}"}",
                                                                // "Hil 250 mg 2/Day",
                                                                style: GoogleFonts.heebo(
                                                                    color: ColorConstants
                                                                        .blueBtn,
                                                                    fontSize:
                                                                        D.H /
                                                                            66,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                date.toString(),
                                                                style: GoogleFonts.heebo(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3)),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  "assets/images/ic_doctor.svg"),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            2.0,
                                                                        top:
                                                                            2.0),
                                                                child: Text(
                                                                  userName
                                                                      .toString(),
                                                                  style: GoogleFonts.heebo(
                                                                      color: ColorConstants
                                                                          .darkText,
                                                                      fontSize:
                                                                          D.H /
                                                                              66,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: D.H / 80,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0,
                                                          right: 4.0),
                                                  child: Container(
                                                    height: 1.0,
                                                    color: ColorConstants
                                                        .lineColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: TextButton(
                                          onPressed: () {
                                            NavigationHelpers.redirect(
                                                context, MedicationScreen());
                                          },
                                          child: Text(
                                            "See more",
                                            style: GoogleFonts.heebo(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstants.skyBlue),
                                          ))),
                                  SizedBox(
                                    height: D.H / 40,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: D.W / 30.0,
                                  left: D.W / 30.0,
                                  right: D.W / 26),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "Labs",
                                      style: GoogleFonts.heebo(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        valueController.text="";
                                        _choosenLabValue=testResultTypesData[0].testType;
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              StatefulBuilder(
                                            builder: (BuildContext context,
                                                    void Function(
                                                            void Function())
                                                        setState) =>
                                                AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(18),
                                                ),
                                              ),
                                              content: Container(
                                                width: D.W / 1.25,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: D.W / 40,
                                                          right: D.W / 40),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              size: D.W / 20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Add Test results",
                                                          style:
                                                              GoogleFonts.heebo(
                                                                  fontSize:
                                                                      D.H / 38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Container(
                                                      height: 1,
                                                      color:
                                                          ColorConstants.line,
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Text(
                                                        "Type",
                                                        style:
                                                            GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 240),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: D.W / 30,
                                                                right:
                                                                    D.W / 60),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color:
                                                                    ColorConstants
                                                                        .border),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          focusColor:
                                                              Colors.black,
                                                          value:
                                                              _choosenLabValue,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          iconEnabledColor:
                                                              ColorConstants
                                                                  .lightGrey,
                                                          icon: Icon(Icons
                                                              .arrow_drop_down_sharp),
                                                          iconSize: 32,
                                                          underline: Container(
                                                              color: Colors
                                                                  .transparent),
                                                          items:
                                                              testResultTypesData
                                                                  .map((items) {
                                                            return DropdownMenuItem(
                                                              value: items
                                                                  .testType,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  items.testType
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.0),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          hint: Text(
                                                            "Type",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    D.H / 48,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              _choosenLabValue =
                                                                  value;
                                                              for (int i = 0;
                                                                  i <
                                                                      testResultTypesData
                                                                          .length;
                                                                  i++) {
                                                                if (testResultTypesData[
                                                                            i]
                                                                        .testType ==
                                                                    _choosenLabValue) {
                                                                  testTypeId =
                                                                      testResultTypesData[
                                                                              i]
                                                                          .testTypeId!;
                                                                  print("dropdownvalueId:" +
                                                                      testTypeId
                                                                          .toString());
                                                                }
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Text(
                                                        "Value",
                                                        style:
                                                            GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 240),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child:
                                                          CustomWhiteTextFormField(
                                                        controller:
                                                            valueController,
                                                        readOnly: false,
                                                        validators: (e) {
                                                          if (valueController
                                                                      .text ==
                                                                  null ||
                                                              valueController
                                                                      .text ==
                                                                  '') {
                                                            return '*Value';
                                                          }
                                                        },
                                                        keyboardTYPE:
                                                            TextInputType.text,
                                                        obscured: false,
                                                        maxlength: 100,
                                                        maxline: 1,
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 40),
                                                    Container(
                                                      height: 1,
                                                      color:
                                                          ColorConstants.line,
                                                    ),
                                                    SizedBox(height: D.H / 80),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (_choosenLabValue!
                                                                .isEmpty) {
                                                              CommonUtils
                                                                  .showRedToastMessage(
                                                                      "Please Select Type");
                                                            } else if (valueController
                                                                .text.isEmpty) {
                                                              CommonUtils
                                                                  .showRedToastMessage(
                                                                      "Please add Value");
                                                            } else {
                                                              saveTestResult();
                                                            }
                                                          },
                                                          child: Text(
                                                            "OK",
                                                            style: GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 33,
                                                                color:
                                                                    ColorConstants
                                                                        .skyBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: D.H / 80),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/ic_add_plus.svg"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: D.H / 180,
                            ),
                            SizedBox(
                              height: 48,
                              child: AppBar(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                bottom: TabBar(
                                  indicatorColor:
                                      ColorConstants.primaryBlueColor,
                                  controller: _tabController,
                                  // tabs: [
                                  //   hemoglobinList.isNotEmpty?Tab(
                                  //     child: Text(
                                  //       "Hemoglobin",
                                  //       style: GoogleFonts.heebo(
                                  //           fontSize: 12,
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.normal),
                                  //     ),
                                  //   ):Container(),
                                  //   bloodPressureList.isNotEmpty?Tab(
                                  //     child: Text(
                                  //       "Blood Pressure",
                                  //       style: GoogleFonts.heebo(
                                  //           fontSize: 12,
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.normal),
                                  //     ),
                                  //   ):Container(),
                                  //   heartRateList.isNotEmpty?Tab(
                                  //     child: Text(
                                  //       "Heart Rate",
                                  //       style: GoogleFonts.heebo(
                                  //           fontSize: 12,
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.normal),
                                  //     ),
                                  //   ):Container(),
                                  // ],
                                  tabs: tabList,
                                ),
                              ),
                            ),
                            Container(
                              height: 300,
                              child: TabBarView(
                                controller: _tabController,
                                children: tabbodyList,
                                // children: [
                                //   // first tab bar view widget
                                //   Container(),
                                //   GraphWidget(),
                                //   // second tab bar viiew widget
                                //   Container(),
                                // ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: D.W / 30.0,
                                  left: D.W / 30.0,
                                  right: D.W / 26),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Imaging",
                                    style: GoogleFonts.heebo(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        selectedImagesList.clear();
                                        discController.text = "";
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              StatefulBuilder(
                                            builder: (BuildContext context,
                                                    void Function(
                                                            void Function())
                                                        State) =>
                                                AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(18),
                                                ),
                                              ),
                                              content: Container(
                                                width: D.W / 1.25,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: D.W / 40,
                                                          right: D.W / 40),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              size: D.W / 20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Imaging",
                                                          style:
                                                              GoogleFonts.heebo(
                                                                  fontSize:
                                                                      D.H / 38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Container(
                                                      height: 1,
                                                      color:
                                                          ColorConstants.line,
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          PickedFile?
                                                              pickedFile =
                                                              await ImagePicker()
                                                                  .getImage(
                                                            source: ImageSource
                                                                .gallery,
                                                            maxWidth: 1800,
                                                            maxHeight: 1800,
                                                          );
                                                          if (pickedFile !=
                                                              null) {
                                                            State(() {
                                                              var path =
                                                                  pickedFile
                                                                      .path;
                                                              selectedImagesList
                                                                  .add(path);
                                                            });
                                                          }
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Card(
                                                                color:
                                                                    ColorConstants
                                                                        .bgImage,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            8),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            8),
                                                                  ),
                                                                ),
                                                                elevation: 0,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: D.W /
                                                                          50,
                                                                      right:
                                                                          D.W /
                                                                              70,
                                                                      top: D.W /
                                                                          50,
                                                                      bottom:
                                                                          D.W /
                                                                              50),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                          "assets/images/ic_upload_image.svg"),
                                                                )),
                                                            SizedBox(
                                                                width:
                                                                    D.H / 80),
                                                            Text(
                                                              "Upload Image",
                                                              style: GoogleFonts.heebo(
                                                                  fontSize:
                                                                      D.H / 38,
                                                                  color: ColorConstants
                                                                      .skyBlue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      height: 60,
                                                      width: D.W / 1.25,
                                                      child: ListView.builder(
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            selectedImagesList
                                                                    .length +
                                                                1,
                                                        itemBuilder: (context,
                                                            position) {
                                                          if (position ==
                                                              selectedImagesList
                                                                  .length) {
                                                            return InkWell(
                                                              onTap: () async {
                                                                PickedFile?
                                                                    pickedFile =
                                                                    await ImagePicker()
                                                                        .getImage(
                                                                  source:
                                                                      ImageSource
                                                                          .gallery,
                                                                  maxWidth:
                                                                      1800,
                                                                  maxHeight:
                                                                      1800,
                                                                );
                                                                if (pickedFile !=
                                                                    null) {
                                                                  State(() {
                                                                    var path =
                                                                        pickedFile
                                                                            .path;
                                                                    selectedImagesList
                                                                        .add(
                                                                            path);
                                                                  });
                                                                }
                                                              },
                                                              child: Stack(
                                                                clipBehavior:
                                                                    Clip.none,
                                                                children: [
                                                                  Card(
                                                                      margin: EdgeInsets
                                                                          .zero,
                                                                      color: ColorConstants
                                                                          .bgImage,
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      elevation:
                                                                          0,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            65,
                                                                        width:
                                                                            38,
                                                                        margin:
                                                                            EdgeInsets.all(12),
                                                                        child: SvgPicture.asset(
                                                                            "assets/images/ic_gallary.svg"),
                                                                      )),
                                                                  Positioned(
                                                                      right: -5,
                                                                      top: -5,
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          child: Container(
                                                                              color: ColorConstants.skyBlue,
                                                                              child: const Icon(
                                                                                Icons.close,
                                                                                size: 20,
                                                                                color: Colors.white,
                                                                              ))))
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        12.0),
                                                            child: Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  child: Image
                                                                      .file(
                                                                    File(selectedImagesList[
                                                                        position]),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: 55,
                                                                    height: 60,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    right: -5,
                                                                    top: -5,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        selectedImagesList
                                                                            .removeAt(position);
                                                                        State(
                                                                            () {});
                                                                      },
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                          child: Container(
                                                                              color: ColorConstants.skyBlue,
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                size: 20,
                                                                                color: Colors.white,
                                                                              ))),
                                                                    ))
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(
                                                    //       left: D.W / 18,
                                                    //       right: D.W / 18),
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Stack(
                                                    //         children: [
                                                    //           Card(
                                                    //               color: ColorConstants
                                                    //                   .bgImage,
                                                    //               shape:
                                                    //                   const RoundedRectangleBorder(
                                                    //                 borderRadius:
                                                    //                     BorderRadius
                                                    //                         .only(
                                                    //                   topLeft: Radius
                                                    //                       .circular(8),
                                                    //                   topRight: Radius
                                                    //                       .circular(8),
                                                    //                   bottomLeft: Radius
                                                    //                       .circular(8),
                                                    //                   bottomRight:
                                                    //                       Radius
                                                    //                           .circular(
                                                    //                               8),
                                                    //                 ),
                                                    //               ),
                                                    //               elevation: 0,
                                                    //               child: Padding(
                                                    //                 padding:
                                                    //                     EdgeInsets.only(
                                                    //                         left: D.W /
                                                    //                             34,
                                                    //                         right: D.W /
                                                    //                             34,
                                                    //                         top: D.W /
                                                    //                             34,
                                                    //                         bottom:
                                                    //                             D.W /
                                                    //                                 34),
                                                    //                 child: SvgPicture.asset(
                                                    //                     "assets/images/ic_gallary.svg"),
                                                    //               )),
                                                    //           Positioned(
                                                    //               right: 0,
                                                    //               child: ClipRRect(
                                                    //                   borderRadius:
                                                    //                       BorderRadius
                                                    //                           .circular(
                                                    //                               20),
                                                    //                   child: Container(
                                                    //                       color: ColorConstants
                                                    //                           .skyBlue,
                                                    //                       child: Icon(
                                                    //                         Icons.close,
                                                    //                         size: 20,
                                                    //                         color: Colors
                                                    //                             .white,
                                                    //                       ))))
                                                    //         ],
                                                    //       ),
                                                    //       SizedBox(
                                                    //         width: D.W / 30,
                                                    //       ),
                                                    //       Stack(
                                                    //         children: [
                                                    //           Card(
                                                    //               color: ColorConstants
                                                    //                   .bgImage,
                                                    //               shape:
                                                    //                   const RoundedRectangleBorder(
                                                    //                 borderRadius:
                                                    //                     BorderRadius
                                                    //                         .only(
                                                    //                   topLeft: Radius
                                                    //                       .circular(8),
                                                    //                   topRight: Radius
                                                    //                       .circular(8),
                                                    //                   bottomLeft: Radius
                                                    //                       .circular(8),
                                                    //                   bottomRight:
                                                    //                       Radius
                                                    //                           .circular(
                                                    //                               8),
                                                    //                 ),
                                                    //               ),
                                                    //               elevation: 0,
                                                    //               child: Padding(
                                                    //                 padding:
                                                    //                     EdgeInsets.only(
                                                    //                         left: D.W /
                                                    //                             34,
                                                    //                         right: D.W /
                                                    //                             34,
                                                    //                         top: D.W /
                                                    //                             34,
                                                    //                         bottom:
                                                    //                             D.W /
                                                    //                                 34),
                                                    //                 child: SvgPicture.asset(
                                                    //                     "assets/images/ic_gallary.svg"),
                                                    //               )),
                                                    //           Positioned(
                                                    //               right: 0,
                                                    //               child: ClipRRect(
                                                    //                   borderRadius:
                                                    //                       BorderRadius
                                                    //                           .circular(
                                                    //                               20),
                                                    //                   child: Container(
                                                    //                       color: ColorConstants
                                                    //                           .skyBlue,
                                                    //                       child: Icon(
                                                    //                         Icons.close,
                                                    //                         size: 20,
                                                    //                         color: Colors
                                                    //                             .white,
                                                    //                       ))))
                                                    //         ],
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    SizedBox(height: D.H / 60),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Text(
                                                        "Tests",
                                                        style:
                                                            GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 240),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: D.W / 30,
                                                                right:
                                                                    D.W / 60),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color:
                                                                    ColorConstants
                                                                        .border),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          focusColor:
                                                              Colors.black,
                                                          value:
                                                              _choosenimageValue,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          iconEnabledColor:
                                                              ColorConstants
                                                                  .lightGrey,
                                                          icon: Icon(Icons
                                                              .arrow_drop_down_sharp),
                                                          iconSize: 32,
                                                          underline: Container(
                                                              color: Colors
                                                                  .transparent),
                                                          items: imageTypesData
                                                              .map((items) {
                                                            return DropdownMenuItem(
                                                              value: items
                                                                  .imageType,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  items
                                                                      .imageType
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.0),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          hint: Text(
                                                            "Type",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    D.H / 48,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          onChanged:
                                                              (String? value) {
                                                            State(() {
                                                              _choosenimageValue =
                                                                  value;
                                                              for (int i = 0;
                                                                  i <
                                                                      imageTypesData
                                                                          .length;
                                                                  i++) {
                                                                if (imageTypesData[
                                                                            i]
                                                                        .imageType ==
                                                                    _choosenimageValue) {
                                                                  imageId =
                                                                      imageTypesData[
                                                                              i]
                                                                          .imageTypeId!;
                                                                  print("dropdownvalueId:" +
                                                                      imageId
                                                                          .toString());
                                                                }
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 60),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child: Text(
                                                        "Description",
                                                        style:
                                                            GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 52,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 240),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: D.W / 18,
                                                          right: D.W / 18),
                                                      child:
                                                          CustomWhiteTextFormField(
                                                        controller:
                                                            discController,
                                                        readOnly: false,
                                                        validators: (e) {
                                                          if (discController
                                                                      .text ==
                                                                  null ||
                                                              discController
                                                                      .text ==
                                                                  '') {
                                                            return '*Description';
                                                          }
                                                        },
                                                        keyboardTYPE:
                                                            TextInputType.text,
                                                        obscured: false,
                                                        maxline: 1,
                                                        maxlength: 100,
                                                      ),
                                                    ),
                                                    SizedBox(height: D.H / 40),
                                                    Container(
                                                      height: 1,
                                                      color:
                                                          ColorConstants.line,
                                                    ),
                                                    SizedBox(height: D.H / 80),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (selectedImagesList
                                                                .isEmpty) {
                                                              CommonUtils
                                                                  .showRedToastMessage(
                                                                      "Please Select Image");
                                                            } else if (discController
                                                                .text.isEmpty) {
                                                              CommonUtils
                                                                  .showRedToastMessage(
                                                                      "Please add description");
                                                            } else {
                                                              saveTestImagine();
                                                            }
                                                          },
                                                          child: Text(
                                                            "OK",
                                                            style: GoogleFonts.heebo(
                                                                fontSize:
                                                                    D.H / 33,
                                                                color:
                                                                    ColorConstants
                                                                        .skyBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: D.H / 80),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          "assets/images/ic_add_plus.svg"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 12.0,
                              ),
                              itemCount:
                                  _labScreenResponseModelodel.imagine!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    showDialouge(imagine: _labScreenResponseModelodel.imagine![index] ,name: _labScreenResponseModelodel.imagine![index].description.toString() );
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(18),
                                            bottomLeft: Radius.circular(18),
                                            topLeft: Radius.circular(18),
                                            topRight: Radius.circular(18))),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18)),
                                          child: CachedNetworkImage(
                                            height: 110,
                                            width: 120,
                                            fit: BoxFit.fill,
                                            imageUrl: _labScreenResponseModelodel
                                                .imagine![index]
                                                .media![0]
                                                .mediaFileName
                                                .toString(),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: CircularProgressIndicator(
                                                    color: ColorConstants
                                                        .primaryBlueColor,
                                                    value: downloadProgress
                                                        .progress),
                                              ),
                                            ),
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          _labScreenResponseModelodel
                                              .imagine![index].imageType
                                              .toString(),
                                          style: GoogleFonts.heebo(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //         child: Column(
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             showDialouge(
                            //                 name: "X-ray",
                            //                 image: "assets/images/xray_icon.png");
                            //           },
                            //           child: Card(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(15.0),
                            //             ),
                            //             elevation: 4,
                            //             child: Column(
                            //               children: [
                            //                 ClipRRect(
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(18),
                            //                         topRight: Radius.circular(18)),
                            //                     child: Image.asset(
                            //                       "assets/images/xray_icon.png",
                            //                       height: 120,
                            //                       width: 120,
                            //                       fit: BoxFit.cover,
                            //                     )),
                            //                 SizedBox(
                            //                   height: 4,
                            //                 ),
                            //                 Text(
                            //                   "X-ray",
                            //                   style: GoogleFonts.heebo(
                            //                       fontWeight: FontWeight.normal,
                            //                       fontSize: 16),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                            //     SizedBox(
                            //       width: 4,
                            //     ),
                            //     Expanded(
                            //         child: Column(
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             showDialouge(
                            //                 name: "CT Scan",
                            //                 image: "assets/images/ctscan_icon.png");
                            //           },
                            //           child: Card(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(15.0),
                            //             ),
                            //             elevation: 4,
                            //             child: Column(
                            //               children: [
                            //                 ClipRRect(
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(18),
                            //                         topRight: Radius.circular(18)),
                            //                     child: Image.asset(
                            //                       "assets/images/ctscan_icon.png",
                            //                       height: 120,
                            //                       width: 200,
                            //                       fit: BoxFit.cover,
                            //                     )),
                            //                 SizedBox(
                            //                   height: 4,
                            //                 ),
                            //                 Text(
                            //                   "CT Scan",
                            //                   style: GoogleFonts.heebo(
                            //                       fontWeight: FontWeight.normal,
                            //                       fontSize: 16),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                            //     SizedBox(
                            //       width: 4,
                            //     ),
                            //     Expanded(
                            //         child: Column(
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             showDialouge(
                            //                 name: "MRI",
                            //                 image: "assets/images/mri_icon.png");
                            //           },
                            //           child: Card(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(15.0),
                            //             ),
                            //             elevation: 4,
                            //             child: Column(
                            //               children: [
                            //                 ClipRRect(
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(18),
                            //                         topRight: Radius.circular(18)),
                            //                     child: Image.asset(
                            //                       "assets/images/mri_icon.png",
                            //                       height: 120,
                            //                       width: 200,
                            //                       fit: BoxFit.cover,
                            //                     )),
                            //                 SizedBox(
                            //                   height: 4,
                            //                 ),
                            //                 Text(
                            //                   "MRI",
                            //                   style: GoogleFonts.heebo(
                            //                       fontWeight: FontWeight.normal,
                            //                       fontSize: 16),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 9,
                            // ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //         child: Column(
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             showDialouge(
                            //                 name: "Hand X-ray",
                            //                 image:
                            //                     "assets/images/hand_scan_icon.png");
                            //           },
                            //           child: Card(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(15.0),
                            //             ),
                            //             elevation: 4,
                            //             child: Column(
                            //               children: [
                            //                 ClipRRect(
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(18),
                            //                         topRight: Radius.circular(18)),
                            //                     child: Image.asset(
                            //                       "assets/images/hand_scan_icon.png",
                            //                       height: 120,
                            //                       width: 200,
                            //                       fit: BoxFit.cover,
                            //                     )),
                            //                 SizedBox(
                            //                   height: 4,
                            //                 ),
                            //                 Text(
                            //                   "Hand X-ray",
                            //                   style: GoogleFonts.heebo(
                            //                       fontWeight: FontWeight.normal,
                            //                       fontSize: 16),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                            //     SizedBox(
                            //       width: 4,
                            //     ),
                            //     Expanded(
                            //         child: Column(
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             showDialouge(
                            //                 name: "Chest X-ray",
                            //                 image: "assets/images/xray_icon.png");
                            //           },
                            //           child: Card(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(15.0),
                            //             ),
                            //             elevation: 4,
                            //             child: Column(
                            //               children: [
                            //                 ClipRRect(
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(18),
                            //                         topRight: Radius.circular(18)),
                            //                     child: Image.asset(
                            //                       "assets/images/xray_icon.png",
                            //                       height: 120,
                            //                       width: 200,
                            //                       fit: BoxFit.cover,
                            //                     )),
                            //                 SizedBox(
                            //                   height: 4,
                            //                 ),
                            //                 Text(
                            //                   "Chest X-ray",
                            //                   style: GoogleFonts.heebo(
                            //                       fontWeight: FontWeight.normal,
                            //                       fontSize: 16),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                            //     SizedBox(
                            //       width: 4,
                            //     ),
                            //     Expanded(
                            //         child: Column(
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             showDialouge(
                            //                 name: "Chest X-ray",
                            //                 image:
                            //                     "assets/images/chest_xray_icon.png");
                            //           },
                            //           child: Card(
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius: BorderRadius.circular(15.0),
                            //             ),
                            //             elevation: 4,
                            //             child: Column(
                            //               children: [
                            //                 ClipRRect(
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(18),
                            //                         topRight: Radius.circular(18)),
                            //                     child: Image.asset(
                            //                       "assets/images/chest_xray_icon.png",
                            //                       height: 120,
                            //                       width: 200,
                            //                       fit: BoxFit.cover,
                            //                     )),
                            //                 SizedBox(
                            //                   height: 4,
                            //                 ),
                            //                 Text(
                            //                   "Chest X-ray",
                            //                   style: GoogleFonts.heebo(
                            //                       fontWeight: FontWeight.normal,
                            //                       fontSize: 16),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                            //   ],
                            // ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container());
  }

  showDialouge({required String name, required Imagine imagine, }) {
    int activePage = 0;

    PageController _pageController = PageController(viewportFraction: 1,initialPage: 0);
    List<Widget> indicators(imagesLength,currentIndex) {
      return List<Widget>.generate(imagesLength, (index) {
        return Container(
          margin: EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: currentIndex == index ? ColorConstants.primaryBlueColor : Colors.white,
              shape: BoxShape.circle),
        );
      });
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState)
            => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                imagine.imageType.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Text(
                              name,
                              style: GoogleFonts.heebo(
                                  color: ColorConstants.light, fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Container(
                            height: 350,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                PageView.builder(
                                  controller: _pageController,
                                    onPageChanged: (page) {
                                      setState(() {
                                        activePage = page;
                                      });
                                    },
                                    itemCount: imagine.media!.length,
                                    pageSnapping: true,
                                    itemBuilder: (context,pagePosition){
                                      return  Container(
                                          height: 340,
                                          child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(25)),
                                              child:  CachedNetworkImage(
                                                height: 120,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                                imageUrl:imagine.media![pagePosition].mediaFileName
                                                    .toString(),
                                                progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                    Center(
                                                      child: SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child: CircularProgressIndicator(
                                                            color: ColorConstants
                                                                .primaryBlueColor,
                                                            value: downloadProgress
                                                                .progress),
                                                      ),
                                                    ),
                                                errorWidget: (context, url, error) =>
                                                    Icon(Icons.error),
                                              )));
                                    }),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: indicators(imagine.media!.length,activePage))
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 18
                            ,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: ColorConstants.line,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "OK",
                          style:
                              GoogleFonts.heebo(color: Colors.blue, fontSize: 25),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> getImagineTypes() async {
    final uri = ApiEndPoint.getImagineTypes;
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
      for (int i = 0; i < res.length; i++) {
        imageTypesData.add(ImageTypeModel(
            imageType: res[i]["imageType"],
            imageTypeId: res[i]["imageTypeId"]));
      }
      print("imageTypesData" + imageTypesData.toString());
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  saveTestImagine() async {
    CommonUtils.showProgressDialog(context);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    var request = http.MultipartRequest('POST', ApiEndPoint.saveTestImagine);

    request.headers.addAll(headers);
    request.fields['UsersImagineId'] = '0';
    request.fields['ImagineTypeId'] = imageId.toString();
    request.fields['Description'] = discController.text.toString();
    var count = 1;
    for (int i = 0; i < selectedImagesList.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          "media$count", selectedImagesList[i]));
      count++;
    }
    ;
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage(responseData["message"]);
      getLabScreenApiWithoutLoader();
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);
    }
  }

  Future<void> getTestResultTypes() async {
    final uri = ApiEndPoint.getTestResultType;
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
      for (int i = 0; i < res.length; i++) {
        testResultTypesData.add(TestResultData(
            testType: res[i]["testType"], testTypeId: res[i]["testTypeId"]));
      }
      print("testResultTypesData" + testResultTypesData.toString());
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> saveTestResult() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveTestResult;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersTestResultId": 0,
      "testResultId": testTypeId,
      "testResultValue": valueController.text.toString(),
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      getLabScreenApiWithoutLoader();
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}
