import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/controller/list_viewController.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/view/reusable_law_list/reusable_law_list_view.dart';

final class LawListView extends StatefulWidget {
  final DateTime selectedDate;

  const LawListView({
    super.key,
    required this.selectedDate,
  });

  @override
  _ListViewState createState() => _ListViewState();
}

final class _ListViewState extends StateMVC<LawListView> {
  late ListViewcontroller _controller;

  _ListViewState()
      : super(ListViewcontroller(
          repository: BillsRepository(),
        )) {
    _controller = controller as ListViewcontroller;
  }

  @override
  void initState() {
    super.initState();
    _controller.fetchLaws();
  }

  @override
  void didUpdateWidget(covariant LawListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _controller.fetchLaws(date: widget.selectedDate);
      _controller.updateDate(widget.selectedDate);
    }
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
