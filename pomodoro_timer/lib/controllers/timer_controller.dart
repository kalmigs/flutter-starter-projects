import 'dart:async';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/state_manager.dart';

class TimerController extends GetxController {
  static const int defaultPDuration = 25;
  static const int defaultSBreak = 5;
  static const int defaultLBreak = 15;
  static const int defaultPCount = 4;
  static const String keyPDuration = 'pomodoro-duration';
  static const String keySBreak = 'short-break';
  static const String keyLBreak = 'long-break';
  static const String keyPCount = 'pomodoro-count';

  final minutes = 0.toString().padLeft(2, '0').obs;
  final seconds = '00'.obs;
  final percentage = 1.0.obs;
  final isPause = false.obs;
  final isBreak = false.obs;
  final isLBreak = false.obs;

  StreamSubscription timerSub;
  int _pCounter = 0;
  bool _next = false;
  int pDuration = 0;
  int sBreak = 0;
  int lBreak = 0;
  int pCount = 0;

  void getValuesFromCache() {
    pDuration =
        Settings.getValue<double>(keyPDuration, defaultPDuration.toDouble())
            .round();
    sBreak =
        Settings.getValue<double>(keySBreak, defaultSBreak.toDouble()).round();
    lBreak =
        Settings.getValue<double>(keyLBreak, defaultLBreak.toDouble()).round();
    pCount =
        Settings.getValue<double>(keyPCount, defaultPCount.toDouble()).round();
  }

  stop() {
    minutes.value = pDuration.toString().padLeft(2, '0');
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
    getValuesFromCache();

    minutes.value = pDuration.toString();
    seconds.value = '00';
    percentage.value = 1;

    _pCounter++;
    if (_pCounter >= pCount) isLBreak.value = true;

    timerSub = timeStream(pDuration * 60).listen((event) {
      if (event < 0) {
        isBreak.value = !isBreak.value;

        minutes.value =
            ((isLBreak.value) ? lBreak : sBreak).toString().padLeft(2, '0');
        seconds.value = '00';
        percentage.value = 1;

        breakTime();
      } else {
        minutes.value = (event / 60).floor().toString().padLeft(2, '0');
        seconds.value = (event % 60).floor().toString().padLeft(2, '0');
        percentage.value = event / (pDuration * 60);
      }
    });
  }

  breakTime() {
    timerSub =
        timeStream(((isLBreak.value) ? lBreak : sBreak) * 60).listen((event) {
      if (event < 0) {
        isBreak.value = !isBreak.value;
        isPause.value = true;

        minutes.value = pDuration.toString().padLeft(2, '0');
        seconds.value = '00';
        percentage.value = 1;

        _next = true;

        if (isLBreak.value) {
          isLBreak.value = false;
          _pCounter = 0;
        }
      } else {
        minutes.value = (event / 60).floor().toString().padLeft(2, '0');
        seconds.value = (event % 60).floor().toString().padLeft(2, '0');
        percentage.value = event / (((isLBreak.value) ? lBreak : sBreak) * 60);
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
