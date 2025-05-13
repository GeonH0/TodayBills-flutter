import 'package:flutter/material.dart';
import 'package:todaybills/controller/calendar_viewController.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/view/calendar/calendar_view.dart';
import 'package:todaybills/view/calendar/law_list_view.dart';

final class homeView extends StatefulWidget {
  final GlobalKey<ListViewState> lawListKey;
  const homeView({
    required this.lawListKey,
  });

  @override
  State<StatefulWidget> createState() => _homeViewState();
}

final class _homeViewState extends State<homeView> {
  DateTime _selectedDate = DateTime.now();

  void _onDateSelected(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * (0.5),
            child: CalendarView(
              selectedDate: _selectedDate,
              onDateSelected: _onDateSelected,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          Expanded(
            child: LawListView(
              key: widget.lawListKey,
              selectedDate: _selectedDate,
            ),
          ),
        ],
      ),
    );
  }
}
