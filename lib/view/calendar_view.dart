import 'package:flutter/material.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todaybills/controller/calendar_viewController.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends StateMVC<CalendarView> {
  late CalendarViewcontroller _controller;

  _CalendarViewState() : super(CalendarViewcontroller()) {
    _controller = controller as CalendarViewcontroller;
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
          _controller.onDaySeleted(selectedDay, focusedDay);
        },
        calendarFormat: CalendarFormat.month,
      ),
    );
  }
}
