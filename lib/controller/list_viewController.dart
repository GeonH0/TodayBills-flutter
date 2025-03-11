import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/model/law.dart';

class ListViewcontroller extends ControllerMVC {
  List<Law> laws = [];
  Set<Law> favoriteItems = {};

  final String name = "";

  final BillsRepository _billsRepository = BillsRepository();

  ListViewcontroller() {
    fetchLaws();
    loadFavorites();
  }

  void onSeleted(BuildContext context, name) {
    return;
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorite_laws');
    if (favorites != null) {
      setState(() {
        favoriteItems = favorites.map((json) => Law.fromJson(json)).toSet();
      });
    }
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

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonFavorites =
        favoriteItems.map((law) => law.toJson()).toList();
    await prefs.setStringList('favorite_laws', jsonFavorites);
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

  void toggleFavorite(Law law) {
    setState(() {
      if (favoriteItems.any((fav) => fav.ID == law.ID)) {
        favoriteItems.removeWhere((fav) => fav.ID == law.ID);
      } else {
        favoriteItems.add(law);
      }
    });
    saveFavorites();
  }
}
