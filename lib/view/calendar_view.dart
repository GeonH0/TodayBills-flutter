import 'package:flutter/material.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todaybills/controller/calendar_viewController.dart';

class CalendarView extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarView({
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends StateMVC<CalendarView> {
  late CalendarViewcontroller _controller;
  late DateTime _focusedDay;

  _CalendarViewState() : super(CalendarViewcontroller()) {
    _controller = controller as CalendarViewcontroller;
  }

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        focusedDay: _controller.focuseDay,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        locale: 'ko-KR',
        daysOfWeekHeight: 30,
        selectedDayPredicate: (day) => isSameDay(_controller.selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
          _controller.onDaySeleted(selectedDay, focusedDay);
          widget.onDateSelected(selectedDay);
        },
        calendarFormat: CalendarFormat.month,
      ),
    );
  }
}
