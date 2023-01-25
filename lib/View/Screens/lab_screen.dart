import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehr/Model/testResultType_model.dart';
import 'package:ehr/View/Screens/body_detail_screen.dart';
import 'package:ehr/View/Screens/comment_screen.dart';
import 'package:ehr/View/Screens/lab_list_screen.dart';
import 'package:ehr/View/Screens/medication_screen.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:ehr/View/Screens/suppliments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:expansion_widget/expansion_widget.dart';
import '../../Constants/api_endpoint.dart';
import '../../Constants/color_constants.dart';
import '../../Constants/constants.dart';
import '../../CustomWidgets/chart_widget.dart';
import '../../CustomWidgets/custom_date_field.dart';
import '../../Model/imageType_model.dart';
import '../../Model/lab_screen_response_model.dart';
import '../../Model/otp_verification_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_white_textform_field.dart';
import 'add_medication_screen.dart';
import 'add_suppliments_screen.dart';
import 'dart:math' as math;

class LabScreen extends StatefulWidget {
  @override
  _LabScreenState createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late TabController _tabController;
  var _selectedFood = "after";
  String? _choosenCommentValue;
  String? _choosenLabValue;
  String? _choosenimageValue;
  var showFormField = "";
  bool askForName = false;
  final commentController = TextEditingController();
  final valueController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final tasteNameController = TextEditingController();
  final discController = TextEditingController();
  final imagineNameController = TextEditingController();
  int positiveOrnegative = 1;
  bool isPositive = true;
  bool shoWimagineNameField = false;

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

  // List<TestResults> hemoglobinList = [];
  // List<TestResults> bloodPressureList = [];
  // List<TestResults> heartRateList = [];
  // List<TestResults> labListData = [];
  //
  // List<Widget> tabList = [];
  // List<Widget> tabbodyList = [];
  int tabItemCount = 3;
  DateTime selectedDate = DateTime.now();
  final labTestDate = TextEditingController();
  final hwTestDate = TextEditingController();
  int eDate = 0;
  int hwDate = 0;

  @override
  void initState() {
    getTestResultTypes();
    getImagineTypes();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getLabScreenApi();
    });

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
            "Summary",
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
        body: RefreshIndicator(
          color: ColorConstants.primaryBlueColor,
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                getLabScreenApi();
              },
            );
          },
          child: _labScreenResponseModelodel.pains != null
              ? SingleChildScrollView(
                primary: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.white,
                      child: ExpansionWidget(
                          initiallyExpanded: false,
                          titleBuilder:
                              (double animationValue, _, bool isExpaned, toogleFunction) {
                            return InkWell(
                                onTap: () => toogleFunction(animated: true),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                            "General",
                                            style: GoogleFonts.heebo(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),),
                                      Transform.rotate(
                                        angle: math.pi * animationValue / 2,
                                        child: Icon(Icons.arrow_right, size: 40),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  ),
                                ));
                          },
                          content: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Card(
                                  color: Colors.white,
                                  elevation: 2,
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
                                              top: D.W / 30.0,
                                              left: D.W / 30.0,
                                              bottom: D.W / 30.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5.0),
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
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BodyDetailScreen(
                                                                    bodyPartName:
                                                                    "None",
                                                                    isBack: Constants
                                                                        .isBackBody,
                                                                    x: 0.0,
                                                                    y: 0.0))).then(
                                                            (value) =>
                                                            getLabScreenApiWithoutPop());
                                                  },
                                                  child: SvgPicture.asset(
                                                      "assets/images/ic_add_plus.svg"))
                                            ],
                                          ),
                                        ),
                                        _labScreenResponseModelodel.pains!.isEmpty
                                            ? Container()
                                            : Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            ListView.builder(
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                itemCount:
                                                _labScreenResponseModelodel
                                                    .pains!.length >=
                                                    3
                                                    ? 3
                                                    : _labScreenResponseModelodel
                                                    .pains!.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return Container(
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                left: D.W /
                                                                    40.0,
                                                                top:
                                                                D.H / 80),
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
                                                                            .circular(
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
                                                                    child:
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .all(D.W /
                                                                          50),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                          "assets/images/ic_message.svg"),
                                                                    )),
                                                                SizedBox(
                                                                    width:
                                                                    D.H / 80),
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
                                                                          .pains![
                                                                      index]
                                                                          .bodyPart
                                                                          .toString(),
                                                                      style: GoogleFonts.heebo(
                                                                          fontSize:
                                                                          D.H /
                                                                              52,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                    Text(
                                                                      _labScreenResponseModelodel
                                                                          .pains![
                                                                      index]
                                                                          .description
                                                                          .toString(),
                                                                      style: GoogleFonts.heebo(
                                                                          fontSize:
                                                                          D.H /
                                                                              52,
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
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 4.0,
                                                                right: 4.0),
                                                            child: Container(
                                                              height: 1.0,
                                                              color:
                                                              ColorConstants
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
                                                    color: Colors.blue
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4))),
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CommentScreen())).then(
                                                              (value) =>
                                                              getLabScreenApiWithoutPop());
                                                    },
                                                    child: Text(
                                                      "See more",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: ColorConstants
                                                              .skyBlue),
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
                                  elevation: 2,
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
                                              top: D.W / 30.0,
                                              left: D.W / 30.0,
                                              bottom: D.W / 30.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5.0),
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
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddMedicationScreen()))
                                                        .then((value) {
                                                      getLabScreenApiWithoutPop();
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      "assets/images/ic_add_plus.svg"))
                                            ],
                                          ),
                                        ),
                                        _labScreenResponseModelodel.medications!.isEmpty
                                            ? Container()
                                            : Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            ListView.builder(
                                                itemCount:
                                                _labScreenResponseModelodel
                                                    .medications!.length,
                                                shrinkWrap: true,
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  var millis =
                                                      _labScreenResponseModelodel
                                                          .medications![index]
                                                          .created;
                                                  var dt = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                      millis!);
                                                  var d24 = DateFormat(
                                                      'dd/MM/yyyy')
                                                      .format(
                                                      dt); // 31/12/2000, 22:00

                                                  var userName = getUserName!
                                                      .firstName
                                                      .toString();
                                                  var date = d24.toString();
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        left: D.W / 40.0,
                                                        top: D.H / 80),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Card(
                                                                      color: ColorConstants
                                                                          .bgImage,
                                                                      shape:
                                                                      const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .only(
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
                                                                      elevation:
                                                                      0,
                                                                      child:
                                                                      Padding(
                                                                        padding: EdgeInsets
                                                                            .all(D.W /
                                                                            60),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                            "assets/images/ic_bowl.svg"),
                                                                      )),
                                                                  SizedBox(
                                                                    width:
                                                                    D.W / 50,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        _labScreenResponseModelodel
                                                                            .medications![
                                                                        index]
                                                                            .medicationName
                                                                            .toString(),
                                                                        style: GoogleFonts.heebo(
                                                                            fontSize: D.H /
                                                                                52,
                                                                            fontWeight:
                                                                            FontWeight.w400),
                                                                      ),
                                                                      Text(
                                                                        "${_labScreenResponseModelodel.medications![index].dosage! + " " + "${_labScreenResponseModelodel.medications![index].dosageType! + " "}" + "${_labScreenResponseModelodel.medications![index].frequencyType}"}",
                                                                        // "Hil 250 mg 2/Day",
                                                                        style: GoogleFonts.heebo(
                                                                            color: ColorConstants
                                                                                .blueBtn,
                                                                            fontSize: D.H /
                                                                                66,
                                                                            fontWeight:
                                                                            FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right: D.W /
                                                                        30),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
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
                                                                              BorderRadius.all(Radius.circular(25)),
                                                                              color: ColorConstants.lightRed),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                          3,
                                                                        ),
                                                                        Text(
                                                                          _labScreenResponseModelodel
                                                                              .medications![index]
                                                                              .medicationFood
                                                                              .toString(),
                                                                          style: GoogleFonts.heebo(
                                                                              color:
                                                                              Colors.black.withOpacity(0.3)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      date.toString(),
                                                                      style: GoogleFonts.heebo(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.3)),
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
                                                            const EdgeInsets
                                                                .only(
                                                                left: 4.0,
                                                                right: 4.0),
                                                            child: Container(
                                                              height: 1.0,
                                                              color:
                                                              ColorConstants
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
                                                    color: Colors.blue
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4))),
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MedicationScreen())).then(
                                                              (value) {
                                                            getLabScreenApiWithoutPop();
                                                          });
                                                    },
                                                    child: Text(
                                                      "See more",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: ColorConstants
                                                              .skyBlue),
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
                                  elevation: 2,
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
                                                  _choosenimageValue =
                                                      imageTypesData[0].imageType;

                                                  var imagineModel =
                                                  imageTypesData.where((element) =>
                                                  element.imageType ==
                                                      _choosenimageValue);
                                                  shoWimagineNameField =
                                                  imagineModel.first.askForName!;
                                                  imagineNameController.clear();


                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        StatefulBuilder(
                                                          builder: (BuildContext context,
                                                              void Function(
                                                                  void Function())
                                                              State) =>
                                                              AlertDialog(
                                                                contentPadding:
                                                                EdgeInsets.all(0),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                    Radius.circular(18),
                                                                  ),
                                                                ),
                                                                content: Container(
                                                                  width: D.W / 1.25,
                                                                  child: SingleChildScrollView(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      mainAxisSize:
                                                                      MainAxisSize.min,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              top: D.W / 40,
                                                                              right:
                                                                              D.W / 40),
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
                                                                                  size:
                                                                                  D.W / 20,
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
                                                                              style: GoogleFonts.heebo(
                                                                                  fontSize:
                                                                                  D.H / 38,
                                                                                  fontWeight:
                                                                                  FontWeight
                                                                                      .w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Container(
                                                                          height: 1,
                                                                          color: ColorConstants
                                                                              .line,
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              left:
                                                                              D.W / 18,
                                                                              right:
                                                                              D.W / 18),
                                                                          child: InkWell(
                                                                            onTap: () async {
                                                                              PickedFile?
                                                                              pickedFile =
                                                                              await ImagePicker()
                                                                                  .getImage(
                                                                                source:
                                                                                ImageSource
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
                                                                                      .add(
                                                                                      path);
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
                                                                                    elevation:
                                                                                    0,
                                                                                    child:
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(
                                                                                          left: D.W /
                                                                                              50,
                                                                                          right: D.W /
                                                                                              70,
                                                                                          top: D.W /
                                                                                              50,
                                                                                          bottom:
                                                                                          D.W / 50),
                                                                                      child: SvgPicture
                                                                                          .asset(
                                                                                          "assets/images/ic_upload_image.svg"),
                                                                                    )),
                                                                                SizedBox(
                                                                                    width: D.H /
                                                                                        80),
                                                                                Text(
                                                                                  "Upload Image",
                                                                                  style: GoogleFonts.heebo(
                                                                                      fontSize:
                                                                                      D.H /
                                                                                          38,
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
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Container(
                                                                          padding: EdgeInsets
                                                                              .symmetric(
                                                                              horizontal:
                                                                              12),
                                                                          height: 60,
                                                                          width: D.W / 1.25,
                                                                          child:
                                                                          ListView.builder(
                                                                            physics:
                                                                            BouncingScrollPhysics(),
                                                                            scrollDirection:
                                                                            Axis.horizontal,
                                                                            itemCount:
                                                                            selectedImagesList
                                                                                .length +
                                                                                1,
                                                                            itemBuilder:
                                                                                (context,
                                                                                position) {
                                                                              if (position ==
                                                                                  selectedImagesList
                                                                                      .length) {
                                                                                return InkWell(
                                                                                  onTap:
                                                                                      () async {
                                                                                    PickedFile?
                                                                                    pickedFile =
                                                                                    await ImagePicker()
                                                                                        .getImage(
                                                                                      source: ImageSource
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
                                                                                            pickedFile.path;
                                                                                        selectedImagesList
                                                                                            .add(path);
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
                                                                                            child:
                                                                                            SvgPicture.asset("assets/images/ic_gallary.svg"),
                                                                                          )),
                                                                                      Positioned(
                                                                                          right:
                                                                                          -5,
                                                                                          top:
                                                                                          -5,
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
                                                                                      borderRadius: const BorderRadius
                                                                                          .all(
                                                                                          Radius.circular(
                                                                                              10)),
                                                                                      child: Image
                                                                                          .file(
                                                                                        File(selectedImagesList[
                                                                                        position]),
                                                                                        fit: BoxFit
                                                                                            .cover,
                                                                                        width:
                                                                                        55,
                                                                                        height:
                                                                                        60,
                                                                                      ),
                                                                                    ),
                                                                                    Positioned(
                                                                                        right:
                                                                                        -5,
                                                                                        top: -5,
                                                                                        child:
                                                                                        InkWell(
                                                                                          onTap:
                                                                                              () {
                                                                                            selectedImagesList.removeAt(position);
                                                                                            State(() {});
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
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              left:
                                                                              D.W / 18,
                                                                              right:
                                                                              D.W / 18),
                                                                          child: Text(
                                                                            "Tests",
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize:
                                                                                D.H / 52,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w400),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 240),
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              left:
                                                                              D.W / 18,
                                                                              right:
                                                                              D.W / 18),
                                                                          child: Container(
                                                                            padding:
                                                                            EdgeInsets.only(
                                                                                left: D.W /
                                                                                    30,
                                                                                right: D.W /
                                                                                    60),
                                                                            width:
                                                                            MediaQuery.of(
                                                                                context)
                                                                                .size
                                                                                .width,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors
                                                                                    .white,
                                                                                border: Border.all(
                                                                                    color: ColorConstants
                                                                                        .border),
                                                                                borderRadius: BorderRadius
                                                                                    .all(Radius
                                                                                    .circular(
                                                                                    8))),
                                                                            child:
                                                                            DropdownButton<
                                                                                String>(
                                                                              isExpanded: true,
                                                                              focusColor:
                                                                              Colors.black,
                                                                              value:
                                                                              _choosenimageValue,
                                                                              style: TextStyle(
                                                                                  color: Colors
                                                                                      .black),
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
                                                                                  child:
                                                                                  Padding(
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
                                                                                    D.H /
                                                                                        48,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w400),
                                                                              ),
                                                                              onChanged:
                                                                                  (String?
                                                                              value) {
                                                                                State(() {
                                                                                  _choosenimageValue =
                                                                                      value;
                                                                                  var imageModel =
                                                                                  imageTypesData.where((element) =>
                                                                                  element
                                                                                      .imageType ==
                                                                                      _choosenimageValue);
                                                                                  shoWimagineNameField =
                                                                                  imageModel
                                                                                      .first
                                                                                      .askForName!;
                                                                                  for (int i =
                                                                                  0;
                                                                                  i <
                                                                                      imageTypesData
                                                                                          .length;
                                                                                  i++) {
                                                                                    if (imageTypesData[i]
                                                                                        .imageType ==
                                                                                        _choosenimageValue) {
                                                                                      imageId =
                                                                                      imageTypesData[i]
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
                                                                        shoWimagineNameField
                                                                            ? Container(
                                                                          child: Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                  height: D.H /
                                                                                      60),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                    left: D.W /
                                                                                        18,
                                                                                    right:
                                                                                    D.W / 18),
                                                                                child:
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "Test name",
                                                                                      style:
                                                                                      GoogleFonts.heebo(fontSize: D.H / 52, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                  height: D.H /
                                                                                      240),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(
                                                                                    left: D.W /
                                                                                        18,
                                                                                    right:
                                                                                    D.W / 18),
                                                                                child:
                                                                                CustomWhiteTextFormField(
                                                                                  controller:
                                                                                  imagineNameController,
                                                                                  readOnly:
                                                                                  false,
                                                                                  validators:
                                                                                      (e) {
                                                                                    if (discController.text == null ||
                                                                                        discController.text == '') {
                                                                                      return '*Description';
                                                                                    }
                                                                                  },
                                                                                  keyboardTYPE:
                                                                                  TextInputType.text,
                                                                                  obscured:
                                                                                  false,
                                                                                  maxline:
                                                                                  1,
                                                                                  maxlength:
                                                                                  100,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                            : Container(),
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              left:
                                                                              D.W / 18,
                                                                              right:
                                                                              D.W / 18),
                                                                          child: Text(
                                                                            "Description",
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize:
                                                                                D.H / 52,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w400),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 240),
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              left:
                                                                              D.W / 18,
                                                                              right:
                                                                              D.W / 18),
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
                                                                            TextInputType
                                                                                .text,
                                                                            obscured: false,
                                                                            maxline: 1,
                                                                            maxlength: 100,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 40),
                                                                        Container(
                                                                          height: 1,
                                                                          color: ColorConstants
                                                                              .line,
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 80),
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
                                                                                } else if (shoWimagineNameField &&
                                                                                    imagineNameController
                                                                                        .text
                                                                                        .isEmpty) {
                                                                                  CommonUtils
                                                                                      .showRedToastMessage(
                                                                                      "Please Enter TestName");
                                                                                } else if (discController
                                                                                    .text
                                                                                    .isEmpty) {
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
                                                                                    D.H /
                                                                                        33,
                                                                                    color: ColorConstants
                                                                                        .skyBlue,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w400),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 80),
                                                                      ],
                                                                    ),
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
                                      _labScreenResponseModelodel.imagine!.isEmpty
                                          ? Container()
                                          : GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.75,
                                          crossAxisSpacing: 5.0,
                                          mainAxisSpacing: 12.0,
                                        ),
                                        itemCount: _labScreenResponseModelodel
                                            .imagine!.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              showDialouge(
                                                  imagine:
                                                  _labScreenResponseModelodel
                                                      .imagine![index],
                                                  name:
                                                  _labScreenResponseModelodel
                                                      .imagine![index]
                                                      .description
                                                      .toString(),
                                                  id: _labScreenResponseModelodel
                                                      .imagine![index]
                                                      .imagineTypeId,
                                                  index: index);
                                            },
                                            child: Card(
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight:
                                                      Radius.circular(18),
                                                      bottomLeft:
                                                      Radius.circular(18),
                                                      topLeft:
                                                      Radius.circular(18),
                                                      topRight:
                                                      Radius.circular(18))),
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(
                                                            18),
                                                        topRight:
                                                        Radius.circular(
                                                            18)),
                                                    child: CachedNetworkImage(
                                                      height: 110,
                                                      width: 120,
                                                      fit: BoxFit.fill,
                                                      imageUrl:
                                                      _labScreenResponseModelodel
                                                          .imagine![index]
                                                          .media![0]
                                                          .mediaFileName
                                                          .toString(),
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                          downloadProgress) =>
                                                          Center(
                                                            child: SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child: CircularProgressIndicator(
                                                                  color: ColorConstants
                                                                      .primaryBlueColor,
                                                                  value:
                                                                  downloadProgress
                                                                      .progress),
                                                            ),
                                                          ),
                                                      errorWidget:
                                                          (context, url, error) =>
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
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  color: Colors.white,
                                  elevation: 2,
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
                                            bottom: D.W / 30.0,
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
                                              //labdialouge
                                                onTap: () {
                                                  isPositive = true;
                                                  positiveOrnegative = 1;
                                                  valueController.text = "";
                                                  tasteNameController.text = "";
                                                  _choosenLabValue = testResultTypesData[0].testType;
                                                  testTypeId = testResultTypesData[0].testTypeId!;
                                                  var textModel = testResultTypesData
                                                      .where((element) =>
                                                  element.testType ==
                                                      _choosenLabValue);
                                                  showFormField = textModel
                                                      .first.shortCodeType
                                                      .toString();
                                                  askForName =
                                                  textModel.first.askForName!;
                                                  labTestDate.text = "";
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        StatefulBuilder(
                                                          builder: (BuildContext context,
                                                              void Function(
                                                                  void Function())
                                                              setState) =>
                                                              AlertDialog(
                                                                contentPadding:
                                                                EdgeInsets.all(0),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                    Radius.circular(18),
                                                                  ),
                                                                ),
                                                                content: Container(
                                                                  width: D.W / 1.25,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.start,
                                                                    mainAxisSize:
                                                                    MainAxisSize.min,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.only(
                                                                            top: D.W / 40,
                                                                            right:
                                                                            D.W / 40),
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
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize:
                                                                                D.H / 38,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w600),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height: D.H / 60),
                                                                      Container(
                                                                        height: 1,
                                                                        color:
                                                                        ColorConstants.line,
                                                                      ),
                                                                      SizedBox(
                                                                          height: D.H / 60),
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.only(
                                                                            left: D.W / 18,
                                                                            right:
                                                                            D.W / 18),
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
                                                                      SizedBox(
                                                                          height: D.H / 240),
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.only(
                                                                            left: D.W / 18,
                                                                            right:
                                                                            D.W / 18),
                                                                        child: Container(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              left:
                                                                              D.W / 30,
                                                                              right:
                                                                              D.W / 60),
                                                                          width: MediaQuery.of(
                                                                              context)
                                                                              .size
                                                                              .width,
                                                                          decoration: BoxDecoration(
                                                                              color:
                                                                              Colors.white,
                                                                              border: Border.all(
                                                                                  color: ColorConstants
                                                                                      .border),
                                                                              borderRadius: BorderRadius
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
                                                                                color: Colors
                                                                                    .black),
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
                                                                                .map(
                                                                                    (items) {
                                                                                  return DropdownMenuItem(
                                                                                    value: items
                                                                                        .testType,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets
                                                                                          .only(
                                                                                          left:
                                                                                          10),
                                                                                      child: Text(
                                                                                        items
                                                                                            .testType
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
                                                                            onChanged: (String?
                                                                            value) {
                                                                              setState(() {
                                                                                _choosenLabValue =
                                                                                    value;
                                                                                var textModel = testResultTypesData.where(
                                                                                        (element) =>
                                                                                    element
                                                                                        .testType ==
                                                                                        _choosenLabValue);
                                                                                showFormField = textModel.first.shortCodeType;
                                                                                askForName = textModel.first.askForName!;
                                                                                for (int i = 0;
                                                                                i < testResultTypesData.length; i++) {
                                                                                  if (testResultTypesData[i].testType == _choosenLabValue) {
                                                                                    testTypeId = testResultTypesData[i].testTypeId!;
                                                                                    print("dropdownvalueId:" + testTypeId.toString());
                                                                                  }
                                                                                }
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height: D.H / 60),
                                                                      askForName
                                                                          ? Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left: D.W /
                                                                                18,
                                                                            right: D.W /
                                                                                18),
                                                                        child: Text(
                                                                          "Enter Test Name",
                                                                          style: GoogleFonts.heebo(
                                                                              fontSize:
                                                                              D.H /
                                                                                  52,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .w400),
                                                                        ),
                                                                      )
                                                                          : Container(),
                                                                      askForName
                                                                          ? SizedBox(
                                                                          height: D.H / 240)
                                                                          : Container(),
                                                                      askForName
                                                                          ? Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left: D.W /
                                                                                18,
                                                                            right: D.W /
                                                                                18),
                                                                        child:
                                                                        CustomWhiteTextFormField(
                                                                          controller:
                                                                          tasteNameController,
                                                                          readOnly: false,
                                                                          validators:
                                                                              (e) {
                                                                            if (tasteNameController
                                                                                .text ==
                                                                                null ||
                                                                                tasteNameController
                                                                                    .text ==
                                                                                    '') {
                                                                              return '*Enter test nname';
                                                                            }
                                                                          },
                                                                          keyboardTYPE:
                                                                          TextInputType
                                                                              .text,
                                                                          obscured: false,
                                                                          maxlength: 100,
                                                                          maxline: 1,
                                                                        ),
                                                                      )
                                                                          : Container(),
                                                                      askForName
                                                                          ? SizedBox(
                                                                          height: D.H / 240)
                                                                          : Container(),
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.only(
                                                                            left: D.W / 18,
                                                                            right:
                                                                            D.W / 18),
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
                                                                      SizedBox(
                                                                          height: D.H / 240),
                                                                      showFormField == "Textbox"
                                                                          ? Padding(
                                                                        padding: EdgeInsets
                                                                            .only(
                                                                            left: D.W /
                                                                                18,
                                                                            right: D.W /
                                                                                18),
                                                                        child:
                                                                        CustomWhiteTextFormField(
                                                                          controller:
                                                                          valueController,
                                                                          readOnly: false,
                                                                          validators:
                                                                              (e) {
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
                                                                          TextInputType
                                                                              .number,
                                                                          obscured: false,
                                                                          maxlength: 100,
                                                                          maxline: 1,
                                                                        ),
                                                                      )
                                                                          : showFormField ==
                                                                          "Radiobutton"
                                                                          ? Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left: D.W /
                                                                                18,
                                                                            right: D.W /
                                                                                18),
                                                                        child:
                                                                        Container(
                                                                          child: Row(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              InkWell(
                                                                                child:
                                                                                Container(
                                                                                  height:
                                                                                  D.W / 22,
                                                                                  width:
                                                                                  D.W / 22,
                                                                                  decoration:
                                                                                  new BoxDecoration(
                                                                                    color: isPositive ? ColorConstants.primaryBlueColor : ColorConstants.innerColor,
                                                                                    shape: BoxShape.circle,
                                                                                    border: Border.all(
                                                                                      width: 2,
                                                                                      color: Colors.white,
                                                                                      style: BorderStyle.solid,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onTap:
                                                                                    () {
                                                                                  setState(() {
                                                                                    isPositive = true;
                                                                                    positiveOrnegative = 1;
                                                                                    valueController.text = positiveOrnegative.toString();
                                                                                  });
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                  width:
                                                                                  D.W / 60),
                                                                              Text(
                                                                                "(+) Positive",
                                                                                style: GoogleFonts.roboto(
                                                                                    fontSize: 14,
                                                                                    color: Colors.black),
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                29,
                                                                              ),
                                                                              InkWell(
                                                                                child:
                                                                                Container(
                                                                                  height:
                                                                                  D.W / 19,
                                                                                  width:
                                                                                  D.W / 19,
                                                                                  decoration:
                                                                                  new BoxDecoration(
                                                                                    color: isPositive ? ColorConstants.innerColor : ColorConstants.primaryBlueColor,
                                                                                    shape: BoxShape.circle,
                                                                                    border: Border.all(
                                                                                      width: 2,
                                                                                      color: Colors.white,
                                                                                      style: BorderStyle.solid,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onTap:
                                                                                    () {
                                                                                  setState(() {
                                                                                    isPositive = false;
                                                                                    positiveOrnegative = 0;
                                                                                    valueController.text = positiveOrnegative.toString();
                                                                                  });
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                  width:
                                                                                  D.W / 60),
                                                                              Text(
                                                                                "(-) Negative",
                                                                                style: GoogleFonts.roboto(
                                                                                    fontSize: 14,
                                                                                    color: Colors.black),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                          : Container(),
                                                                      SizedBox(
                                                                          height: D.H / 40),
                                                                      Padding(
                                                                        padding:
                                                                        EdgeInsets.only(
                                                                            left: D.W / 18,
                                                                            right:
                                                                            D.W / 18),
                                                                        child: Container(
                                                                          width: D.W / 2.9,
                                                                          child:
                                                                          CustomDateField(
                                                                            onTap: () {
                                                                              FocusManager
                                                                                  .instance
                                                                                  .primaryFocus
                                                                                  ?.unfocus();
                                                                              _selectDateSE(
                                                                                  context,
                                                                                  labTestDate,
                                                                                  eDate);
                                                                            },
                                                                            controller:
                                                                            labTestDate,
                                                                            iconPath:
                                                                            "assets/images/ic_date.svg",
                                                                            readOnly: true,
                                                                            validators: (e) {
                                                                              if (labTestDate
                                                                                  .text ==
                                                                                  null ||
                                                                                  labTestDate
                                                                                      .text ==
                                                                                      '') {
                                                                                return '*Please enter Date';
                                                                              }
                                                                            },
                                                                            keyboardTYPE:
                                                                            TextInputType
                                                                                .text,
                                                                            obscured: false,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height: 1,
                                                                        color:
                                                                        ColorConstants.line,
                                                                      ),
                                                                      SizedBox(
                                                                          height: D.H / 80),
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
                                                                              } else if (askForName==false && showFormField!="Radiobutton" && valueController.text.isEmpty) {
                                                                                CommonUtils.showRedToastMessage("Please add Value");
                                                                              } else if (labTestDate
                                                                                  .text
                                                                                  .isEmpty) {
                                                                                CommonUtils
                                                                                    .showRedToastMessage(
                                                                                    "Please enter date");
                                                                              } else if (askForName &&
                                                                                  tasteNameController
                                                                                      .text
                                                                                      .isEmpty) {
                                                                                CommonUtils
                                                                                    .showRedToastMessage(
                                                                                    "Please enter TasteName");
                                                                              } else {
                                                                                if(valueController.text.isEmpty){
                                                                                  isPositive = true;
                                                                                  positiveOrnegative = 1;
                                                                                  valueController.text = positiveOrnegative.toString();

                                                                                }
                                                                                saveTestResult();
                                                                              }
                                                                            },
                                                                            child: Text(
                                                                              "OK",
                                                                              style: GoogleFonts.heebo(
                                                                                  fontSize:
                                                                                  D.H / 33,
                                                                                  color: ColorConstants
                                                                                      .skyBlue,
                                                                                  fontWeight:
                                                                                  FontWeight
                                                                                      .w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height: D.H / 80),
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
                                      _labScreenResponseModelodel.testResults!.isEmpty
                                          ? Container()
                                          : Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          ListView.builder(
                                              itemCount:
                                              _labScreenResponseModelodel
                                                  .testResults!.length,
                                              shrinkWrap: true,
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                List<TestResults> tt = [];
                                                tt.add(_labScreenResponseModelodel
                                                    .testResults![index]);
                                                var mymils =
                                                    tt[0].values![0].created;
                                                var mydt = DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                    mymils!);
                                                tt.add(_labScreenResponseModelodel
                                                    .testResults![index]);
                                                var myd24 =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(mydt);
                                                return InkWell(
                                                  onTap: () {
                                                    showLabDialouge(
                                                        name:
                                                        _labScreenResponseModelodel
                                                            .testResults![
                                                        index]
                                                            .testResultName
                                                            .toString(),
                                                        values:
                                                        _labScreenResponseModelodel
                                                            .testResults![
                                                        index]);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: D.W / 40.0,
                                                        top: D.H / 80),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Card(
                                                                      color: ColorConstants
                                                                          .bgImage,
                                                                      shape:
                                                                      const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .only(
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
                                                                      elevation:
                                                                      0,
                                                                      child:
                                                                      Container(
                                                                        height:
                                                                        D.W /
                                                                            8,
                                                                        width:
                                                                        D.W /
                                                                            8,
                                                                        child:
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.all(D.W /
                                                                              60),
                                                                          child: Image.asset(
                                                                              "assets/images/graph.png"),
                                                                        ),
                                                                      )),
                                                                  SizedBox(
                                                                    width:
                                                                    D.W / 50,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        _labScreenResponseModelodel
                                                                            .testResults![
                                                                        index]
                                                                            .testResultName
                                                                            .toString(),
                                                                        style: GoogleFonts.heebo(
                                                                            fontSize: D.H /
                                                                                52,
                                                                            fontWeight:
                                                                            FontWeight.w400),
                                                                      ),
                                                                      /*Text(
                                                            "${_labScreenResponseModelodel.medications![index].dosage! + " " + "${_labScreenResponseModelodel.medications![index].dosageType! + " "}" + "${_labScreenResponseModelodel.medications![index].frequencyType}"}",
                                                            // "Hil 250 mg 2/Day",
                                                            style: GoogleFonts.heebo(
                                                                color: ColorConstants
                                                                    .blueBtn,
                                                                fontSize: D.H /
                                                                    66,
                                                                fontWeight:
                                                                FontWeight.w500),
                                                          ),*/
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Last Updated : ",
                                                                            style: GoogleFonts.heebo(
                                                                                color: ColorConstants.darkText,
                                                                                fontSize: D.H / 66,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 2.0,
                                                                                top: 2.0),
                                                                            child:
                                                                            Text(
                                                                              myd24.toString(),
                                                                              style: GoogleFonts.heebo(
                                                                                  color: ColorConstants.darkText,
                                                                                  fontSize: D.H / 66,
                                                                                  fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: D.H / 80,
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 4.0,
                                                                right: 4.0),
                                                            child: Container(
                                                              height: 1.0,
                                                              color:
                                                              ColorConstants
                                                                  .lineColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(right: 8.0),
                                            child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4))),
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LabListScreen())).then(
                                                              (value) {
                                                            getLabScreenApiWithoutPop();
                                                          });
                                                    },
                                                    child: Text(
                                                      "See more",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: ColorConstants
                                                              .skyBlue),
                                                    ))),
                                          ),
                                          SizedBox(
                                            height: D.H / 40,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.white,
                      child: ExpansionWidget(
                          initiallyExpanded: false,
                          titleBuilder:
                              (double animationValue, _, bool isExpaned, toogleFunction) {
                            return InkWell(
                                onTap: () => toogleFunction(animated: true),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                            "Fitness",
                                            style: GoogleFonts.heebo(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),),
                                      Transform.rotate(
                                        angle: math.pi * animationValue / 2,
                                        child: Icon(Icons.arrow_right, size: 40),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  ),
                                ));
                          },
                          content: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Card(
                                  color: Colors.white,
                                  elevation: 2,
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
                                              top: D.W / 30.0,
                                              left: D.W / 30.0,
                                              bottom: D.W / 30.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5.0),
                                                child: Text(
                                                  "Supplements",
                                                  style: GoogleFonts.heebo(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddSupplementsScreen()))
                                                        .then((value) {
                                                      getLabScreenApiWithoutPop();
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      "assets/images/ic_add_plus.svg"))
                                            ],
                                          ),
                                        ),
                                        _labScreenResponseModelodel.supplements!.isEmpty
                                            ? Container()
                                            : Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            ListView.builder(
                                                itemCount:
                                                _labScreenResponseModelodel
                                                    .supplements!.length,
                                                shrinkWrap: true,
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  var millis =
                                                      _labScreenResponseModelodel
                                                          .supplements![index]
                                                          .startDate;
                                                  var dt = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                      millis!);
                                                  var d24 = DateFormat(
                                                      'dd/MM/yyyy')
                                                      .format(
                                                      dt); // 31/12/2000, 22:00

                                                  var userName = getUserName!
                                                      .firstName
                                                      .toString();
                                                  var date = d24.toString();
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        left: D.W / 40.0,
                                                        top: D.H / 80),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Card(
                                                                      color: ColorConstants
                                                                          .bgImage,
                                                                      shape:
                                                                      const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .only(
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
                                                                      elevation:
                                                                      0,
                                                                      child:
                                                                      Padding(
                                                                        padding: EdgeInsets
                                                                            .all(D.W /
                                                                            60),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                            "assets/images/ic_bowl.svg"),
                                                                      )),
                                                                  SizedBox(
                                                                    width:
                                                                    D.W / 50,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        _labScreenResponseModelodel
                                                                            .supplements![
                                                                        index]
                                                                            .supplementName
                                                                            .toString(),
                                                                        style: GoogleFonts.heebo(
                                                                            fontSize: D.H /
                                                                                52,
                                                                            fontWeight:
                                                                            FontWeight.w400),
                                                                      ),
                                                                      Text(
                                                                        _labScreenResponseModelodel.supplements![index].dosage!.toString(),
                                                                        style: GoogleFonts.heebo(
                                                                            color: ColorConstants
                                                                                .blueBtn,
                                                                            fontSize: D.H /
                                                                                66,
                                                                            fontWeight:
                                                                            FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right: D.W /
                                                                        30),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
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
                                                                              BorderRadius.all(Radius.circular(25)),
                                                                              color: ColorConstants.lightRed),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                          3,
                                                                        ),
                                                                        Text(
                                                                          _labScreenResponseModelodel
                                                                              .supplements![index]
                                                                              .withFoodId
                                                                              .toString()=="1"?"With Food":_labScreenResponseModelodel
                                                                              .supplements![index]
                                                                              .withFoodId
                                                                              .toString()=="2"?"Before":_labScreenResponseModelodel
                                                                              .supplements![index]
                                                                              .withFoodId
                                                                              .toString()=="3"?"After":"N/A",
                                                                          style: GoogleFonts.heebo(
                                                                              color:
                                                                              Colors.black.withOpacity(0.3)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      date.toString(),
                                                                      style: GoogleFonts.heebo(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.3)),
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
                                                            const EdgeInsets
                                                                .only(
                                                                left: 4.0,
                                                                right: 4.0),
                                                            child: Container(
                                                              height: 1.0,
                                                              color:
                                                              ColorConstants
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
                                                    color: Colors.blue
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4))),
                                                child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SupplimentScreen())).then(
                                                              (value) {
                                                            getLabScreenApiWithoutPop();
                                                          });
                                                    },
                                                    child: Text(
                                                      "See more",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: ColorConstants
                                                              .skyBlue),
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
                                  elevation: 2,
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
                                              top: D.W / 30.0,
                                              left: D.W / 30.0,
                                              bottom: D.W / 30.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(left: 5.0),
                                                child: Text(
                                                  "Height and Weight",
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
                                                            builder: (BuildContext context,
                                                                void Function(
                                                                    void Function())
                                                                setState) =>
                                                                AlertDialog(
                                                                  contentPadding:
                                                                  EdgeInsets.all(0),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.all(
                                                                      Radius.circular(18),
                                                                    ),
                                                                  ),
                                                                  content: Container(
                                                                    width: D.W / 1.25,
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.start,
                                                                      mainAxisSize:
                                                                      MainAxisSize.min,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              top: D.W / 40,
                                                                              right:
                                                                              D.W / 40),
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
                                                                              "Add Height Weight",
                                                                              style: GoogleFonts.heebo(
                                                                                  fontSize:
                                                                                  D.H / 38,
                                                                                  fontWeight:
                                                                                  FontWeight
                                                                                      .w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Container(
                                                                          height: 1,
                                                                          color:
                                                                          ColorConstants.line,
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Padding(
                                                                          padding:
                                                                          EdgeInsets.only(
                                                                              left: D.W / 18,
                                                                              right:
                                                                              D.W / 18),
                                                                          child: Text(
                                                                            "Height",
                                                                            style:
                                                                            GoogleFonts.heebo(
                                                                                fontSize:
                                                                                D.H / 52,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w400),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 240),
                                                                        Padding(
                                                                          padding: EdgeInsets
                                                                              .only(
                                                                              left: D.W /
                                                                                  18,
                                                                              right: D.W /
                                                                                  18),
                                                                          child:
                                                                          CustomWhiteTextFormField(
                                                                            controller:
                                                                            heightController,
                                                                            readOnly: false,
                                                                            validators:
                                                                                (e) {
                                                                              if (heightController
                                                                                  .text ==
                                                                                  null ||
                                                                                  heightController
                                                                                      .text ==
                                                                                      '') {
                                                                                return '*Value';
                                                                              }
                                                                            },
                                                                            keyboardTYPE:
                                                                            TextInputType
                                                                                .number,
                                                                            obscured: false,
                                                                            maxlength: 100,
                                                                            maxline: 1,
                                                                          ),),
                                                                        SizedBox(
                                                                            height: D.H / 60),
                                                                        Padding(
                                                                          padding: EdgeInsets
                                                                              .only(
                                                                              left: D.W /
                                                                                  18,
                                                                              right: D.W /
                                                                                  18),
                                                                          child: Text(
                                                                            "Weight",
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize:
                                                                                D.H /
                                                                                    52,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w400),
                                                                          ),
                                                                        )
                                                                        ,
                                                                        SizedBox(
                                                                            height: D.H / 240),
                                                                        Padding(
                                                                          padding: EdgeInsets
                                                                              .only(
                                                                              left: D.W /
                                                                                  18,
                                                                              right: D.W /
                                                                                  18),
                                                                          child:
                                                                          CustomWhiteTextFormField(
                                                                            controller:
                                                                            weightController,
                                                                            readOnly: false,
                                                                            validators:
                                                                                (e) {
                                                                              if (weightController
                                                                                  .text ==
                                                                                  null ||
                                                                                  weightController
                                                                                      .text ==
                                                                                      '') {
                                                                                return '*Value';
                                                                              }
                                                                            },
                                                                            keyboardTYPE:
                                                                            TextInputType
                                                                                .number,
                                                                            obscured: false,
                                                                            maxlength: 100,
                                                                            maxline: 1,
                                                                          ),),
                                                                        SizedBox(
                                                                            height: D.H / 40),
                                                                        Container(
                                                                          height: 1,
                                                                          color:
                                                                          ColorConstants.line,
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 80),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                if (heightController.text.isEmpty) {
                                                                                  CommonUtils
                                                                                      .showRedToastMessage(
                                                                                      "Please Enter Height");
                                                                                } else if (weightController.text.isEmpty) {
                                                                                  CommonUtils.showRedToastMessage("Please add Weight");

                                                                                } else {
                                                                                  saveHeightWeightResult();
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                "OK",
                                                                                style: GoogleFonts.heebo(
                                                                                    fontSize:
                                                                                    D.H / 33,
                                                                                    color: ColorConstants
                                                                                        .skyBlue,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .w400),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height: D.H / 80),
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
                                        _labScreenResponseModelodel.heighWeightResponse!.isEmpty
                                            ? Container()
                                            : Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            ListView.builder(
                                                itemCount:
                                                _labScreenResponseModelodel
                                                    .heighWeightResponse!.length,
                                                shrinkWrap: true,
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  var millis =
                                                      _labScreenResponseModelodel
                                                          .heighWeightResponse![index]
                                                          .changedDate;
                                                  var dt = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                      millis!);
                                                  var d24 = DateFormat(
                                                      'dd/MM/yyyy')
                                                      .format(
                                                      dt); // 31/12/2000, 22:00

                                                  var userName = getUserName!
                                                      .firstName
                                                      .toString();
                                                  var date = d24.toString();
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                        left: D.W / 40.0,
                                                        top: D.H / 80),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Card(
                                                                      color: ColorConstants
                                                                          .bgImage,
                                                                      shape:
                                                                      const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .only(
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
                                                                      elevation:
                                                                      0,
                                                                      child:
                                                                      Padding(
                                                                        padding: EdgeInsets
                                                                            .all(D.W /
                                                                            60),
                                                                        child: SvgPicture
                                                                            .asset(
                                                                            "assets/images/ic_bowl.svg"),
                                                                      )),
                                                                  SizedBox(
                                                                    width:
                                                                    D.W / 50,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Height:",
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize: D.H /
                                                                                    56,
                                                                                fontWeight:
                                                                                FontWeight.w300),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                            D.W / 70,
                                                                          ),
                                                                          Text(
                                                                            _labScreenResponseModelodel
                                                                                .heighWeightResponse![
                                                                            index]
                                                                                .height
                                                                                .toString()+"cm",
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize: D.H /
                                                                                    52,
                                                                                fontWeight:
                                                                                FontWeight.w400),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Weight:",
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize: D.H /
                                                                                    56,
                                                                                fontWeight:
                                                                                FontWeight.w300),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                            D.W / 70,
                                                                          ),
                                                                          Text(
                                                                            _labScreenResponseModelodel
                                                                                .heighWeightResponse![
                                                                            index]
                                                                                .weight
                                                                                .toString()+"kg",
                                                                            style: GoogleFonts.heebo(
                                                                                fontSize: D.H /
                                                                                    52,
                                                                                fontWeight:
                                                                                FontWeight.w400),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right: D.W /
                                                                        30),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [

                                                                    Text(
                                                                      date.toString(),
                                                                      style: GoogleFonts.heebo(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.3)),
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
                                                            const EdgeInsets
                                                                .only(
                                                                left: 4.0,
                                                                right: 4.0),
                                                            child: Container(
                                                              height: 1.0,
                                                              color:
                                                              ColorConstants
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
                                           /* Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(4))),
                                                child: TextButton(
                                                    onPressed: () {
                                                      *//*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MedicationScreen())).then(
                                                  (value) {
                                                getLabScreenApiWithoutPop();
                                              });*//*
                                                    },
                                                    child: Text(
                                                      "See more",
                                                      style: GoogleFonts.heebo(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: ColorConstants
                                                              .skyBlue),
                                                    ))),*/
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
                                  height: 8,
                                ),
                              ],
                            ),
                          )),
                    ),

                  ],
                ),
              )
              : Container(),
        ));
  }

  showDialouge({
    required String name,
    required Imagine imagine,
    required int? id,
    required int? index,
  }) {
    int activePage = 0;

    PageController _pageController =
        PageController(viewportFraction: 1, initialPage: 0);
    List<Widget> indicators(imagesLength, currentIndex) {
      return List<Widget>.generate(imagesLength, (index) {
        return Container(
          margin: EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: currentIndex == index
                  ? ColorConstants.primaryBlueColor
                  : Colors.white,
              shape: BoxShape.circle),
        );
      });
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                    void Function(void Function()) setState) =>
                Dialog(
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
                                "",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                imagine.imageType.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Expanded(child: Container()),
                              InkWell(
                                onTap: () {
                                  deleteImagine(
                                      _labScreenResponseModelodel
                                          .imagine![index!.toInt()]
                                          .usersImagineId!
                                          .toInt(),
                                      index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: SvgPicture.asset(
                                    "assets/images/ic_delete.svg",
                                    height: 20,
                                    width: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  name,
                                  style: GoogleFonts.heebo(
                                      color: ColorConstants.light,
                                      fontSize: 14),
                                ),
                              ),
                            ],
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
                                    itemBuilder: (context, pagePosition) {
                                      return Container(
                                          height: 340,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              child: CachedNetworkImage(
                                                height: 120,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                                imageUrl: imagine
                                                    .media![pagePosition]
                                                    .mediaFileName
                                                    .toString(),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
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
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )));
                                    }),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: indicators(
                                        imagine.media!.length, activePage))
                              ],
                            ),
                          ),
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
                          style: GoogleFonts.heebo(
                              color: Colors.blue, fontSize: 25),
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

  showLabDialouge({
    required String name,
    required TestResults values,
  }) {
    List<TestResults> tempList = [];
    tempList.add(values);
    if (tempList[0].values![0].testResultValue == "0" ||
        tempList[0].values![0].testResultValue == "1") {
      var mymils = tempList[0].values![0].testDate;
      var mydt = DateTime.fromMillisecondsSinceEpoch(mymils!);
      var myd24 = DateFormat('dd/MM/yyyy').format(mydt);

      AwesomeDialog(
        context: context,
        dialogType: DialogType.noHeader,
        customHeader: Container(
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tempList[0].values![0].testResultValue == "0"?Colors.green:Colors.red,
          ),
          child: Center(
              child: Text(
                tempList[0].values![0].testResultValue == "0"?"-":"+",
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
          )),
        ),
        body: Container(
          width: 350,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Text(
                tempList[0].values![0].testResultType.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Date: $myd24",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        title: 'This is Ignored',
        desc: 'This is also Ignored',
      ).show();
      // AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.info,
      //   borderSide:  BorderSide(
      //     color:tempList[0].values![0].testResultValue=="0"?Colors.red: Colors.green,
      //     width: 2,
      //   ),
      //   width: 350,
      //
      //   buttonsBorderRadius: const BorderRadius.all(
      //     Radius.circular(2),
      //   ),
      //   dismissOnTouchOutside: true,
      //   dismissOnBackKeyPress: false,
      //   onDismissCallback: (type) {
      //
      //   },
      //   headerAnimationLoop: false,
      //   animType: AnimType.bottomSlide,
      //   title: (tempList[0].values![0].testResultType.toString()),
      //   desc: 'This Dialog can be dismissed touching outside',
      //   showCloseIcon: true,
      //   btnCancelOnPress: () {},
      //   btnOkOnPress: () {},
      // ).show();

    } else {

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context,
                      void Function(void Function()) setState) =>
                  Dialog(
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
                                  name.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    name,
                                    style: GoogleFonts.heebo(
                                        color: ColorConstants.light,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            Container(
                              height: 350,
                              child: GraphWidget(graphList: tempList),
                            ),
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
                            style: GoogleFonts.heebo(
                                color: Colors.blue, fontSize: 25),
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
      setState(() {});
      CommonUtils.hideProgressDialog(context);
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
      setState(() {
        _labScreenResponseModelodel = LabScreenResponseModel.fromJson(res);

        setState(() {});
        CommonUtils.hideProgressDialog(context);

        Navigator.pop(context);
        setState(() {});
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> getLabScreenApiWithoutPop() async {
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
      // CommonUtils.hideProgressDialog(context);

      setState(() {});
    } else {}
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
            testType: res[i]["testType"],
            testTypeId: res[i]["testTypeId"],
            sequence: res[i]["sequence"],
            askForName: res[i]["askForName"],
            shortCodeType: res[i]["shortCodeType"],
            shortCodeTypeId: res[i]["shortCodeTypeId"]));
      }
      print("testResultTypesData" + testResultTypesData.toString());
      testTypeId = testResultTypesData[0].testTypeId!;
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
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
            imageTypeId: res[i]["imageTypeId"],
            askForName: res[i]["askForName"],
            sequence: res[i]["sequence"]));
      }
      print("imageTypesData" + imageTypesData.toString());
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
      "testResultName": tasteNameController.text,
      "testResultValue": valueController.text.toString(),
      "testDate": eDate,
    };
    //1657650600000

    var mydtStart = DateTime.fromMillisecondsSinceEpoch(eDate.toInt());
    var myd24Start = DateFormat('dd/MM/yyyy').format(mydtStart);

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
      setState(() {});
      getLabScreenApiWithoutLoader();
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> saveHeightWeightResult() async {
    FocusManager.instance.primaryFocus?.unfocus();
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.update_height_weight;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "height": heightController.text.toString(),
      "weight": weightController.text.toString(),
    };
    //1657650600000

    var mydtStart = DateTime.fromMillisecondsSinceEpoch(eDate.toInt());
    var myd24Start = DateFormat('dd/MM/yyyy').format(mydtStart);

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
      setState(() {});
      getLabScreenApiWithoutLoader();
    } else {
      CommonUtils.hideProgressDialog(context);
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
    if (imagineNameController.text.isNotEmpty ||
        imagineNameController.text != "") {
      request.fields['ImagineName'] = imagineNameController.text;
    } else {
      request.fields['ImagineName'] = "";
    }
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
      FocusManager.instance.primaryFocus?.unfocus();
      getLabScreenApiWithoutLoader();
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(responseData["message"]);
    }
  }

  Future<void> _selectDateSE(
      BuildContext context, final controller, int Date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yy');
        final String startDate = formatter.format(picked);
        controller.text = startDate.toString();
        final DateFormat formatter2 = DateFormat('dd-MM-yyy');
        final String sDatee = formatter2.format(picked);
        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(sDatee);
        eDate = dateTimeFormat.millisecondsSinceEpoch;
        print("Date:" + Date.toString());
      });
    }
  }

  Future<void> _selectDateForHW(
      BuildContext context, final controller, int Date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yy');
        final String startDate = formatter.format(picked);
        controller.text = startDate.toString();
        final DateFormat formatter2 = DateFormat('dd-MM-yyy');
        final String sDatee = formatter2.format(picked);
        var dateTimeFormat = DateFormat('dd-MM-yyy').parse(sDatee);
        hwDate = dateTimeFormat.millisecondsSinceEpoch;
        print("Date:" + Date.toString());
      });
    }
  }

  Future<void> deleteTestResult(var id, int index) async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.deleteTestResults;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersTestResultId": id,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await delete(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      CommonUtils.showGreenToastMessage(res["message"]);
      _labScreenResponseModelodel.testResults?.removeAt(index);
      CommonUtils.hideProgressDialog(context);

      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
      CommonUtils.hideProgressDialog(context);
    }
  }

  Future<void> deleteImagine(int id, int index) async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.deleteImagine;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersImagineId": id,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await delete(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var res = jsonDecode(responseBody);
    if (statusCode == 200) {
      CommonUtils.showGreenToastMessage(res["message"]);
      _labScreenResponseModelodel.imagine?.removeAt(index);
      CommonUtils.hideProgressDialog(context);
      Navigator.pop(context);
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
      CommonUtils.hideProgressDialog(context);
    }
  }
}
