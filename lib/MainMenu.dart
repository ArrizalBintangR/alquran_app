import 'package:flutter/material.dart';
import 'AlQuran.dart';
import 'WaktuAdzan.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    AlQuran(),
    Home()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text("AlQuran"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert),
            title: Text("Dzikir"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent[200],
        onTap: _onItemTapped,
      ),
    );
  }
}

