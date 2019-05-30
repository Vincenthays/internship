import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:seb/event/card_event.dart';

class CardBloc {
  NewCardPosition cardEndPosition = NewCardPosition();
  final StreamController<dynamic> _input = StreamController();
  final StreamController<dynamic> _output = StreamController.broadcast();
  final StreamController<InternshipsCards> _internshipsCards =
      StreamController<InternshipsCards>();
  int profileIndex = 0;

  StreamSink get input => _input.sink;

  Stream get newCardPositon =>
      _output.stream.where((e) => e is NewCardPosition);

  Stream<CardAction> get cardAction =>
      _output.stream.where((e) => e is CardAction);

  Stream<InternshipsCards> get cards => _internshipsCards.stream;
  
  CardBloc() {
    _input.stream.listen((e) {
      if (e is DragUpdateDetails) {
        cardEndPosition.update(e);
      } else if (e is DragEndDetails) {
        Offset velocity = e.velocity.pixelsPerSecond;
        if (velocity.dx > 10 && cardEndPosition.x > 100) {
          cardEndPosition = NewCardPosition.apply();
          _nextProfile();
        } else if (velocity.dx < -10 && cardEndPosition.x < -100) {
          cardEndPosition = NewCardPosition.decline();
          _nextProfile();
        } else if (velocity.dy < -10 && cardEndPosition.y < -200) {
          cardEndPosition = NewCardPosition.favorite();
          _nextProfile();
        } else
          cardEndPosition = NewCardPosition.reset();
      } else if (e is CardAction) {
        switch (e) {
          case CardAction.apply:
            cardEndPosition = NewCardPosition.apply();
            _nextProfile();
            break;
          case CardAction.decline:
            cardEndPosition = NewCardPosition.decline();
            _nextProfile();
            break;
          case CardAction.favorite:
            cardEndPosition = NewCardPosition.favorite();
            _nextProfile();
            break;
          default:
            cardEndPosition = null;
            break;
        }
      } else {
        cardEndPosition = null;
      }
      if (cardEndPosition != null) _output.sink.add(cardEndPosition);
    });
  }

  void _nextProfile() async {
    await Future.delayed(Duration(milliseconds: 300));
    _internshipsCards.sink.add(InternshipsCards.atIndex(++profileIndex));
    cardEndPosition = NewCardPosition();
    _output.sink.add(cardEndPosition);
  }
}
