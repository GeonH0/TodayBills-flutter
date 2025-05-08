import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todaybills/controller/list_viewController.dart';
import 'package:todaybills/model/data/bill.dart';
import 'package:todaybills/model/data/law.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/model/service/search_service.dart';

final class SearchViewController extends ListViewcontroller {
  List<String> filteredItems = [];
  final List<String> keywords = ["부동산", "안전", "근로", "산업", "환경", "교육"];
  List<Law> searchList = []; // 검색 결과
  List<String> recentSearches = []; // 최근 검색어 리스트

  final TextEditingController searchController = TextEditingController();
  final SearchService searchService = SearchService();
  final BillsRepository repository;

  SearchViewController(this.repository) : super(repository: BillsRepository()) {
    searchController.addListener(onSearchChanged);
  }

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    loadFavorites();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onTapKeyword(String keyword) {
    searchController.text = keyword;
    _saveRecentSearch(keyword);
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
    setState(() {
      searchList = results.map((bill) => convertBillToLaw(bill)).toList();
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

  @override
  Future<void> loadFavorites() {
    return super.loadFavorites();
  }

  @override
  Future<void> saveFavorites() {
    return super.saveFavorites();
  }

  @override
  void toggleFavorite(Law law) {
    super.toggleFavorite(law);
  }
}
