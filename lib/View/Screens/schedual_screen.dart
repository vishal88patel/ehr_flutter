import 'dart:collection';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ehr/Constants/color_constants.dart';
import 'package:ehr/View/Screens/add_shedule_screen.dart';
import 'package:ehr/View/Screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Constants/api_endpoint.dart';
import '../../Model/schedule_model.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/navigation_helper.dart';
import '../../Utils/notification_service.dart';
import '../../Utils/preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class SchedualScreen extends StatefulWidget {
  const SchedualScreen({Key? key}) : super(key: key);

  @override
  State<SchedualScreen> createState() => _SchedualScreenState();
}

class _SchedualScreenState extends State<SchedualScreen> {
  late final PageController _pageController;
  Duration offsetTime= DateTime.now().timeZoneOffset;
  // late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay1 = ValueNotifier(DateTime.now());
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<ScheduleModel>scheduleList=[];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getSchedule(DateTime.now().month.toString(),DateTime.now().year.toString());
    });

    // _selectedDays.add(_focusedDay.value);
    // _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    // _focusedDay.dispose();
    // _selectedEvents.dispose();
    super.dispose();
  }


  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }




  @override
  Widget build(BuildContext context) {
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
                "Calendar",
                style: GoogleFonts.heebo(
                    fontSize: D.H / 44, fontWeight: FontWeight.w500),
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
        backgroundColor: ColorConstants.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: D.W / 28, right: D.W / 28),
            child: Column(
              children: [
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8,
                    child: Container(
                      child: Column(
                        children: [
                          ValueListenableBuilder<DateTime>(
                            valueListenable: _focusedDay1,
                            builder: (context, value, _) {
                              return _CalendarHeader(
                                focusedDay: value,
                                clearButtonVisible: canClearSelection,
                                onTodayButtonTap: () {
                                  setState(() => _focusedDay1.value = DateTime.now());

                                },
                                onClearButtonTap: () {
                                  setState(() {
                                    _rangeStart = null;
                                    _rangeEnd = null;
                                    _selectedDays.clear();
                                    // _selectedEvents.value = [];
                                  });
                                },
                                onLeftArrowTap: () {
                                  _pageController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                                onRightArrowTap: () {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                              );
                            },
                          ),
                          TableCalendar(
                            rowHeight: D.H/18,
                            calendarStyle: CalendarStyle(

                              defaultTextStyle: TextStyle(color: ColorConstants.calenderFontColor,fontWeight: FontWeight.bold),
                              weekendTextStyle:  TextStyle(color: ColorConstants.calenderFontColor,fontWeight: FontWeight.bold),
                              todayDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.calenderFontColor
                              ),
                              selectedDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.calenderFontColor
                              ),
                            ),


                            onCalendarCreated: (controller) => _pageController = controller,
                            headerVisible: false,
                            firstDay: kFirstDay,
                            lastDay: kLastDay,
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              if (!isSameDay(_selectedDay, selectedDay)) {
                                // Call `setState()` when updating the selected day
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              }
                            },
                            onFormatChanged: (format) {
                              if (_calendarFormat != format) {
                                // Call `setState()` when updating calendar format
                                setState(() {
                                  _calendarFormat = format;
                                });
                              }
                            },
                            onPageChanged: (focusedDay) {
                              // No need to call `setState()` here
                              _focusedDay = focusedDay;
                            },
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: scheduleList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      int? datetime= scheduleList[index].scheduleDateTime;
                      var date = DateFormat.yMEd().add_jms().format(DateTime.fromMillisecondsSinceEpoch(datetime!));
                      var parts = date.split(' ');
                      var showDate=parts[1].toString().split("/");
                      var showTime=parts[2].toString().split(":");

                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.all(0),
                              onPressed: (BuildContext context) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddSheduleScreen(usersScheduleId: scheduleList[index].usersScheduleId,comment:scheduleList[index].comment ,scheduleDateTime: scheduleList[index].scheduleDateTime.toString(),))).then((value) => getScheduleWithoutLoader(DateTime.now().month.toString(), DateTime.now().year.toString()));
                              },
                              backgroundColor:
                                  ColorConstants.primaryBlueColor,
                              foregroundColor: Colors.white,
                              icon: Icons.edit_outlined,
                            ),
                            SlidableAction(
                              padding: EdgeInsets.all(0),
                              onPressed: (BuildContext context) async {
                                setState(() {});
                                deleteSchedule(scheduleList[index].usersScheduleId);
                                scheduleList.removeAt(index);
                                await NotificationService().removeNotification(scheduleList[index].usersScheduleId!);
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: D.W / 40),
                          child: Card(
                            color: ColorConstants.blueBtn,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 6.0),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: D.W / 30.0, top: D.H / 80),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/images/ic_time.svg"),
                                              Padding(
                                                padding:
                                                    const EdgeInsets
                                                            .only(
                                                        left: 4.0),
                                                child: Text(
                                                  showTime[0]+":"+showTime[1]+" "+parts[3],
                                                  style: GoogleFonts.heebo(
                                                      color:
                                                          ColorConstants
                                                              .skyBlue,
                                                      fontSize:
                                                          D.H / 54,
                                                      fontWeight:
                                                          FontWeight
                                                              .w500),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets
                                                            .only(
                                                        left: 4.0),
                                                child: Text(
                                                    showDate[1]+"-"+showDate[0]+"-"+showDate[2],
                                                  style: GoogleFonts.heebo(
                                                      color:
                                                          ColorConstants
                                                              .skyBlue,
                                                      fontSize:
                                                          D.H / 54,
                                                      fontWeight:
                                                          FontWeight
                                                              .w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: D.W / 22.0,
                                              top: D.H / 140,
                                              bottom: D.H / 100),
                                          child: Text(
                                            scheduleList[index].comment.toString(),
                                            style: GoogleFonts.heebo(
                                                fontSize: D.H / 44,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: D.H / 40,
                )
              ],
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.primaryBlueColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSheduleScreen())).then((value) => getScheduleWithoutLoader(DateTime.now().month.toString(), DateTime.now().year.toString()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


  Future<void> addNotification(String id,String disc,DateTime time) async {
    await NotificationService().showNotification(
        int.parse(id),"Reminder", disc,time);
  }

  Future<void> getSchedule(String month,String year) async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.getSchedule;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };

    Map<String, dynamic> body = {
      "monthNumber": month,
      "year": year,
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
        scheduleList.add(ScheduleModel(
            usersScheduleId: res[i]["usersScheduleId"], scheduleDateTime: res[i]["scheduleDateTime"], comment: res[i]["comment"]));
        int? datetime= scheduleList[i].scheduleDateTime;
        var date = DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(datetime!)));
        var current = DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()));

        if(date.compareTo(current) == 0){
          print("Both date time are at same moment.");
        }

        if(date.compareTo(current) < 0){
          print("DT1 is before DT2");
        }

        if(date.compareTo(current) > 0){
          print("DT1 is after DT2");
          Duration diff = date.difference(current);
          print(diff.inSeconds.toString());
          int? minutes= int.parse(diff.inSeconds.toString());
          addNotification(scheduleList[i].usersScheduleId.toString(),scheduleList[i].comment.toString(),DateTime.now().add(Duration(seconds: minutes)));
        }
      }
      CommonUtils.hideProgressDialog(context);
      setState(() {});

    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> getScheduleWithoutLoader(String month,String year) async {
    final uri = ApiEndPoint.getSchedule;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    print("month:"+month.toString());
    print("year:"+year.toString());
    Map<String, dynamic> body = {
      "monthNumber": month,
      "year": year,
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
      scheduleList.clear();
      for (int i = 0; i < res.length; i++) {
        scheduleList.add(ScheduleModel(
            usersScheduleId: res[i]["usersScheduleId"], scheduleDateTime: res[i]["scheduleDateTime"], comment: res[i]["comment"]));
        int? datetime= scheduleList[i].scheduleDateTime;
        var date = DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(datetime!)));
        var current = DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()));
        if(date.compareTo(current) == 0){
          print("Both date time are at same moment.");
        }

        if(date.compareTo(current) < 0){
          print("DT1 is before DT2");
        }

        if(date.compareTo(current) > 0){
          print("DT1 is after DT2");
          Duration diff = date.difference(current);
          print(diff.inSeconds.toString());
          int? minutes= int.parse(diff.inSeconds.toString());
          addNotification(scheduleList[i].usersScheduleId.toString(),scheduleList[i].comment.toString(),DateTime.now().add(Duration(seconds: minutes)));
        }
      }
      setState(() {});
    } else {
      CommonUtils.hideProgressDialog(context);
      CommonUtils.showRedToastMessage(res["message"]);
    }
  }

  Future<void> deleteSchedule(var id) async {
    final uri = ApiEndPoint.deleteSchedule;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    Map<String, dynamic> body = {
      "usersScheduleId": id,
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
      if(mounted){
        setState(() {});

      }
      // _showSnackBar(context, "Delete");
    } else {

      CommonUtils.showRedToastMessage(res["message"]);
    }
  }
}





class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Row(
      children: [
        const SizedBox(width: 16.0),
        SizedBox(
          width: 100.0,
          child: Text(
            headerText,
            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: ColorConstants.primaryBlueColor),
          ),
        ),
        IconButton(
          icon: Icon(CupertinoIcons.right_chevron, size: 18.0,color: ColorConstants.calenderFontColor,),
          visualDensity: VisualDensity.compact,
          onPressed: onTodayButtonTap,
        ),
        if (clearButtonVisible)
          IconButton(
            icon: Icon(Icons.clear, size: 20.0),
            visualDensity: VisualDensity.compact,
            onPressed: onClearButtonTap,
          ),
        const Spacer(),
        IconButton(
          icon: Icon(CupertinoIcons.left_chevron,color: Color(0xFF1CB6EA),),
          onPressed: onLeftArrowTap,
        ),
        IconButton(
          icon: Icon(CupertinoIcons.right_chevron,color: Color(0xFF1CB6EA)),
          onPressed: onRightArrowTap,
        ),
      ],
    );
  }
}