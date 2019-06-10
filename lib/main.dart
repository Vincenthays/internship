import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/tab_navigation.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stages',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.black.withOpacity(.7),
        ),
        accentColor: Colors.redAccent[100],
      ),
      home: TabNavigation(),
    );
  }
}
