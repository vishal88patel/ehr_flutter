import 'dart:collection';

import 'package:ehr/Constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Utils/dimensions.dart';

class CustomCalender extends StatefulWidget {
  @override
  _CustomCalenderState createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
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
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
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
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8,
        child: Container(
          height: D.H/2.35,
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
    );
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