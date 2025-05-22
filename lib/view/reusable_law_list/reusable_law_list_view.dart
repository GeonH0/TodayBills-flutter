import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todaybills/model/data/law.dart';
import 'package:todaybills/provider/favorites_provider.dart';

final class ReusableLawListView extends StatelessWidget {
  final List<Law> laws;
  final Set<Law> favoriteIems;
  final void Function(BuildContext, String, String) onSelected;

  const ReusableLawListView({
    super.key,
    required this.laws,
    required this.favoriteIems,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;
    return ListView.builder(
      itemCount: laws.length,
      itemBuilder: (context, index) {
        final law = laws[index];
        final isFav = favorites.any((f) => f.ID == law.ID);
        return Card(
          child: ListTile(
            title: Text(law.title),
            trailing: IconButton(
              icon: Icon(
                isFav ? Icons.star : Icons.star_border,
                color: isFav ? Colors.yellow : Colors.black,
              ),
              onPressed: () => context.read<FavoritesProvider>().toggle(law),
            ),
            onTap: () => onSelected(context, law.ID, law.age),
          ),
        );
      },
    );
  }
}
