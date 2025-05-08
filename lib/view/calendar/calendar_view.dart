import 'package:flutter/material.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todaybills/controller/calendar_viewController.dart';
import 'package:todaybills/model/repository/bills_repository.dart';

class CalendarView extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final BillsRepository repository;

  const CalendarView({
    required this.selectedDate,
    required this.onDateSelected,
    required this.repository,
    super.key,
  });

  @override
  StateMVC<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends StateMVC<CalendarView> {
  late CalendarViewcontroller _controller;

  _CalendarViewState()
      : super(CalendarViewcontroller(repository: BillsRepository())) {
    _controller = controller as CalendarViewcontroller;
  }

  @override
  void initState() {
    super.initState();
    _initializeCalendar();
  }

  Future<void> _initializeCalendar() async {
    await _controller.repository.fetchBills(
      date: DateTime.now(),
      isUserSelectingDate: false,
    );

    final latestKey = _controller.repository.getLatestAvailableDate();
    if (latestKey != null) {
      final dt = DateTime.parse(latestKey);
      _controller.initializeLatestAvailableDate(dt);
      widget.onDateSelected(dt);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
      focusedDay: _controller.focusedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      locale: 'ko-KR',
      daysOfWeekHeight: 30,
      selectedDayPredicate: (day) => isSameDay(_controller.selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {});
        _controller.onDaySelected(selectedDay, focusedDay);
        widget.onDateSelected(selectedDay);
      },
      calendarFormat: CalendarFormat.month,
    );
  }
}
