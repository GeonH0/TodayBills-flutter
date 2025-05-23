import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:todaybills/controller/star_viewController.dart';
import 'package:todaybills/model/repository/bills_repository.dart';
import 'package:todaybills/provider/favorites_provider.dart';
import 'package:todaybills/view/reusable_law_list/reusable_law_list_view.dart';

final class StarView extends StatefulWidget {
  const StarView({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _StarView();
}

final class _StarView extends StateMVC<StarView> {
  late StarViewcontroller _controller;

  _StarView() : super(StarViewcontroller(repository: BillsRepository())) {
    _controller = controller as StarViewcontroller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('즐겨찾기'),
      ),
      body: ReusableLawListView(
        laws: favorites.toList(),
        favoriteIems: favorites,
        onSelected: _controller.onSeleted,
      ),
    );
  }
}
