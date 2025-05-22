import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todaybills/provider/favorites_provider.dart';
import 'package:todaybills/view/home/maintab_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  await initializeDateFormatting();
  await dotenv.load(fileName: "assets/config/.env");

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(prefs),
      child: MaterialApp(
        home: MaintabView(),
      ),
    ),
  );
}
