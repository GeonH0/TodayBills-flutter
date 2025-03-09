import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todaybills/model/law.dart';

class ListViewcontroller extends ControllerMVC {
  List<Law> laws = [];
  Set<Law> favoriteItems = {};

  final String name = "";

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
        print(json);
        favoriteItems = favorites.map((json) => Law.fromJson(json)).toSet();
      });
    }
  }

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonFavorites =
        favoriteItems.map((law) => law.toJson()).toList();
    print(prefs.getStringList('favorite_laws'));
    await prefs.setStringList('favorite_laws', jsonFavorites);
  }

  void fetchLaws() {
    setState(() {
      laws = [
        Law(ID: "1", title: "법안 1"),
        Law(ID: "2", title: "법안 2"),
        Law(ID: "3", title: "법안 3"),
      ];
    });
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
