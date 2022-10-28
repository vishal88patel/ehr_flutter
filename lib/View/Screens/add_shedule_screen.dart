import 'dart:collection';
import 'dart:convert';
import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Constants/api_endpoint.dart';
import '../../Utils/common_utils.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/preferences.dart';
import '../../customWidgets/custom_button.dart';
import '../../customWidgets/custom_textform_field.dart';
import '../../customWidgets/custom_time_field.dart';

class AddSheduleScreen extends StatefulWidget {
  final int? usersScheduleId;
  final String? comment;
  final String? scheduleDateTime;
  const AddSheduleScreen({Key? key, this.usersScheduleId, this.comment, this.scheduleDateTime}) : super(key: key);

  @override
  State<AddSheduleScreen> createState() => _AddSheduleScreenState();
}

class _AddSheduleScreenState extends State<AddSheduleScreen> {
  final commentController = TextEditingController();
  final timeController = TextEditingController();
  final ampmController = TextEditingController();

  String? _selectedTime;
  int? userScheduleId=0;

  late final PageController _pageController;
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
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  var editDate;
  var editComment;
  var date;
  var timee;




  @override
  void initState() {
    if( widget.usersScheduleId!=null){
      editDate=widget.scheduleDateTime.toString();
      date=editDate;
      editComment=widget.comment.toString();
      commentController.text=editComment;
      userScheduleId=widget.usersScheduleId;
      var datee = DateFormat.yMEd().add_jms().format(DateTime.fromMillisecondsSinceEpoch(int.parse(editDate)));
      print(datee);
      var parts = datee.split(' ');
      print(parts);
      var showDate=DateFormat('MM/dd/yyyy').parse(parts[1]);
      _selectedDay=showDate;
      print(_selectedDay);
      var showTime=parts[2].toString().split(":");
      timeController.text=showTime[0]+":"+showTime[1];
      ampmController.text=parts[3];
      timee=showTime[0]+":"+showTime[1]+" "+parts[3];
      print(timee);
    }else{

    }

    super.initState();
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
        backgroundColor: ColorConstants.blueBtn,
        elevation: 0,
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
        title: Text(
          "Add Schedule",
          style: GoogleFonts.heebo(
              fontSize: D.H / 44, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: ColorConstants.lightPurple,
      body: SingleChildScrollView(
        child: Container(
          color: ColorConstants.lightPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(D.W/28),
                  child: Center(
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
                                    print("Date:"+_selectedDay.toString().substring(0,10));
                                    var date=DateFormat('yyyy-MM-dd hh:mm aaa').parse(_selectedDay.toString().substring(0,10)+" "+"10:10 AM");
                                    print("date:"+date.millisecondsSinceEpoch.toString());
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
                ),
              ),
              Container(
                color: ColorConstants.lightPurple,
                child: Column(
                  children: [
                    SizedBox(height: D.H / 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                _timePicker();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: D.W / 18),
                                child: Text(
                                  "Select Time",
                                  style: GoogleFonts.heebo(
                                      fontSize: D.H / 52,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            SizedBox(height: D.H / 240),
                            Padding(
                              padding: EdgeInsets.only(left: D.W / 18),
                              child: Container(
                                width: D.W / 2,
                                child: CustomTimeField(
                                  onTap: () {
                                    _timePicker();
                                  },
                                  controller: timeController,
                                  iconPath: "assets/images/ic_time.svg",
                                  readOnly: true,
                                  validators: (e) {
                                    if (timeController.text == null ||
                                        timeController.text == '') {
                                      return '*Please enter End Date';
                                    }
                                  },
                                  keyboardTYPE: TextInputType.text,
                                  obscured: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: D.W / 18, right: D.W / 18),
                              child: Text(
                                "AM/PM",
                                style: GoogleFonts.heebo(
                                    fontSize: D.H / 52,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: D.H / 240),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: D.W / 18, right: D.W / 18),
                              child: Container(
                                width: D.W / 3.6,
                                child: CustomTimeField(
                                  onTap: () {

                                  },
                                  controller: ampmController,
                                  readOnly: true,
                                  validators: (e) {
                                    if (ampmController.text == null ||
                                        ampmController.text == '') {
                                      return '*Please enter End Date';
                                    }
                                  },
                                  keyboardTYPE: TextInputType.text,
                                  obscured: false,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: D.H / 60),
                    Row(
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(left: D.W / 18, right: D.W / 18),
                          child: Text(
                            "Comment",
                            style: GoogleFonts.heebo(
                                fontSize: D.H / 52, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: D.W / 18, right: D.W / 18),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: CustomTextFormField(
                          controller: commentController,
                          readOnly: false,
                          validators: (e) {
                            if (commentController.text == null ||
                                commentController.text == '') {
                              return '*Value';
                            }
                          },
                          keyboardTYPE: TextInputType.text,
                          obscured: false,
                        ),
                      ),
                    ),
                    SizedBox(height: D.H / 26),
                    Padding(
                      padding: EdgeInsets.only(left: D.W / 10, right: D.W / 10),
                      child: CustomButton(
                        color: ColorConstants.blueBtn,
                        onTap: () {
                          if(_selectedDay==null){
                            CommonUtils.showRedToastMessage("Please Select Date");
                          }
                          else if (timee==null){
                            CommonUtils.showRedToastMessage("Please Select Time");
                          }
                          else if (commentController.text.isEmpty){
                            CommonUtils.showRedToastMessage("Please Enter Comment");
                          }
                          else{
                            saveSchedule();
                          }
                          //NavigationHelpers.redirect(context, OtpScreen());
                        },
                        text: "Save",
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: D.H / 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _timePicker() async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // Using 12-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {


      setState(() {
        _selectedTime = result.format(context);
        DateTime tempDate = DateFormat("hh:mm").parse(_selectedTime.toString());
        var dateFormat = DateFormat("h:mm a");
        timee=dateFormat.format(tempDate);
        var time=_selectedTime.toString().split(" ");
        timeController.text=time[0];
        ampmController.text=time[1];
        print("Time:"+_selectedTime.toString());

      });
    }
  }

  Future<void> saveSchedule() async {
    CommonUtils.showProgressDialog(context);
    final uri = ApiEndPoint.saveSchedule;
    final headers = {'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await PreferenceUtils.getString("ACCESSTOKEN")}',
    };
    date=(DateFormat('yyyy-MM-dd hh:mm aaa').parse(_selectedDay.toString().substring(0,10)+" "+timee.toString()).millisecondsSinceEpoch);
    Map<String, dynamic> body = {
      "usersScheduleId": userScheduleId,
      "scheduleDateTime": date.toString(),
      "comment": commentController.text.toString(),
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
      CommonUtils.hideProgressDialog(context);
      Navigator.pop(context);
    } else {
      CommonUtils.hideProgressDialog(context);
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