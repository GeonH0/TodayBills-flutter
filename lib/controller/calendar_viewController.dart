import 'package:mvc_pattern/mvc_pattern.dart';

class CalendarViewcontroller extends ControllerMVC {
  DateTime selectedDay = DateTime.now();
  DateTime focuseDay = DateTime.now();

  void onDaySeleted(DateTime selected, DateTime focused) {
    setState(() {
      selectedDay = selected;
      focuseDay = focused;
    });
  }
}
