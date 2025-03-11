import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/controller/search_viewController.dart';
import 'package:todaybills/view/law_list_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  @override
  State<StatefulWidget> createState() => _SearchView();
}

class _SearchView extends StateMVC<SearchView> {
  late SearchViewcontroller _controller;

  _SearchView() : super(SearchViewcontroller()) {
    _controller = controller as SearchViewcontroller;
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
              decoration: InputDecoration(
                hintText: "법안을 검색해 보세요",
                border: OutlineInputBorder(),
              ),
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
                    _controller.onTapkeywords(keyword);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(
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
              }).toList()),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller.searchController,
              builder: (context, value, child) {
                return value.text.isNotEmpty
                    ? LawListView(
                        selectedDate: DateTime.now(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _controller.recentSearches.length,
                        itemBuilder: (context, index) {
                          final recentSearch =
                              _controller.recentSearches[index];
                          return ListTile(
                            title: Text(recentSearch),
                            onTap: () {
                              _controller.onTapkeywords(recentSearch);
                            },
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
