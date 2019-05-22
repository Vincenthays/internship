import 'package:flutter/material.dart';
import 'dart:math';

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
              actions: <Widget>[
                IconButton(icon: Icon(Icons.settings), onPressed: () {}),
              ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _MyButton.large(
            icon: Icons.clear,
            color: Colors.red,
            onPressed: () {},
          ),
          _MyButton.large(
            icon: Icons.star,
            color: Colors.blue,
            onPressed: () {},
          ),
          _MyButton.large(
            icon: Icons.favorite,
            color: Colors.green,
            onPressed: () {},
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
              for (var i = 0; i < 4; i += 1)
                Expanded(
                  child: Container(
                    height: 5,
                    color: Colors.white.withOpacity(i == 0 ? .8 : .3),
                    margin: EdgeInsets.all(3),
                  ),
                ),
            ],
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
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Description',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white),
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
  AnimationController _controller;
  Animation _animation;
  double _x = 0;
  double _y = 0;
  double _rotate = 0;
  double _scale = 1;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween(
      begin: .0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..rotateZ(_rotate)
        ..translate(_x, _y)
        ..scale(_scale),
      alignment: Alignment.center,
      child: GestureDetector(
        child: widget.child,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      ),
    );
  }
  
  void _onPanStart(DragStartDetails dsd) {
    setState(() {
      _scale = 1.03;
    });
  }

  void _onPanUpdate(DragUpdateDetails dud) {
    setState(() {
      _x += dud.delta.dx;
      _y += dud.delta.dy;
      _rotate = _x / 1000;
    });
  }

  void _onPanEnd(DragEndDetails ded) {
    print('end');
    Function _fx = (double v) => (1 - v) * _x;
    Function _fy = (double v) => (1 - v) * _y;

    Offset velocity = ded.velocity.pixelsPerSecond;

    if (velocity.dx != 0 && _x.abs() > 100) {
      _fx = (double v) => 100 * cos(velocity.direction) * v + _x;
      _fy = (double v) => 100 * sin(velocity.direction) * v + _y;
    }
    _animation.addListener(() {
      setState(() {
        _x = _fx(_animation.value);
        _y = _fy(_animation.value);
        _rotate = _x / 1000;
        _scale = 1;
      });
    });
    _animation.addStatusListener((status) {
      print(status);
    });
    _controller.forward(from: 0).orCancel;
  }
}

class _MyButton extends StatelessWidget {
  _MyButton.small({this.icon, this.onPressed, this.color}) : size = 20;
  _MyButton.large({this.icon, this.onPressed, this.color}) : size = 30;

  final IconData icon;
  final double size;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(),
      fillColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      shape: CircleBorder(),
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
