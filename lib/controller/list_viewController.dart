import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/model/data/law.dart';
import 'package:todaybills/view/detail/detail_view.dart';

class ListViewcontroller extends ControllerMVC {
  List<Law> laws = [];

  final String id = "";
  final String age = "";

  final BillsRepository _billsRepository;

  ListViewcontroller({required BillsRepository repository})
      : _billsRepository = repository {
    fetchLaws();
  }

  void onSeleted(BuildContext context, String selectedID, String age) {
    debugPrint("Selected Law ID: $selectedID");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailView(
          lawId: selectedID,
          age: age,
        ),
      ),
    );
  }

  Future<void> updateDate(DateTime newDate) async {
    try {
      final fetchedLaws = await _billsRepository.fetchBills(
        date: newDate,
        isUserSelectingDate: true,
      );
      setState(() {
        laws = fetchedLaws;
      });
    } catch (e) {
      debugPrint("Error updating date: $e");
    }
  }

  Future<void> fetchLaws(
      {DateTime? date, bool isUserSelectingDate = false}) async {
    try {
      final targetDate = date ?? DateTime.now();
      final fetchedLaws = await _billsRepository.fetchBills(
        date: targetDate,
        isUserSelectingDate: isUserSelectingDate,
      );
      setState(() {
        laws = fetchedLaws;
      });
    } catch (e) {
      debugPrint("Error fetching bills: $e");
    }
  }
}
