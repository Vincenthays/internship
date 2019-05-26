import 'dart:async';

import '../event/card_event.dart';

class CardBloc {
  final StreamController _actionController = StreamController<CardEvent>.broadcast();

  StreamSink<CardEvent> get sink => _actionController.sink;

  Stream<CardEvent> get stream => _actionController.stream;

  void dispose() {
    _actionController.close();
  }
}
