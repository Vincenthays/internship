import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seb/bloc/card_bloc.dart';
import 'package:seb/event/card_event.dart';

class Internship {
  String name;
  List<String> images;
  String description;

  Internship({
    @required this.name,
    @required this.images,
    this.description = 'Description',
  })  : assert(name != null),
        assert(images.length > 0),
        assert(description != null);

  String get cover => images[0];
}

class CardSwipe extends StatefulWidget {
  @override
  _CardSwipeState createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  int _index = 0;
  int _length;
  final List<Internship> _internships = <Internship>[
    Internship(
      name: 'Amazon',
      images: <String>['images/amazon.png'],
    ),
    Internship(
      name: 'Apple',
      images: <String>['images/apple.png'],
    ),
    Internship(
      name: 'Facebook',
      images: <String>['images/facebook.png'],
    ),
    Internship(
      name: 'Google',
      images: <String>['images/google.png'],
    ),
    Internship(
      name: 'Leetchi',
      images: <String>['images/leetchi.png'],
    ),
    Internship(
      name: 'Tesla',
      images: <String>['images/tesla.png'],
    ),
    Internship(
      name: 'TF1',
      images: <String>['images/tf1.png'],
    ),
  ];

  @override
  void initState() {
    _length = _internships.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CardBloc>(context).stream.listen((event) {
      if (event == CardEvent.Next) {
        setState(() {
          _index++;
        });
      }
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AppBar(
              title: Text('Card'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) =>
                              _ModalBottomSheet());
                    }),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _Buttons(),
          ),
          Positioned(
            top: 95,
            right: 15,
            left: 15,
            bottom: 80,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ProfileCard(_internships[(_index + 1) % _length]),
                _Drag(
                  child: ProfileCard(_internships[_index % _length]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModalBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            'Filtres',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardBloc cardBloc = Provider.of<CardBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _MyButton.large(
            icon: Icons.clear,
            color: Colors.red,
            onPressed: () {
              cardBloc.sink.add(CardEvent.Decline);
            },
          ),
          _MyButton.large(
            icon: Icons.star,
            color: Colors.blue,
            onPressed: () => {},
          ),
          _MyButton.large(
            icon: Icons.favorite,
            color: Colors.green,
            onPressed: () {
              cardBloc.sink.add(CardEvent.Apply);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final double _borderRadius = 7;
  final Internship _internship;

  ProfileCard(this._internship) : assert(_internship != null);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_borderRadius),
            child: Image.asset(
              _internship.cover,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            children: <Widget>[
              for (var i = 0; i < 4; i += 1)
                Expanded(
                  child: Container(
                    height: 5,
                    color: Colors.white.withOpacity(i == 0 ? .8 : .3),
                    margin: EdgeInsets.all(3),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.transparent, Colors.black],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(_borderRadius),
                bottomRight: Radius.circular(_borderRadius),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        _internship.name,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _internship.description,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.info),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Drag extends StatefulWidget {
  final Widget child;

  _Drag({@required this.child}) : assert(child != null);

  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _x = 0;
  double _y = 0;
  double _rotate = 0;
  int _duration = 0;
  StreamSink<CardEvent> _sink;

  @override
  Widget build(BuildContext context) {
    CardBloc cardbloc = Provider.of<CardBloc>(context);
    _sink = cardbloc.sink;

    cardbloc.stream.listen((event) {
      switch (event) {
        case CardEvent.Apply:
          _apply();
          break;
        case CardEvent.Decline:
          _decline();
          break;
        case CardEvent.Favorite:
          _favorite();
          break;
        default:
          break;
      }
    });

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedContainer(
        duration: Duration(milliseconds: _duration),
        transform: Matrix4.identity()
          ..translate(_x, _y)
          ..rotateZ(_rotate),
        child: widget.child,
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails dud) {
    setState(() {
      _x += dud.delta.dx;
      _y += dud.delta.dy;
      _rotate = _x / 1000;
      _duration = 0;
    });
  }

  void _onPanEnd(DragEndDetails ded) {
    Offset velocity = ded.velocity.pixelsPerSecond;
    print(_y);
    if (velocity.dx > 10 && _x > 100) {
      _sink.add(CardEvent.Apply);
    } else if (velocity.dx < -10 && _x < -100) {
      _sink.add(CardEvent.Decline);
    } else if (velocity.dy < -10 && _y < -200) {
      _sink.add(CardEvent.Favorite);
    } else {
      _reset();
    }
  }

  void _apply() {
    setState(() {
      _x = 900;
      _rotate = _x / 1000;
      _duration = 300;
    });
  }

  void _decline() {
    setState(() {
      _x = -900;
      _rotate = _x / 1000;
      _duration = 300;
    });
  }

  void _favorite() {
    setState(() {
      _y = -900;
      _x = 0;
      _rotate = 0;
      _duration = 300;
    });
  }

  void _reset() {
    setState(() {
      _x = 0;
      _y = 0;
      _rotate = 0;
      _duration = 300;
    });
  }

  void _nextProfile() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _x = 0;
      _y = 0;
      _rotate = 0;
      _duration = 0;
    });
    _sink.add(CardEvent.Next);
  }
}

class _MyButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onPressed;
  final Color color;

  _MyButton.small({
    @required this.icon,
    @required this.onPressed,
    @required this.color,
  }) : size = 20;

  _MyButton.large({
    @required this.icon,
    @required this.onPressed,
    @required this.color,
  }) : size = 30;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(),
      fillColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      shape: CircleBorder(),
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
