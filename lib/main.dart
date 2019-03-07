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
        primarySwatch: Colors.blue,
        primaryColor: Colors.red,
        accentColor: Colors.blue[600]
      ),  
        home: TabNavigation(),
      );
    }
  }