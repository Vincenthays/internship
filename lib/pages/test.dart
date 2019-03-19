import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        centerTitle: true,
      ),
      body: Center(
          child: Drag()
      ),
    );
  }
}

class Drag extends StatefulWidget {
  final Widget child;

  Drag({this.child});
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  Offset offset = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: GestureDetector(
        child: Text('test'),
        onPanUpdate: (DragUpdateDetails dud) =>
            setState(() => offset += dud.delta),
      ),
    );
  }
}
