import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todaybills/view/maintab_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(
    MaterialApp(
      home: MaintabView(),
    ),
  );
}
