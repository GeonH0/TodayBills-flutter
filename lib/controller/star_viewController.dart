import 'package:todaybills/controller/list_viewController.dart';
import 'package:todaybills/model/data/law.dart';

class StarViewcontroller extends ListViewcontroller {
  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  Future<void> loadFavorites() {
    return super.loadFavorites();
  }

  @override
  Future<void> saveFavorites() {
    return super.saveFavorites();
  }

  @override
  void toggleFavorite(Law law) {
    super.toggleFavorite(law);
  }
}
