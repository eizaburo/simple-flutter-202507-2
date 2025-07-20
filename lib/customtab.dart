import 'package:flutter/material.dart';

import './home.dart';
import './contact.dart';

class CustomTab extends StatefulWidget {
  const CustomTab({super.key});

  @override
  State<CustomTab> createState() => CustomTabState();
}

class CustomTabState extends State<CustomTab> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[Home(), Contact()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Contact"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
