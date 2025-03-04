import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todaybills/view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(MaterialApp(
    home: homeView(),
  ));
}
