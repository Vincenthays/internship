import 'package:flutter/material.dart';

import 'dart:ui' show ImageFilter;

class MyAppBarBackground extends StatelessWidget {
  final Widget appBar, body, floatingActionButton;

  MyAppBarBackground({this.appBar, this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: body,),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: appBar,
          ),
        )
      ],
    );
  }
}
