import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/color_constants.dart';
import '../../CustomWidgets/custom_button.dart';
import '../../Model/qa_model.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import 'dash_board_screen.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<QAModel> questionList = [
    QAModel(category: "Ear/nose/throat", categoryId: "", subCategory: [
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: true, modelId: "1", name: "None of these"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
    ]),
    QAModel(category: "Cardivascular", categoryId: "", subCategory: [
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
    ]),
    QAModel(category: "Gentitourinary", categoryId: "", subCategory: [
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: true, modelId: "1", name: "None of these"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
    ]),
    QAModel(category: "Ear/nose/throat", categoryId: "", subCategory: [
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: true, modelId: "1", name: "None of these"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
    ]),
    QAModel(category: "Cardivascular", categoryId: "", subCategory: [
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
    ]),
    QAModel(category: "Gentitourinary", categoryId: "", subCategory: [
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: true, modelId: "1", name: "None of these"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
      SubCategory(isSelected: false, modelId: "1", name: "Lorem ispum dummy"),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 0,
        toolbarHeight: 45,
        centerTitle: true,
        title: Text(
          "Survey",
          style: GoogleFonts.heebo(
              fontSize: D.H / 44, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: questionList.length,
              padding: EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // List<String> templocalList=[];templocalList.clear();
                // for(int i=0;i<getModel.data!.length;i++){
                //   if(getBrandsResponseModel.data![index].brandId==getModel.data![i].brandId){
                //     templocalList.add(getModel.data![i].modelName.toString());
                //   }
                // }
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        questionList[index].category.toString(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: questionList[index].subCategory!.length,
                            itemBuilder: (BuildContext context, int i) {
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xFFF0F0F0),
                                    ),
                                    child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: Transform.scale(
                                          scale: 1,
                                          child: Checkbox(
                                            activeColor:
                                                ColorConstants.checkBoxColor,
                                            side: BorderSide(
                                                width: 1, color: Colors.grey),
                                            onChanged: (bool? value) async {
                                              if (value ?? false) {
                                                questionList[index]
                                                    .subCategory![i]
                                                    .isSelected = true;
                                              } else {
                                                questionList[index]
                                                    .subCategory![i]
                                                    .isSelected = false;
                                              }
                                              setState(() {});
                                            },
                                            value: questionList[index]
                                                .subCategory![i]
                                                .isSelected,
                                          ),
                                        ),
                                        horizontalTitleGap: 0,
                                        title: Text(
                                          questionList[index]
                                              .subCategory![i]
                                              .name
                                              .toString(),
                                          style: GoogleFonts.heebo(
                                              color: questionList[index]
                                                          .subCategory![i]
                                                          .isSelected ??
                                                      false
                                                  ? ColorConstants.checkBoxColor
                                                  : Colors.black,fontSize: 14,fontWeight: FontWeight.w400),
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                color: ColorConstants.blueBtn,
                onTap: () {
                  NavigationHelpers.redirectto(context, DashBoardScreen(1));
                },
                text: "Done",
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
    //
  }
}
