import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchViewcontroller extends ControllerMVC {
  List<String> filterdItems = [];
  final List<String> keywords = ["부동산", "안전", "근로", "산업", "환경", "교육"];
  List<String> searchList = []; // 검색 결과
  List<String> recentSearches = []; // 최근 검색어 리스트

  final TextEditingController searchController = TextEditingController();

  SearchViewcontroller() {
    searchController.addListener(onSearchChanged);
  }
  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onTapkeywords(String keyowrd) {
    searchController.text = keyowrd;
    _saveRecentSearch(keyowrd);
  }

  void onSearchChanged() {
    String query = searchController.text;
    setState() {
      filterdItems = [];
    }
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  void _saveRecentSearch(String search) async {
    final prefs = await SharedPreferences.getInstance();
    if (!recentSearches.contains(search)) {
      recentSearches.insert(0, search); // 최근 검색어 앞에 추가
      if (recentSearches.length > 5) {
        recentSearches.removeLast(); // 최대 5개만 유지
      }
      await prefs.setStringList('recent_searches', recentSearches);
      setState(() {});
    }
  }
}
