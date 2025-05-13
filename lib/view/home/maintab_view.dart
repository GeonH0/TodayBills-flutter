import 'package:flutter/material.dart';
import 'package:todaybills/view/calendar/law_list_view.dart';
import 'package:todaybills/view/home/home_view.dart';
import 'package:todaybills/view/search/search_view.dart';
import 'package:todaybills/view/star/star_view.dart';

class MaintabView extends StatefulWidget {
  const MaintabView({super.key});

  @override
  State<MaintabView> createState() => _MaintabViewState();
}

class _MaintabViewState extends State<MaintabView> {
  int _selectedIndex = 0;
  late final List<Widget> _persistentPages;

  // LawListView 갱신용 키
  final GlobalKey<ListViewState> _lawListKey = GlobalKey<ListViewState>();
  final GlobalKey<ListViewState> _searchlawListKey = GlobalKey<ListViewState>();

  @override
  void initState() {
    super.initState();
    _persistentPages = [
      homeView(lawListKey: _lawListKey),
      SearchView(lawListKey: _searchlawListKey),
    ];
  }

  void _onItemTapped(int idx) {
    setState(() => _selectedIndex = idx);
    if (idx == 0) {
      _lawListKey.currentState?.refreshFavorites();
    } else if (idx == 1) {
      _searchlawListKey.currentState?.refreshFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _persistentPages[0],
      _persistentPages[1],
      if (_selectedIndex == 2) StarView() else const SizedBox.shrink(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
        ],
      ),
    );
  }
}
