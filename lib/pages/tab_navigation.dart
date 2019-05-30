import 'package:flutter/material.dart';

import 'package:seb/pages/account.dart';
import 'package:seb/pages/card_swipe.dart';
import 'package:seb/pages/home.dart';
import 'package:seb/pages/my_internship_offer.dart';
import 'package:seb/pages/test.dart';

class TabNavigation extends StatefulWidget {
  @override
  State createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _currentIndex = 0;

  final _screens = <Widget>[
    CardSwipe(),
    Home(),
    Test(),
    MyInternshipOffer(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int idx) => setState(() => _currentIndex = idx),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Card'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            title: Text('Candidature'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            title: Text('Test'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_shared),
            title: Text('Propositions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Account'),
          ),
        ],
      ),
    );
  }
}
