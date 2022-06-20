import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CustomWidgets/custom_textform_field.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../customWidgets/custom_big_textform_field.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_date_field.dart';
import '../../customWidgets/custom_white_textform_field.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'otp_screen.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var _selectedFood = "after";
  String? _chosenValue;
  final commentController = TextEditingController();
  final valueController = TextEditingController();
  final discController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24.0,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(height: 10,),
            Text(
              "Comments",
              style: GoogleFonts.heebo(
                  fontSize: D.H / 44, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            child: SvgPicture.asset(
              "assets/images/ic_plus.svg",
            ),
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  content: Container(
                    width: D.W / 1.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: D.W/40,right: D.W/40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.close,
                                size: D.W / 20,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Comment",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 38,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: D.H / 40),
                        Padding(
                          padding: EdgeInsets.only(left: D.W/18,right: D.W/18),
                          child: Text(
                            "Body Parts",
                            style: GoogleFonts.heebo(
                                fontSize: D.H / 52, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: D.H / 120),
                        Padding(
                          padding: EdgeInsets.only(left: D.W/18,right: D.W/18),
                          child: Container(
                            padding:
                            EdgeInsets.only(left: D.W / 30, right: D.W / 60),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: ColorConstants.border),
                                borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              focusColor: Colors.white,
                              value: _chosenValue,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: ColorConstants.lightGrey,
                              icon: Icon(Icons.arrow_drop_down_sharp),
                              iconSize: 32,
                              underline: Container(color: Colors.transparent),
                              items: <String>[
                                'Abc',
                                'Bcd',
                                'Cde',
                                'Def',
                                'Efg',
                                'Fgh',
                                'Ghi',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Type",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: D.H / 48,
                                    fontWeight: FontWeight.w400),
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
                          padding: EdgeInsets.only(left: D.W/18,right: D.W/18),
                          child: Text(
                            "Comments",
                            style: GoogleFonts.heebo(
                                fontSize: D.H / 52, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: D.H / 120),
                        Padding(
                          padding: EdgeInsets.only(left: D.W/18,right: D.W/18),
                          child: CustomWhiteTextFormField(
                            maxlength: 3,
                            controller: commentController,
                            readOnly: false,
                            maxline: 3,
                            validators: (e) {
                              if (commentController.text == null ||
                                  commentController.text == '') {
                                return '*Comments';
                              }
                            },
                            keyboardTYPE: TextInputType.text,
                            obscured: false,
                          ),
                        ),
                        SizedBox(height: D.H / 60),
                        Container(height: 1,color: ColorConstants.line,),
                        SizedBox(height: D.H / 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "OK",
                              style: GoogleFonts.heebo(
                                  fontSize: D.H / 33,
                                  color: ColorConstants.skyBlue,
                                  fontWeight: FontWeight.w400),
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
          ),
          Container(
            width: D.W / 36,
          )
        ],
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
      ),
      backgroundColor: ColorConstants.background,
      body: Container(
        height: D.H,
        child: Padding(
          padding:
              EdgeInsets.only(left: D.W / 22, right: D.W / 22, top: D.H / 30),
          child: Card(
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
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: D.W / 30.0, top: D.H / 80),
                            child: Row(
                              children: [
                                Card(
                                    color: ColorConstants.bgImage,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    elevation: 0,
                                    child: Padding(
                                      padding: EdgeInsets.all(D.W / 42),
                                      child: SvgPicture.asset(
                                          "assets/images/ic_message.svg"),
                                    )),
                                SizedBox(width: D.H / 80),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Chest",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 52,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Mitral valve prolapse",
                                      style: GoogleFonts.heebo(
                                          fontSize: D.H / 52,
                                          fontWeight: FontWeight.w400),
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
                                const EdgeInsets.only(left: 4.0, right: 4.0),
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
          ),
        ),
      ),
    );
  }
}
