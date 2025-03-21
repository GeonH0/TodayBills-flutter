import 'package:flutter/material.dart';
import 'package:todaybills/model/data/law.dart';

class ReusableLawListView extends StatelessWidget {
  final List<Law> laws;
  final Set<Law> favoriteIems;
  final void Function(Law) onToggleFavorite;
  final void Function(BuildContext, String, String) onSelected;

  const ReusableLawListView({
    super.key,
    required this.laws,
    required this.favoriteIems,
    required this.onToggleFavorite,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: laws.length,
      itemBuilder: (context, index) {
        final law = laws[index];
        return Card(
          child: ListTile(
            title: Text(law.title),
            trailing: IconButton(
              icon: Icon(
                // ignore: collection_methods_unrelated_type
                favoriteIems.any((fav) => fav.ID == law.ID)
                    ? Icons.star
                    : Icons.star_border,
                // ignore: collection_methods_unrelated_type
                color: favoriteIems.any((fav) => fav.ID == law.ID)
                    ? Colors.yellow
                    : Colors.black,
              ),
              onPressed: () => onToggleFavorite(law),
            ),
            onTap: () => onSelected(context, law.ID, law.age),
          ),
        );
      },
    );
  }
}
