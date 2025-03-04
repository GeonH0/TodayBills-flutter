import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/controller/list_viewController.dart';

class LawListView extends StatefulWidget {
  const LawListView({super.key});

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends StateMVC<LawListView> {
  late ListViewcontroller _controller;

  _ListViewState() : super(ListViewcontroller()) {
    _controller = controller as ListViewcontroller;
  }

  @override
  void initState() {
    super.initState();
    _controller.fetchLaws();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView.builder(
        itemCount: _controller.laws.length,
        itemBuilder: (context, index) {
          final law = _controller.laws[index];
          print("Law List Count: ${_controller.laws.length}");
          return Card(
            child: ListTile(
              title: Text(law.title),
              onTap: () => _controller.onSeleted(context, law),
            ),
          );
        },
      ),
    );
  }
}
