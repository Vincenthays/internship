import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';


class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Card'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ProfileCard.second(),
                  Dismissible(
                      key: Key(Random().toString()),
                      child: ProfileCard.first()
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _MyButton.small(
                    icon: Icons.refresh,
                    color: Colors.orange,
                    onTap: () {},
                  ),
                  _MyButton.large(
                    icon: Icons.clear,
                    color: Colors.red,
                    onTap: () {},
                  ),
                  _MyButton.large(
                    icon: Icons.star,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  _MyButton.large(
                    icon: Icons.favorite,
                    color: Colors.green,
                  ),
                  _MyButton.small(
                    icon: Icons.lock,
                    color: Colors.purple,
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class ProfileCard extends StatelessWidget {
  final double borderRadius = 7;
  final double margin;

  ProfileCard.first() : margin = 0;

  ProfileCard.second() : margin = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20 + margin,
        right: 10 + margin,
        left: 10 + margin,
        bottom: 10 + margin,
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image.asset(
                'assets/user.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      height: 5,
                      color: Colors.white.withOpacity(.8),
                      margin: EdgeInsets.all(3),
                    )
                ),
                Expanded(
                    child: Container(
                      height: 5,
                      color: Colors.grey.withOpacity(.5),
                      margin: EdgeInsets.all(3),
                    )
                ),
                Expanded(
                    child: Container(
                      height: 5,
                      color: Colors.grey.withOpacity(.5),
                      margin: EdgeInsets.all(3),
                    )
                ),
                Expanded(
                    child: Container(
                      height: 5,
                      color: Colors.grey.withOpacity(.5),
                      margin: EdgeInsets.all(3),
                    )
                ),
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 10,
            child: Transform.rotate(
              angle: -.4,
              child: Container(
                child: Text(
                    'POSTULER',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.withOpacity(.5)
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.green.withOpacity(.5),
                      width: 7
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.transparent, Colors.black],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Chef de projet',
                          style: Theme
                              .of(context)
                              .textTheme
                              .title,
                        ),
                        SizedBox(height: 10,),
                        Text('Description',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.info),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class _MyButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final Color color;

  _MyButton.small({this.icon, this.onTap, this.color}) : size = 20;

  _MyButton.large({this.icon, this.onTap, this.color}) : size = 30;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black
        ),
        child: Icon(icon, size: size, color: color,),
      ),
      onTap: onTap,
    );
  }
}
