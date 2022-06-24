import 'dart:convert';
import 'dart:io';

import 'package:ehr/View/Screens/comment_screen.dart';
import 'package:ehr/View/Screens/medication_screen.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../Constants/api_endpoint.dart';
import '../../Constants/color_constants.dart';
import '../../CustomWidgets/chart_widget.dart';
import '../../CustomWidgets/custom_search_bar.dart';
import '../../CustomWidgets/custom_search_bar2.dart';
import '../../Model/imageType_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_white_textform_field.dart';
import 'add_medication_screen.dart';

class LabScreen extends StatefulWidget {
  const LabScreen({Key? key}) : super(key: key);

  @override
  _LabScreenState createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late TabController _tabController;
  var _selectedFood = "after";
  String? _chosenValue;
  final commentController = TextEditingController();
  final valueController = TextEditingController();
  final discController = TextEditingController();
  var imageId = 0;
  List<ImageTypeModel> imageTypesData = [];
  String pickedfilepath1 = '';
  String pickedfilepath2 = '';
  String pickedfilepath3 = '';

  List<String> selectedImagesList = [];

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    getImagineTypes();
    super.initState();
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
        body: Padding(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: D.W / 40,
                                                    right: D.W / 40),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Add Comment",
                                                    style: GoogleFonts.heebo(
                                                        fontSize: D.H / 38,
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                                  style: GoogleFonts.heebo(
                                                      fontSize: D.H / 52,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(height: D.H / 120),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: D.W / 30,
                                                      right: D.W / 60),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorConstants
                                                              .border),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                  child: DropdownButton<String>(
                                                    isExpanded: true,
                                                    focusColor: Colors.white,
                                                    value: _chosenValue,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    iconEnabledColor:
                                                        ColorConstants
                                                            .lightGrey,
                                                    icon: Icon(Icons
                                                        .arrow_drop_down_sharp),
                                                    iconSize: 32,
                                                    underline: Container(
                                                        color:
                                                            Colors.transparent),
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
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                      "Type",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: D.H / 48,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _chosenValue = value;
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
                                                  style: GoogleFonts.heebo(
                                                      fontSize: D.H / 52,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(height: D.H / 120),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: CustomWhiteTextFormField(
                                                  controller: commentController,
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
                                                color: ColorConstants.line,
                                              ),
                                              SizedBox(height: D.H / 80),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "OK",
                                                    style: GoogleFonts.heebo(
                                                        fontSize: D.H / 33,
                                                        color: ColorConstants
                                                            .skyBlue,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                itemCount: 3,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
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
                                                    color:
                                                        ColorConstants.bgImage,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8),
                                                        bottomLeft:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8),
                                                      ),
                                                    ),
                                                    elevation: 0,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Chest",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: D.H / 52,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      "Mitral valve prolapse",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: D.H / 52,
                                                          fontWeight:
                                                              FontWeight.w400),
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
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4.0),
                                            child: Container(
                                              height: 1.0,
                                              color: ColorConstants.lineColor,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                itemCount: 3,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: D.W / 40.0, top: D.H / 80),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Card(
                                                  color: ColorConstants.bgImage,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      topRight:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                      bottomRight:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Metformin",
                                                          style:
                                                              GoogleFonts.heebo(
                                                                  fontSize:
                                                                      D.H / 52,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        SizedBox(
                                                          width: 65,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: D.W / 30,
                                                              width: D.W / 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
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
                                                                      .withOpacity(
                                                                          0.3)),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Hil 250 mg 2/Day",
                                                          style: GoogleFonts.heebo(
                                                              color:
                                                                  ColorConstants
                                                                      .blueBtn,
                                                              fontSize:
                                                                  D.H / 66,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          width: 57,
                                                        ),
                                                        Text(
                                                          "27 -12-202",
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
                                                                  left: 2.0,
                                                                  top: 2.0),
                                                          child: Text(
                                                            "Jhon Miler",
                                                            style: GoogleFonts.heebo(
                                                                color:
                                                                    ColorConstants
                                                                        .darkText,
                                                                fontSize:
                                                                    D.H / 66,
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
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4.0),
                                            child: Container(
                                              height: 1.0,
                                              color: ColorConstants.lineColor,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
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
                            top: D.W / 30.0, left: D.W / 30.0, right: D.W / 26),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        StatefulBuilder(
                                          builder: (BuildContext context, void Function(void Function()) setState)=> AlertDialog(
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: D.W / 40,
                                                    right: D.W / 40),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Add Test results",
                                                    style: GoogleFonts.heebo(
                                                        fontSize: D.H / 38,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: D.H / 60),
                                              Container(
                                                height: 1,
                                                color: ColorConstants.line,
                                              ),
                                              SizedBox(height: D.H / 60),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: Text(
                                                  "Type",
                                                  style: GoogleFonts.heebo(
                                                      fontSize: D.H / 52,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(height: D.H / 240),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: D.W / 30,
                                                      right: D.W / 60),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorConstants
                                                              .border),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                  child: DropdownButton<String>(
                                                    isExpanded: true,
                                                    focusColor: Colors.white,
                                                    value: _chosenValue,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    iconEnabledColor:
                                                        ColorConstants.lightGrey,
                                                    icon: Icon(Icons
                                                        .arrow_drop_down_sharp),
                                                    iconSize: 32,
                                                    underline: Container(
                                                        color:
                                                            Colors.transparent),
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
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                      "Type",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: D.H / 48,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _chosenValue = value;
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
                                                  style: GoogleFonts.heebo(
                                                      fontSize: D.H / 52,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(height: D.H / 240),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: CustomWhiteTextFormField(
                                                  controller: valueController,
                                                  readOnly: false,
                                                  validators: (e) {
                                                    if (valueController.text ==
                                                            null ||
                                                        valueController.text ==
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
                                                color: ColorConstants.line,
                                              ),
                                              SizedBox(height: D.H / 80),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "OK",
                                                    style: GoogleFonts.heebo(
                                                        fontSize: D.H / 33,
                                                        color: ColorConstants
                                                            .skyBlue,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                            indicatorColor: ColorConstants.primaryBlueColor,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Text(
                                  "Hemoglobin",
                                  style: GoogleFonts.heebo(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Blood Pressure",
                                  style: GoogleFonts.heebo(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Heart Rate",
                                  style: GoogleFonts.heebo(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // create widgets for each tab bar here
                      Container(
                        height: 300,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // first tab bar view widget
                            Container(),
                            GraphWidget(),
                            // second tab bar viiew widget
                            Container(),
                          ],
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
                            top: D.W / 30.0, left: D.W / 30.0, right: D.W / 26),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        StatefulBuilder(
                                      builder: (BuildContext context,
                                              void Function(void Function())
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: D.W / 40,
                                                    right: D.W / 40),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Imaging",
                                                    style: GoogleFonts.heebo(
                                                        fontSize: D.H / 38,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: D.H / 60),
                                              Container(
                                                height: 1,
                                                color: ColorConstants.line,
                                              ),
                                              SizedBox(height: D.H / 60),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: InkWell(
                                                  onTap: () async {
                                                    PickedFile? pickedFile =
                                                        await ImagePicker()
                                                            .getImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      maxWidth: 1800,
                                                      maxHeight: 1800,
                                                    );
                                                    if (pickedFile != null) {
                                                      State(() {
                                                        var path =
                                                            pickedFile.path;
                                                        selectedImagesList
                                                            .add(path);
                                                      });
                                                    }
                                                  },
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
                                                                EdgeInsets.only(
                                                                    left: D.W /
                                                                        50,
                                                                    right: D.W /
                                                                        70,
                                                                    top: D.W /
                                                                        50,
                                                                    bottom:
                                                                        D.W /
                                                                            50),
                                                            child: SvgPicture.asset(
                                                                "assets/images/ic_upload_image.svg"),
                                                          )),
                                                      SizedBox(width: D.H / 80),
                                                      Text(
                                                        "Upload Image",
                                                        style: GoogleFonts.heebo(
                                                            fontSize: D.H / 38,
                                                            color:
                                                                ColorConstants
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                height: 60,
                                                width: D.W / 1.25,
                                                child: ListView.builder(
                                                  physics: BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      selectedImagesList.length+1,
                                                  itemBuilder:
                                                      (context, position) {
                                                    if(position== selectedImagesList.length){
                                                      return InkWell(
                                                        onTap: () async {
                                                          PickedFile? pickedFile =
                                                              await ImagePicker()
                                                              .getImage(
                                                            source:
                                                            ImageSource.gallery,
                                                            maxWidth: 1800,
                                                            maxHeight: 1800,
                                                          );
                                                          if (pickedFile != null) {
                                                            State(() {
                                                              var path =
                                                                  pickedFile.path;
                                                              selectedImagesList
                                                                  .add(path);
                                                            });
                                                          }
                                                        },
                                                        child: Stack(
                                                          clipBehavior: Clip.none,
                                                          children: [
                                                            Card(
                                                              margin: EdgeInsets.zero,
                                                                color: ColorConstants
                                                                    .bgImage,
                                                                shape:
                                                                 RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(Radius.circular(10)),
                                                                ),
                                                                elevation: 0,
                                                                child: Container(
                                                                  height: 65,width: 38,
                                                                  margin: EdgeInsets.all(12),
                                                                  child: SvgPicture.asset(
                                                                      "assets/images/ic_gallary.svg"),
                                                                )),
                                                            Positioned(
                                                                right: -5,
                                                                top:-5,
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        20),
                                                                    child: Container(
                                                                        color: ColorConstants
                                                                            .skyBlue,
                                                                        child: Icon(
                                                                          Icons.close,
                                                                          size: 20,
                                                                          color: Colors
                                                                              .white,
                                                                        ))))
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 12.0),
                                                      child: Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            child: Image.file(
                                                              File(selectedImagesList[
                                                                  position]),
                                                              fit: BoxFit.cover,
                                                              width: 55,
                                                              height: 60,
                                                            ),
                                                          ),
                                                          Positioned(
                                                              right: -5,
                                                              top: -5,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  selectedImagesList
                                                                      .removeAt(
                                                                          position);
                                                                  State(() {});
                                                                },
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(20),
                                                                    child: Container(
                                                                        color: ColorConstants.skyBlue,
                                                                        child: Icon(
                                                                          Icons
                                                                              .close,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              Colors.white,
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
                                                  style: GoogleFonts.heebo(
                                                      fontSize: D.H / 52,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(height: D.H / 240),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: D.W / 30,
                                                      right: D.W / 60),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorConstants
                                                              .border),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
                                                  child: DropdownButton<String>(
                                                    isExpanded: true,
                                                    focusColor: Colors.white,
                                                    value: _chosenValue,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    iconEnabledColor:
                                                        ColorConstants
                                                            .lightGrey,
                                                    icon: Icon(Icons
                                                        .arrow_drop_down_sharp),
                                                    iconSize: 32,
                                                    underline: Container(
                                                        color:
                                                            Colors.transparent),
                                                    items: imageTypesData
                                                        .map((items) {
                                                      return DropdownMenuItem(
                                                        value: items.imageType,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Text(
                                                            items.imageType
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    hint: Text(
                                                      "Type",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: D.H / 48,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _chosenValue = value;
                                                        for (int i = 0;
                                                            i <
                                                                imageTypesData
                                                                    .length;
                                                            i++) {
                                                          if (imageTypesData[i]
                                                                  .imageType ==
                                                              _chosenValue) {
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
                                                  style: GoogleFonts.heebo(
                                                      fontSize: D.H / 52,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(height: D.H / 240),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: D.W / 18,
                                                    right: D.W / 18),
                                                child: CustomWhiteTextFormField(
                                                  controller: discController,
                                                  readOnly: false,
                                                  validators: (e) {
                                                    if (discController.text ==
                                                            null ||
                                                        discController.text ==
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
                                                color: ColorConstants.line,
                                              ),
                                              SizedBox(height: D.H / 80),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap:(){
                                                      multipartProdecudre();
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: D.H / 33,
                                                          color: ColorConstants
                                                              .skyBlue,
                                                          fontWeight:
                                                              FontWeight.w400),
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
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialouge(
                                      name: "X-ray",
                                      image: "assets/images/xray_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18)),
                                          child: Image.asset(
                                            "assets/images/xray_icon.png",
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "X-ray",
                                        style: GoogleFonts.heebo(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialouge(
                                      name: "CT Scan",
                                      image: "assets/images/ctscan_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18)),
                                          child: Image.asset(
                                            "assets/images/ctscan_icon.png",
                                            height: 120,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "CT Scan",
                                        style: GoogleFonts.heebo(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialouge(
                                      name: "MRI",
                                      image: "assets/images/mri_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18)),
                                          child: Image.asset(
                                            "assets/images/mri_icon.png",
                                            height: 120,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "MRI",
                                        style: GoogleFonts.heebo(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialouge(
                                      name: "Hand X-ray",
                                      image:
                                          "assets/images/hand_scan_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18)),
                                          child: Image.asset(
                                            "assets/images/hand_scan_icon.png",
                                            height: 120,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Hand X-ray",
                                        style: GoogleFonts.heebo(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialouge(
                                      name: "Chest X-ray",
                                      image: "assets/images/xray_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18)),
                                          child: Image.asset(
                                            "assets/images/xray_icon.png",
                                            height: 120,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Chest X-ray",
                                        style: GoogleFonts.heebo(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialouge(
                                      name: "Chest X-ray",
                                      image:
                                          "assets/images/chest_xray_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18),
                                              topRight: Radius.circular(18)),
                                          child: Image.asset(
                                            "assets/images/chest_xray_icon.png",
                                            height: 120,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Chest X-ray",
                                        style: GoogleFonts.heebo(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  showDialouge({name, image}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
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
                              name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Text(
                            "Lorem Ipsum has been the industry's standarddummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            style: GoogleFonts.heebo(
                                color: ColorConstants.light, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Container(
                            height: 320,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                child: Image.asset(
                                  image,
                                  fit: BoxFit.cover,
                                ))),
                        SizedBox(
                          height: 18,
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

  multipartProdecudre() async {
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
    var count=1;
    for(int i=0;i<selectedImagesList.length;i++){

      request.files.add(await http.MultipartFile.fromPath("media$count", selectedImagesList[i]));
      count++;
    };
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage(responseData["message"]);
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);
    }
  }
}
