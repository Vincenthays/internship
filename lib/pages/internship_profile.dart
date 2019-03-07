import 'package:flutter/material.dart';

class InternshipProfile extends StatelessWidget {
  final String _name;

  InternshipProfile(this._name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Offer detail', style: Theme.of(context).textTheme.display2),
      ),
    );
  }
}