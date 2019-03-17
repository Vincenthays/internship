import 'package:flutter/material.dart';

import 'dart:ui' show ImageFilter;

class MyAppBarBackground extends StatelessWidget {
  const MyAppBarBackground({this.appBar});

  final Widget appBar;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: appBar,
    );
  }
}
