import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/controller/star_viewController.dart';
import 'package:todaybills/view/reusable_law_list_view.dart';

class StarView extends StatefulWidget {
  const StarView({super.key});

  @override
  State<StatefulWidget> createState() => _StarView();
}

class _StarView extends StateMVC<StarView> {
  late StarViewcontroller _controller;

  _StarView() : super(StarViewcontroller()) {
    _controller = controller as StarViewcontroller;
  }

  @override
  void initState() {
    super.initState();
    _controller.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('즐겨찾기'),
      ),
      body: ReusableLawListView(
        laws: _controller.laws,
        favoriteIems: _controller.favoriteItems,
        onToggleFavorite: _controller.toggleFavorite,
        onSelected: _controller.onSeleted,
      ),
    );
  }
}
