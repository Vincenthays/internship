import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:seb/data/internships.dart';

enum CardAction {
  apply,
  decline,
  favorite,
  reset,
  next,
}

class NewCardPosition {
  double x = 0;
  double y = 0;
  int duration = 0;
  double rotation = 0;

  NewCardPosition();

  NewCardPosition.apply()
      : x = 900,
        rotation = 0.9,
        duration = 300;

  NewCardPosition.decline()
      : x = -900,
        rotation = -0.9,
        duration = 300;

  NewCardPosition.favorite()
      : y = -900,
        duration = 300;

  NewCardPosition.reset() : duration = 300;

  void update(DragUpdateDetails dud) {
    x += dud.delta.dx;
    y += dud.delta.dy;
    rotation = x / 1000;
    duration = 0;
  }
}

class InternshipsCards {
  Internship foreground;
  Internship background;

  InternshipsCards({
    @required this.foreground,
    @required this.background,
  })  : assert(foreground != null),
        assert(background != null);

  InternshipsCards.initalData()
      : foreground = internships[0],
        background = internships[1];

  InternshipsCards.atIndex(int index)
      : foreground = internships[index % internships.length],
        background = internships[(index + 1) % internships.length];
}

class Internship {
  String name;
  List<String> images;
  String description;

  Internship({
    @required this.name,
    @required this.images,
    this.description = 'Description ...',
  })  : assert(name != null),
        assert(images.length > 0),
        assert(description != null);

  String get cover => images[0];
}
