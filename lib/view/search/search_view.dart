import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/controller/search_viewController.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/model/service/search_service.dart';
import 'package:todaybills/view/calendar/law_list_view.dart';

class SearchView extends StatefulWidget {
  final GlobalKey<ListViewState> lawListKey;

  const SearchView({
    super.key,
    required this.lawListKey,
  });

  @override
  State<StatefulWidget> createState() => _SearchViewState();
}

class _SearchViewState extends StateMVC<SearchView> {
  late final SearchViewController _controller;

  _SearchViewState()
      : super(SearchViewController(
          repository: BillsRepository(),
          searchService: SearchService(),
        )) {
    _controller = controller as SearchViewController;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextField(
              controller: _controller.searchController,
              decoration: const InputDecoration(
                hintText: "법안을 검색해 보세요",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _controller.onSearchChanged();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _controller.keywords.map((keyword) {
                  return InkWell(
                    onTap: () {
                      _controller.onTapKeyword(keyword);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(keyword),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller.searchController,
              builder: (context, value, child) {
                final query = value.text.trim();
                final results = _controller.searchList;

                if (query.isEmpty) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "최근검색",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _controller.deleteRecentSearch();
                              },
                              child: const Text(
                                "전체삭제",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: _controller.recentSearches.length,
                          itemBuilder: (context, index) {
                            final recentSearch =
                                _controller.recentSearches[index];
                            return ListTile(
                              title: Text(recentSearch),
                              onTap: () {
                                _controller.onTapKeyword(recentSearch);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                if (results.isEmpty) {
                  return const Center(
                    child: Text("검색 결과가 없습니다."),
                  );
                } else {
                  return LawListView(
                    key: widget.lawListKey,
                    overrideLaws: results,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
