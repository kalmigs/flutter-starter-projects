import 'dart:async';

import 'package:get/get.dart';

class AppController extends GetxController {
  final isPlayed = false.obs;

  toggleIsPlayed() => isPlayed.value = !isPlayed.value;
}

class TimerController extends GetxController {
  static const double pDurationMin = 3; //25 minutes
  static const int pDurationSec = 3 * 60; //25 minutes
  static const int lBreakMin = 2;
  static const int lBreakSec = 2 * 60;
  static const double sBreakMin = 1;
  static const int sBreakSec = 1 * 60;
  static const int pCount = 3;

  final minutes = pDurationMin.toInt().toString().padLeft(2, '0').obs;
  final seconds = '00'.obs;
  final percentage = 1.0.obs;
  final isPause = false.obs;
  final isBreak = false.obs;
  final isLBreak = false.obs;

  StreamSubscription timerSub;
  int _pCounter = 0;
  bool _next = false;

  stop() {
    minutes.value = pDurationMin.toInt().toString().padLeft(2, '0');
    seconds.value = '00';
    percentage.value = 1.0;
    isPause.value = false;
    isBreak.value = false;
    isLBreak.value = false;

    timerSub.cancel();
    timerSub = null;
    _pCounter = 0;
    _next = false;
  }

  play() {
    _pCounter++;
    if (_pCounter >= pCount) isLBreak.value = true;

    timerSub = timeStream(pDurationSec).listen((event) {
      if (event < 0) {
        isBreak.value = !isBreak.value;

        minutes.value = ((isLBreak.value) ? lBreakMin : sBreakMin)
            .toInt()
            .toString()
            .padLeft(2, '0');
        seconds.value = '00';
        percentage.value = 1;

        breakTime();
      } else {
        minutes.value = ((event / 60) % 60).floor().toString().padLeft(2, '0');
        seconds.value = (event % 60).floor().toString().padLeft(2, '0');
        percentage.value = event / (pDurationSec);
      }
    });
  }

  breakTime() {
    timerSub =
        timeStream((isLBreak.value) ? lBreakSec : sBreakSec).listen((event) {
      if (event < 0) {
        isBreak.value = !isBreak.value;
        isPause.value = true;

        minutes.value = pDurationMin.toInt().toString().padLeft(2, '0');
        seconds.value = '00';
        percentage.value = 1;

        _next = true;

        if (isLBreak.value) {
          isLBreak.value = false;
          _pCounter = 0;
        }
      } else {
        minutes.value = ((event / 60) % 60).floor().toString().padLeft(2, '0');
        seconds.value = (event % 60).floor().toString().padLeft(2, '0');
        percentage.value = event / ((isLBreak.value) ? lBreakSec : sBreakSec);
      }
    });
  }

  toggle() {
    isPause.value = !isPause.value;

    if (_next) {
      play();
    } else {
      if (isPause.value)
        timerSub.pause();
      else
        timerSub.resume();
    }
  }

  Stream<int> timeStream(int seconds) {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = seconds;

    void stopTimer() {
      timer?.cancel();
      timer = null;
      counter = 0;
      streamController.close();
    }

    void pauseTimer() {
      timer?.cancel();
      timer = null;
    }

    void tick(_) {
      counter--;
      streamController.add(counter);

      if (counter < 0) stopTimer();
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: pauseTimer,
    );

    return streamController.stream;
  }

  @override
  void disposeId(String id) {
    timerSub?.cancel();
    timerSub = null;

    super.disposeId(id);
  }
}
