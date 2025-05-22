import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todaybills/model/data/law.dart';

class FavoritesProvider extends ChangeNotifier {
  static const _key = 'favorite_laws';

  final SharedPreferences _prefs;
  final Set<Law> _favorites = {};

  FavoritesProvider(this._prefs) {
    final stored = _prefs.getStringList(_key) ?? [];
    _favorites.addAll(stored.map((json) => Law.fromJson(json)));
  }

  Set<Law> get favorites => _favorites;

  bool isFavorite(Law law) => _favorites.any((f) => f.ID == law.ID);

  void toggle(Law law) {
    if (_favorites.any((l) => l.ID == law.ID)) {
      _favorites.removeWhere((l) => l.ID == law.ID);
    } else {
      _favorites.add(law);
    }
    // prefs에 저장
    _prefs.setStringList(
      _key,
      _favorites.map((l) => l.toJson()).toList(),
    );
    notifyListeners();
  }
}
