import 'package:flutter/material.dart';
import 'package:todaybills/view/calendar_view.dart';
import 'package:todaybills/view/law_list_view.dart';

class homeView extends StatelessWidget {
  const homeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * (0.5),
            child: CalendarView(),
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          Expanded(
            child: LawListView(),
          ),
        ],
      ),
    );
  }
}
