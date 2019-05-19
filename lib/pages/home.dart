import 'package:flutter/material.dart';
import 'dart:ui';

import './user_profile.dart';

class Home extends StatelessWidget {
  final List<String> _names = <String>[
    'Vincent',
    'Sébastien',
    'Lorène',
    'Lola',
    'Yasmine',
    'Tisto',
    'Marie',
    'Camille'
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GridView.count(
          padding: EdgeInsets.only(top: 95, bottom: 15, right: 10, left: 10),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: List.generate(_names.length, (index) {
            final String name = _names[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile(name)),
                  );
                },
                child: Stack(children: <Widget>[
                  Positioned.fill(
                    child: Hero(
                      tag: name,
                      child: Image.asset(
                        'assets/user.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    left: 0,
                    height: 50,
                    child: Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).accentColor.withOpacity(.9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(name),
                          Text('25 ans'),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: AppBar(
            title: Text('Home'),
            centerTitle: true,
          ),
        ),
      ],
    );
  }
}
