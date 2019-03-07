import 'package:flutter/material.dart';

import './user_profile.dart';

class Home extends StatelessWidget {
  final List<String> _names = <String>['Vincent', 'Sébastien', 'Lorène', 'Lola', 'Yasmine', 'Tisto', 'Marie', 'Camille'];
  @override
  Widget build(BuildContext context) {  
    return Stack(
      children: <Widget>[
        GridView.count(
          padding: EdgeInsets.only(top: 95, bottom: 15),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(_names.length, (index) {
            String name = _names[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserProfile(name))
                );
              },
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Hero(  
                      tag: name,
                      child: Image.asset('assets/user.png', fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(name),
                          Text('26 ans')
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            );
          }),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: AppBar(
            title: Text('test'),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}