import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Account', style: Theme.of(context).textTheme.display2),
      ),
    );
  }
}