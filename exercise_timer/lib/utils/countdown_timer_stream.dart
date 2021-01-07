import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerStream {
  StreamController<int> streamController;
  Timer timer;
  Duration timerInterval = Duration(seconds: 1);
  int counter; // in seconds

  CountdownTimerStream({@required this.counter});

  refreshTimer() {
    timer?.cancel();
    timer = null;
  }

  void pauseTimer() {
    refreshTimer();
  }

  void stopTimer() {
    refreshTimer();
    counter = 0;
    streamController.close();
  }

  void tick(_) {
    counter--;
    streamController.add(counter);

    if (counter < 0) stopTimer();
  }

  void startTimer() {
    refreshTimer();
    timer = Timer.periodic(timerInterval, tick);
  }

  // returns a stream of value in time in seconds(int)
  Stream<int> stream() {
    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: pauseTimer,
    );
    return streamController.stream;
  }
}
