import 'package:flutter/material.dart';
import 'package:projet_java_support_ai/interfaces/Contacter_chat.dart';
import 'package:projet_java_support_ai/interfaces/Home_page.dart';
import 'package:projet_java_support_ai/interfaces/Signup1.dart';
import 'package:projet_java_support_ai/testtest.dart';

class Scrollbetweenpages extends StatefulWidget {
  const Scrollbetweenpages({super.key});

  @override
  State<Scrollbetweenpages> createState() => _ScrollbetweenpagesState();
}

class _ScrollbetweenpagesState extends State<Scrollbetweenpages> {
  int _selectedIndex = 0;

  // Option styles
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    TestTest(),
    Support_chat(),
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
        backgroundColor: const Color(0xFF4D55CC),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Contacter Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.green[250],
        onTap: _onItemTapped,
      ),
    );
  }
}
