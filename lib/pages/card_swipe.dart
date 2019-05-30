import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seb/bloc/card_bloc.dart';
import 'package:seb/event/card_event.dart';

class CardSwipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: CardBloc(),
      child: _CardSwipe(),
    );
  }
}

class _CardSwipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: StreamBuilder<InternshipsCards>(
                stream: Provider.of<CardBloc>(context).cards,
                initialData: InternshipsCards.initalData(),
                builder: (context, snapshot) {
                  final InternshipsCards cards = snapshot.data;
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      _ProfileCard(cards.background),
                      _Drag(child: _ProfileCard(cards.foreground)),
                    ],
                  );
                }),
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
    final StreamSink inputSink = Provider.of<CardBloc>(context).input;
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
            onPressed: () => inputSink.add(CardAction.decline),
          ),
          _MyButton.large(
            icon: Icons.star,
            color: Colors.blue,
            onPressed: () => inputSink.add(CardAction.favorite),
          ),
          _MyButton.large(
            icon: Icons.favorite,
            color: Colors.green,
            onPressed: () => inputSink.add(CardAction.apply),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final double _borderRadius = 7;
  final Internship _internship;

  _ProfileCard(
    this._internship,
  ) : assert(_internship != null);

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

class _Drag extends StatelessWidget {
  final Widget child;

  _Drag({@required this.child});

  @override
  Widget build(BuildContext context) {
    CardBloc cardBloc = Provider.of<CardBloc>(context);
    return StreamBuilder(
        initialData: NewCardPosition(),
        stream: Provider.of<CardBloc>(context).newCardPositon,
        builder: (context, snapshot) {
          NewCardPosition cep = snapshot.data;
          return AnimatedContainer(
            duration: Duration(milliseconds: cep.duration),
            transform: Matrix4.identity()
              ..translate(cep.x, cep.y)
              ..rotateZ(cep.rotation),
            child: GestureDetector(
              onPanUpdate: (event) => cardBloc.input.add(event),
              onPanEnd: (event) => cardBloc.input.add(event),
              child: this.child,
            ),
          );
        });
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
