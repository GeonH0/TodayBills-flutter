import 'package:flutter/material.dart';
import 'package:todaybills/view/home/home_view.dart';
import 'package:todaybills/view/search/search_view.dart';
import 'package:todaybills/view/star/star_view.dart';

class MaintabView extends StatefulWidget {
  const MaintabView({super.key});

  @override
  State<StatefulWidget> createState() => _MaintabViewState();
}

class _MaintabViewState extends State<MaintabView> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    homeView(),
    SearchView(),
    StarView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: '',
            )
          ]),
    );
  }
}
