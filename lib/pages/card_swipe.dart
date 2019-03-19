import 'dart:ui';

import 'package:flutter/material.dart';

class CardSwipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AppBar(
              title: Text('Card'),
              centerTitle: true,
            ),
          ),
          Positioned(bottom: 0, right: 0, left: 0, child: _Buttons()),
          Positioned(
            top: 95,
            right: 15,
            left: 15,
            bottom: 80,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ProfileCard(),
                _Drag(child: ProfileCard()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class ProfileCard extends StatelessWidget {
  final double borderRadius = 7;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              )),
              Expanded(
                  child: Container(
                height: 5,
                color: Colors.grey.withOpacity(.5),
                margin: EdgeInsets.all(3),
              )),
              Expanded(
                  child: Container(
                height: 5,
                color: Colors.grey.withOpacity(.5),
                margin: EdgeInsets.all(3),
              )),
              Expanded(
                  child: Container(
                height: 5,
                color: Colors.grey.withOpacity(.5),
                margin: EdgeInsets.all(3),
              )),
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
                    color: Colors.green.withOpacity(.5)),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.green.withOpacity(.5), width: 7),
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
                      Text(
                        'Chef de projet',
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.subtitle,
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
    );
  }
}

class _Drag extends StatefulWidget {
  final Widget child;

  _Drag({this.child});

  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _positionX = 0;
  double _positionY = 0;
  double _rotate = 0;
  double _scale = 1;
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..rotateZ(_rotate)
        ..translate(_positionX, _positionY)
        ..scale(_scale),
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        child: widget.child,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      ),
    );
  }

  void _onPanStart(DragStartDetails dsd) => setState(() => _scale = 1.03);

  void _updateCardTransformation(double x) {
    setState(() {
      // _positionY = x.abs()/3;
      _positionX = x;
      _rotate = x / 1000;
    });
  }

  void _onPanUpdate(DragUpdateDetails dud) {
    _updateCardTransformation(_positionX + dud.delta.dx);
  }

  void _onPanEnd(DragEndDetails ded) {
    setState(() => _scale = 1);
    _animationController.reset();
    final double end = _positionX.abs() < 100 ? 0 : _positionY > 0 ? 500 : -500;
    _animation =
        Tween(begin: _positionX, end: end).animate(_animationController);
    _animationController.addListener(
        () => _updateCardTransformation(_animation.value.toDouble()));
    _animationController.forward();
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
            borderRadius: BorderRadius.circular(50), color: Colors.black),
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
      onTap: onTap,
    );
  }
}
