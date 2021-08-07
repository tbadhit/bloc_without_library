import 'dart:async';

import 'package:flutter/material.dart';

enum ColorEvent { to_amber, to_light_blue }

class ColorBloc {
  // Yang menyimpan state
  Color _color = Colors.amber;

  // Controller EVENT
  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  // Di buat public agar bisa digunakan si button nanti
  StreamSink<ColorEvent> get eventSink => _eventController.sink;

  // Controller STATE
  StreamController<Color> _stateController = StreamController<Color>();
  // Dibikin private karna statenya nanti masuknya lewat mapEventToState
  StreamSink<Color> get _stateSink => _stateController.sink;
  // Dibuat public agar bisa digunakan di container nanti. (Nanti containernya menerima state terbaru)
  Stream<Color> get stateStream => _stateController.stream;

  // Create Map Event to State
  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.to_amber) {
      _color = Colors.amber;
    } else {
      _color = Colors.lightBlue;
    }

    _stateSink.add(_color);
  }

  // Hubungkan Stream Event controller masuk ke MapEventToState
  ColorBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  // Disponse membereskan si stream
  // Kalau tidak di disponse Streamcontroller akan terus memakan memori
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
