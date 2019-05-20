import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, _) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Chef de projet'),
                background: Image.asset(
                  'assets/user.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverSkillsDelegate(),
              pinned: true,
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: 100,
          itemBuilder: (BuildContext ctxt, int index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(Icons.school),
                ),
                title: Text('Ecole d\'ingénieur'),
              ),
        ),
      ),
    );
  }
}

class _SliverSkillsDelegate extends SliverPersistentHeaderDelegate {
  _SliverSkillsDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).canvasColor.withOpacity(.9),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CirculStack(
              'Expériences',
              35,
              Colors.greenAccent,
            ),
            CirculStack(
              'Excel',
              70,
              Colors.purpleAccent,
            ),
            CirculStack(
              'Anglais',
              50,
              Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 130;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CirculStack extends StatefulWidget {
  final String _title;
  final double _completePercent;
  final Color _color;

  CirculStack(this._title, this._completePercent, this._color);

  @override
  _CirculStackState createState() => _CirculStackState();
}

class _CirculStackState extends State<CirculStack>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animation = Tween(
      begin: 0,
      end: widget._completePercent,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )..addListener(() => setState(() {}));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomPaint(
            painter: CircleIndicator(
              _animation.value,
              widget._color,
            ),
          ),
          Center(
            child: Text(
              widget._title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleIndicator extends CustomPainter {
  final double _completePercent;
  Color _color;

  CircleIndicator(this._completePercent, this._color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = _color.withOpacity(.7)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * .2;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius =
        min(size.width / 2, size.height / 2) - line.strokeWidth / 2 - 5;

    double arcAngle = 2 * pi * _completePercent / 100;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
