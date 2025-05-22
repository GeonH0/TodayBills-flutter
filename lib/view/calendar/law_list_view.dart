import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:todaybills/controller/list_viewController.dart';
import 'package:todaybills/model/data/law.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/provider/favorites_provider.dart';
import 'package:todaybills/view/reusable_law_list/reusable_law_list_view.dart';

class LawListView extends StatefulWidget {
  final DateTime? selectedDate;
  final List<Law>? overrideLaws;

  const LawListView({
    super.key,
    this.selectedDate,
    this.overrideLaws,
  });

  @override
  ListViewState createState() => ListViewState();
}

class ListViewState extends StateMVC<LawListView> {
  late ListViewcontroller _controller;

  ListViewState()
      : super(ListViewcontroller(
          repository: BillsRepository(),
        )) {
    _controller = controller as ListViewcontroller;
  }

  @override
  void initState() {
    super.initState();
    _applyModeAndFetch();
  }

  @override
  void didUpdateWidget(covariant LawListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.overrideLaws != widget.overrideLaws) {
      _applyModeAndFetch();
      return;
    }
    if (widget.overrideLaws == null &&
        oldWidget.selectedDate != widget.selectedDate) {
      _controller.fetchLaws(date: widget.selectedDate);
    }
  }

  void _applyModeAndFetch() {
    if (widget.overrideLaws != null) {
      _controller.laws = widget.overrideLaws!;
    } else {
      _controller.fetchLaws(date: widget.selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;
    return ReusableLawListView(
      laws: _controller.laws,
      favoriteIems: favorites,
      onSelected: _controller.onSeleted,
    );
  }
}
