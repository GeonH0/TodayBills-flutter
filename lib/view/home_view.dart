import 'package:flutter/material.dart';
import 'package:todaybills/view/calendar_view.dart';
import 'package:todaybills/view/law_list_view.dart';

class homeView extends StatefulWidget {
  const homeView({super.key});

  @override
  State<StatefulWidget> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
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
              selectedDate: _selectedDate,
            ),
          ),
        ],
      ),
    );
  }
}
