import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todaybills/controller/list_viewController.dart';
import 'package:todaybills/model/data/bill.dart';
import 'package:todaybills/model/data/law.dart';
import 'package:todaybills/model/service/search_service.dart';

class SearchViewController extends ListViewcontroller {
  List<String> filteredItems = [];
  final List<String> keywords = ["부동산", "안전", "근로", "산업", "환경", "교육"];
  List<Law> searchList = []; // 검색 결과
  List<String> recentSearches = []; // 최근 검색어 리스트

  final TextEditingController searchController = TextEditingController();
  final SearchService searchService;

  SearchViewController({
    required super.repository,
    required this.searchService,
  });

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

  void onTapKeyword(String keyword) {
    searchController.text = keyword;
    _saveRecentSearch(keyword);
    onSearchChanged();
  }

  Law convertBillToLaw(Bill bill) {
    return Law(
      ID: bill.billId,
      title: bill.billName,
      age: bill.age,
    );
  }

  void onSearchChanged() async {
    String query = searchController.text;
    if (query.isEmpty) {
      setState(() {
        searchList = [];
      });
      return;
    }

    final results = await searchService.searchBillsByKeywords(query);
    _saveRecentSearch(query);
    final uniqueMap = <String, Law>{};
    for (final bill in results) {
      final law = convertBillToLaw(bill);
      uniqueMap[law.ID] = law;
    }
    setState(() {
      searchList = uniqueMap.values.toList();
    });
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
      recentSearches.insert(0, search);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
      await prefs.setStringList('recent_searches', recentSearches);
      setState(() {});
    }
  }

  void deleteRecentSearch() {
    final prefs = SharedPreferences.getInstance();
    if (recentSearches.isNotEmpty) {
      setState(() {
        recentSearches.clear();
      });
    }
  }
}
