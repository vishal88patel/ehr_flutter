import 'package:ehr/Utils/navigation_helper.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/color_constants.dart';
import '../../Utils/dimensions.dart';
import '../../test.dart';
import 'body_detail_screen.dart';

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

class BodyScreenForTest extends StatefulWidget {
  const BodyScreenForTest({Key? key}) : super(key: key);

  @override
  _BodyScreenForTestState createState() => _BodyScreenForTestState();
}

class _BodyScreenForTestState extends State<BodyScreenForTest> {
  FlipCardController _flipCardController = FlipCardController();
  bool isFlipped = false;
  double _x = -100.0;
  double _y = -100.0;
  double _newX = 0;
  double _newY = 0;
  var mainW = 340.00;
  var mainH = 560.00;
  var _XX = 340 / 2;
  var _YY = 560 / 2;
  var totaHeight = 00;
  var totaWidth = 00;
  var head=false;
  var removableHieght = 0.00;
  List<Offset> offsetList = [];
  final GlobalKey key = GlobalKey();

  List<Widget> widgetList = [
    // Container(
    //   height: 560,
    //   width: 340,
    //   child: Image.asset(
    //     "assets/images/backtestbody.png",
    //     fit: BoxFit.cover,
    //   ),
    // ),
  ];

  @override
  void initState() {
    super.initState();
  }
  void getPainApi(){
    _newY=2;
    _newX=2;
    if( _newY==2 && _newX==2 ){
      head=true;
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    totaHeight = 00;
    MediaQuery.of(context).size.height;
    totaWidth = 00;
    MediaQuery.of(context).size.width;
    removableHieght = 56 + MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlueColor,
        elevation: 0,
        toolbarHeight: 45,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Home",
              style: GoogleFonts.heebo(fontWeight: FontWeight.normal),
            ),
          ],
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
      body:BoundaryTest(),

      /*Padding(
        key: key,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Diagnosis History",
                  style: GoogleFonts.heebo(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    if (isFlipped) {
                      isFlipped = false;
                      _flipCardController.toggleCard();
                      setState(() {});
                    } else {
                      isFlipped = true;
                      _flipCardController.toggleCard();
                      setState(() {});
                    }
                  },
                  child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.primaryBlueColor,
                            //                   <--- border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      height: 50,
                      child: Center(
                          child: Text(
                        isFlipped ? "Frontside" : "Backside",
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.primaryBlueColor),
                      ))),
                ),
              ],
            ),
            Container(
              child: GestureDetector(
                child: FlipCard(
                  flipOnTouch: false,
                  fill: Fill.fillBack,
                  controller: _flipCardController,
                  direction: FlipDirection.HORIZONTAL,
                  front: Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 560,
                          width: 340,
                          child: GestureDetector(
                            onTap: () {
// 154.50860969387762,18.286086309527093
                              // 124.01849489795916,14.59933035714613
                              //127.68016581632625,45.73400297619287
                              //173.4288903061221,45.31175595238352

                              //x minimum 124,max 173,
                              // y minimum 14,max 45
                            },
                            child: Image.asset(
                              "assets/images/backtestbody.png",
                              fit: BoxFit.cover,
                              colorBlendMode: BlendMode.colorBurn,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 560,
                          width: 340,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                          onTap:(){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => BodyDetailScreen(x:2 ,y:2))).then((value) => getPainApi());
                                          },
                                          child: Container(
                                      color: Colors.greenAccent.withOpacity(0.5),
                                            child: head?BoundaryTest():Container(),
                                    ),
                                        )),
                                    Expanded(
                                        child: Container(
                                          color: Colors.blue.withOpacity(0.5),
                                        )),
                                    Expanded(
                                        child: Container(
                                          color: Colors.yellow.withOpacity(0.5),
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                          color: Colors.pinkAccent.withOpacity(0.5),
                                        )),
                                    Expanded(
                                        child: Container(
                                          color: Colors.grey.withOpacity(0.5),
                                        )),
                                    Expanded(
                                        child: Container(
                                          color: Colors.purple.withOpacity(0.5),
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                          color: Colors.orange.withOpacity(0.5),
                                        )),
                                    Expanded(
                                        child: Container(
                                          color: Colors.blueGrey.withOpacity(0.5),
                                        )),
                                    Expanded(
                                        child: Container(
                                          color: Colors.black.withOpacity(0.5),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  back: Container(
                    height: D.H / 1.9,
                    width: D.W / 1.6,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/human_body_back.png",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.primaryBlueColor,
        onPressed: () {
          // _buildUserGroups(context);
          // setState(() {});
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _getWidgetInfo(_) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double y = position.dy;
    double x = position.dx;
    print(
        " Screen Offset  " + "XX :- ${x.toString()}     YY :- ${y.toString()}");
  }

  List<Widget> _buildUserGroups(BuildContext context) {
    var tempXX = totaWidth / 2;
    var tempYY = (totaHeight - removableHieght) / 2;
    widgetList.add(Positioned(
      left: _XX,
      top: _YY,
      child: InkWell(
        onTap: () {
          /* Navigator.push(
            context,
           MaterialPageRoute(builder: (context) => BodyDetailScreen()),
          );*/
        },
        child: Draggable(
          child: Container(
            height: 20,
            width: 20,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          ),
          feedback: Container(
            height: 20,
            width: 20,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          ),
          childWhenDragging: Container(),
          onDragEnd: (dragDetails) {
            setState(() {
              print(dragDetails.offset.dx.toString() +
                  "  : " +
                  dragDetails.offset.dy.toString());
              // _XX = dragDetails.offset.dx;
              // _YY =  dragDetails.offset.dy-56.00 - MediaQuery.of(context).padding.top;
              // _buildUserGroupsAfterDrag(context,dragDetails.offset.dx,  dragDetails.offset.dy-56.00 - MediaQuery.of(context).padding.top);
            });
          },
        ),
      ),
    ));
    setState(() {});

    return widgetList;
  }

  void _buildUserGroupsAfterDrag(BuildContext context, double dx, double dy) {
    widgetList.clear();
    widgetList.add(Container(
      height: 560,
      width: 340,
      child: Image.asset(
        "assets/images/backtestbody.png",
        fit: BoxFit.cover,
      ),
    ));
    widgetList.add(Positioned(
      left: dx,
      top: dy,
      child: InkWell(
        onTap: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BodyDetailScreen()),
          );*/
        },
        child: Draggable(
          child: Container(
            height: 20,
            width: 20,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          ),
          feedback: Container(
            height: 20,
            width: 20,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          ),
          childWhenDragging: Container(),
          onDragEnd: (dragDetails) {
            setState(() {
              _XX = dragDetails.offset.dx;
              _YY = dragDetails.offset.dy;
              _buildUserGroupsAfterDrag(
                  context, dragDetails.offset.dx, dragDetails.offset.dy);
            });
          },
        ),
      ),
    ));
    setState(() {});
  }

}
class BoundaryTest extends StatefulWidget {
  BoundaryTest({Key? key}) : super(key: key);

  @override
  State<BoundaryTest> createState() => _BoundaryTestState();
}

class _BoundaryTestState extends State<BoundaryTest> {
  double dx = 100, dy = 100;

  Size containerSize = const Size(30, 30);
  Size? screen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // box allowed 90% of body from center
          final boxSize = Size(constraints.maxWidth * .3, constraints.maxHeight * .3);

          screen ??= Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(

            children: [
              Align(
                child: Container(
                  width: boxSize.width,
                  height: boxSize.height,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 4)),
                ),
              ),
              Positioned(
                top: dy,
                left: dx,
                child: Container(
                  width: containerSize.width,
                  height: containerSize.height,
                  color: Colors.deepPurple,
                ),
              ),
              GestureDetector(
                onTap: () {},
                onPanUpdate: (details) {
                  final tapPos = details.globalPosition;
                  if (tapPos.dx <
                      screen!.width * 0.3  &&
                      tapPos.dx  >
                          screen!.width * .05) {
                    //moveable to x
                    dx = tapPos.dx ;
                    setState(() {});
                  }
                  if (tapPos.dy <
                      screen!.height * .6  &&
                      tapPos.dy >
                          screen!.height * .05) {
                    //moveable to
                    dy = tapPos.dy;
                    setState(() {});
                  }

                  debugPrint(tapPos.toString());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}


