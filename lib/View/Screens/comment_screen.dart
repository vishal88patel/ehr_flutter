
import 'dart:convert';

import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/Model/painModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../../Constants/api_endpoint.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/preferences.dart';
import 'body_detail_screen.dart';

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
  List<PainModel> painData = [];


  @override
  void initState() {

    SchedulerBinding.instance.addPostFrameCallback((_) {
      getPainData();
    });


    super.initState();
  }

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
                //Navigator.push(context, MaterialPageRoute(builder: (context) => BodyDetailScreen())).then((value) => getPainDataWithoutLoader());
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
                itemCount: painData.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          padding: EdgeInsets.all(0),
                          onPressed: (BuildContext context) {
                            setState(() {});
                            deletePain(painData[index].usersPainId,index);
                            // painData.removeAt(index);
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: Container(
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
                                      Text(painData[index].bodyPart.toString(),
                                        style: GoogleFonts.heebo(
                                            fontSize: D.H / 52,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        painData[index].description.toString(),
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
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }


  Future<void> getPainData() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getPain;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "pageNumber": 1,
      "keyword": "",
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
      for (int i = 0; i < res.length; i++) {
        painData.add(PainModel(
          usersPainId: res[i]["usersPainId"],
          bodyPartId: res[i]["bodyPartId"],
          bodyPart: res[i]["bodyPart"],
          locationX: res[i]["locationX"],
          locationY: res[i]["locationY"],
          description: res[i]["description"],
          startDate: res[i]["startDate"],
          endDate: res[i]["endDate"],
          created: res[i]["created"],

        ));
      }
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showGreenToastMessage("Data Fetched Successfully");
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> getPainDataWithoutLoader() async {
    final uri = ApiEndPoint.getPain;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "pageNumber": 1,
      "keyword": "",
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
      painData.clear();
      for (int i = 0; i < res.length; i++) {
        painData.add(PainModel(
          usersPainId: res[i]["usersPainId"],
          bodyPartId: res[i]["bodyPartId"],
          bodyPart: res[i]["bodyPart"],
          locationX: res[i]["locationX"],
          locationY: res[i]["locationY"],
          description: res[i]["description"],
          startDate: res[i]["startDate"],
          endDate: res[i]["endDate"],
          created: res[i]["created"],
        ));
      }
      CommonUtils.showGreenToastMessage("Data Fetched Successfully");
      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> deletePain(var id, int index) async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.deletePain;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersPainId": id,
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
      painData.removeAt(index);
      CommonUtils.hideProgressDialog(context);

      setState(() {});
    } else {
      CommonUtils.showRedToastMessage(res["message"]);
      CommonUtils.hideProgressDialog(context);

    }
  }
}
