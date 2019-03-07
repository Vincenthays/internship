import 'package:flutter/material.dart';

import './pages/tab_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stages',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.red.withOpacity(.9),
        ),
        accentColor: Colors.blue[600]
      ),  
        home: TabNavigation(),
      );
    }
  }