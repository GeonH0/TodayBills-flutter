import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/model/repository/bills_repository.dart';

class CalendarViewcontroller extends ControllerMVC {
  final BillsRepository repository;
  late DateTime selectedDay;
  late DateTime focusedDay;

  CalendarViewcontroller({required this.repository}) {
    selectedDay = DateTime.now();
    focusedDay = DateTime.now();
  }

  void initializeLatestAvailableDate(DateTime dt) {
    setState(() {
      selectedDay = dt;
      focusedDay = dt;
    });
  }

  void onDaySelected(DateTime sel, DateTime foc) {
    setState(() {
      selectedDay = sel;
      focusedDay = foc;
    });
  }
}
