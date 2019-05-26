import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:seb/bloc/card_bloc.dart';

import './pages/tab_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CardBloc>.value(
          value: CardBloc(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
