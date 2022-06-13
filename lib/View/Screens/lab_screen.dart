import 'package:ehr/View/Screens/comment_screen.dart';
import 'package:ehr/View/Screens/medication_detail_screen.dart';
import 'package:ehr/View/Screens/medication_screen.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/color_constants.dart';
import '../../CustomWidgets/chart_widget.dart';
import '../../CustomWidgets/custom_search_bar.dart';
import '../../CustomWidgets/custom_search_bar2.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';

class LabScreen extends StatefulWidget {
  const LabScreen({Key? key}) : super(key: key);

  @override
  _LabScreenState createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen>  with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        appBar: AppBar(
          title: Text(
            "James Smith",
            style: GoogleFonts.heebo(
                fontSize: D.H / 44, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                NavigationHelpers.redirectFromSplash(context, ProfileScreen());
              },
              child: SvgPicture.asset(
                "assets/images/avatar.svg",
              ),
            ),
            Container(
              width: 10,
            )
          ],
          backgroundColor: ColorConstants.blueBtn,
          elevation: 0,
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
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                       right: D.W / 22,),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: D.W / 30.0,left: D.W / 30.0, right: D.H / 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Comments",style: GoogleFonts.heebo(fontSize:20,color: Colors.black,fontWeight: FontWeight.normal),),
                             SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  backgroundColor: ColorConstants.primaryBlueColor,
                                  child: Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],),
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
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

                            SizedBox(height: 4,),
                            Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: TextButton(
                                    onPressed: (){
                                      NavigationHelpers.redirect(context, CommentScreen());
                                    }, child: Text("See more",style: GoogleFonts.heebo(fontSize: 16,fontWeight: FontWeight.w600),))),
                            SizedBox(height: 4,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
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
                            top: D.W / 30.0,left: D.W / 30.0, right: D.H / 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Medications",style: GoogleFonts.heebo(fontSize:20,color: Colors.black,fontWeight: FontWeight.normal),),
                            SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  backgroundColor: ColorConstants.primaryBlueColor,
                                  child: Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: D.W / 22, right: D.W / 22,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ListView.builder(
                                itemCount: 3,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
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
                                                        "assets/images/ic_bowl.svg"),
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.only(left:D.H /180),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Metformin",
                                                          style: GoogleFonts.heebo(
                                                              fontSize: D.H / 52,
                                                              fontWeight: FontWeight.w400),
                                                        ),
                                                        SizedBox(width: 50,),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: D.W/24,
                                                              width: D.W/24,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                                                  color: ColorConstants.lightRed
                                                              ),
                                                            ),
                                                            SizedBox(width: 6,),
                                                            Text("Lorem Dummy",style: GoogleFonts.heebo(color: Colors.black.withOpacity(0.3)),)
                                                          ],
                                                        )

                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Hil 250 mg 2/Day",
                                                          style: GoogleFonts.heebo(
                                                              color: ColorConstants.blueBtn,
                                                              fontSize: D.H / 66,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                        SizedBox(width: 50,),
                                                        Text("27 -12-202",style: GoogleFonts.heebo(color: Colors.black.withOpacity(0.3)),)

                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/images/ic_doctor.svg"),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 2.0,top:2.0),
                                                          child: Text(
                                                            "Jhon Miler",
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
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: D.H / 80,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0,right: 4.0),
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
                            SizedBox(height: 4,),
                            Container(
                              height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: TextButton(
                                    onPressed: (){
                                      NavigationHelpers.redirect(context, MedicationScreen());
                                    }, child: Text("See more",style: GoogleFonts.heebo(fontSize: 16,fontWeight: FontWeight.w600),))),
                            SizedBox(height: 4,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5,),
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
                            top: D.W / 30.0,left: D.W / 30.0, right: D.H / 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Labs",style: GoogleFonts.heebo(fontSize:20,color: Colors.black,fontWeight: FontWeight.normal),),
                            SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  backgroundColor: ColorConstants.primaryBlueColor,
                                  child: Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],),
                      ),
                      SizedBox(
                        height: 50,
                        child: AppBar(
                          backgroundColor: Colors.white,
                          bottom: TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Text("Hemoglobin",style: GoogleFonts.heebo(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                              Tab(
                                child: Text("Blood Pressure",style: GoogleFonts.heebo(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                              Tab(
                                child: Text("Heart Rate",style: GoogleFonts.heebo(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold),),
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
                            Container(
                            ),
                            GraphWidget(),

                            // second tab bar viiew widget
                            Container(
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
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
                            top: D.W / 30.0,left: D.W / 30.0, right: D.H / 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Imaging",style: GoogleFonts.heebo(fontSize:20,color: Colors.black,fontWeight: FontWeight.normal),),
                            SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  backgroundColor: ColorConstants.primaryBlueColor,
                                  child: Icon(Icons.add),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],),
                      ),
                     Row(
                       children: [
                         Expanded(child: Column(
                           children: [
                             InkWell(
                               onTap: (){
                                 showDialouge(name: "X-ray",image: "assets/images/xray_icon.png");
                               },
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),

                                 elevation:4,child: Column(
                                 children: [
                                   Container(height:120,width:200,child: Image .asset("assets/images/xray_icon.png",fit: BoxFit.cover,)),
                                   SizedBox(height: 4,),
                                   Text("X-ray",style: GoogleFonts.heebo(fontWeight: FontWeight.normal,fontSize: 16),)
                                 ],
                               ),),
                             ),

                           ],
                         )),
                         SizedBox(width: 4,),
                         Expanded(child: Column(
                           children: [
                             InkWell(
                               onTap: (){
                                 showDialouge(name: "CT Scan",image: "assets/images/ctscan_icon.png");
                               },
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),

                                 elevation:4,child: Column(
                                 children: [
                                   Container(height:120,width:200,child: Image .asset("assets/images/ctscan_icon.png",fit: BoxFit.cover,)),
                                   SizedBox(height: 4,),
                                   Text("CT Scan",style: GoogleFonts.heebo(fontWeight: FontWeight.normal,fontSize: 16),)
                                 ],
                               ),),
                             ),

                           ],
                         )),
                         SizedBox(width: 4,),
                         Expanded(child: Column(
                           children: [
                             InkWell(
                               onTap: (){
                                 showDialouge(name: "MRI",image: "assets/images/mri_icon.png");
                               },
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15.0),
                                 ),

                                 elevation:4,child: Column(
                                 children: [
                                   Container(height:120,width:200,child: Image .asset("assets/images/mri_icon.png",fit: BoxFit.cover,)),
                                   SizedBox(height: 4,),
                                   Text("MRI",style: GoogleFonts.heebo(fontWeight: FontWeight.normal,fontSize: 16),)
                                 ],
                               ),),
                             ),

                           ],
                         )),

                       ],
                     ),
                      SizedBox(height: 9,),
                      Row(
                        children: [
                          Expanded(child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  showDialouge(name: "Hand X-ray",image: "assets/images/hand_scan_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),

                                  elevation:4,child: Column(
                                  children: [
                                    Container(height:120,width:200,child: Image .asset("assets/images/hand_scan_icon.png",fit: BoxFit.cover,)),
                                    SizedBox(height: 4,),
                                    Text("Hand X-ray",style: GoogleFonts.heebo(fontWeight: FontWeight.normal,fontSize: 16),)
                                  ],
                                ),),
                              ),

                            ],
                          )),
                          SizedBox(width: 4,),
                          Expanded(child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  showDialouge(name: "Chest X-ray",image: "assets/images/xray_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),

                                  elevation:4,child: Column(
                                  children: [
                                    Container(height:120,width:200,child: Image .asset("assets/images/xray_icon.png",fit: BoxFit.cover,)),
                                    SizedBox(height: 4,),
                                    Text("Chest X-ray",style: GoogleFonts.heebo(fontWeight: FontWeight.normal,fontSize: 16),)
                                  ],
                                ),),
                              ),

                            ],
                          )),
                          SizedBox(width: 4,),
                          Expanded(child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  showDialouge(name: "Chest X-ray",image: "assets/images/chest_xray_icon.png");
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),

                                  elevation:4,child: Column(
                                  children: [
                                    Container(height:120,width:200,child: Image .asset("assets/images/chest_xray_icon.png",fit: BoxFit.cover,)),
                                    SizedBox(height: 4,),
                                    Text("Chest X-ray",style: GoogleFonts.heebo(fontWeight: FontWeight.normal,fontSize: 16),)
                                  ],
                                ),),
                              ),

                            ],
                          )),

                        ],
                      ),
                      SizedBox(height: 12,),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  showDialouge({name,image}){
    showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(15.0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          height: 580,
          child: Column(
            children: [
              SizedBox(height: 12,),
              Row(
                children: [
                  Text(name,style:TextStyle(fontSize: 20),),

                ],
              ),
              SizedBox(height: 8,),
              Container(child:  Text("Lorem Ipsum has been the industry's standarddummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",style:GoogleFonts.heebo(color: Colors.grey,fontSize: 14),),),
              SizedBox(height: 8,),
              Container(height:350,child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: Image .asset(image,fit: BoxFit.cover,))),
              SizedBox(height: 8,),

              Container(height: 1,color: Colors.grey,),
              SizedBox(height: 8,),
              GestureDetector(

                  onTap: (){
                    Navigator.of(context).pop();
                  }, child: Text("OK",style: GoogleFonts.heebo(color: Colors.blue,fontSize: 20),))




            ],
          ),
        ),
      );
    });
  }
}
