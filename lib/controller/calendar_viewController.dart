import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/model/repository/bills_repository.dart';

class CalendarViewcontroller extends ControllerMVC {
  final BillsRepository repository;
  late DateTime selectedDay;
  late DateTime focusedDay;

  CalendarViewcontroller({required this.repository}) {
    // 초기값은 나중에 _initializeCalendar() 에서 덮어씁니다.
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
