import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/controller/list_viewController.dart';
import 'package:todaybills/model/data/law.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
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
    _controller.loadFavorites();
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

  void refreshFavorites() {
    _controller.loadFavorites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ReusableLawListView(
      laws: _controller.laws,
      favoriteIems: _controller.favoriteItems,
      onToggleFavorite: _controller.toggleFavorite,
      onSelected: _controller.onSeleted,
    );
  }
}
