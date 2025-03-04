import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todaybills/model/law.dart';

class ListViewcontroller extends ControllerMVC {
  List<Law> laws = [];
  final String name = "";

  ListViewcontroller() {
    fetchLaws();
  }

  void onSeleted(BuildContext context, name) {
    return;
  }

  void fetchLaws() {
    setState(() {
      laws = [
        Law(title: "법안 1", description: "첫 번째 법안 설명"),
        Law(title: "법안 2", description: "두 번째 법안 설명"),
        Law(title: "법안 3", description: "세 번째 법안 설명"),
      ];
    });
  }
}
