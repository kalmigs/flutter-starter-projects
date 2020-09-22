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

  StreamSubscription _timerSub;
  bool _next = false;
  int _pCounter = 0;
  int _pDuration = 0;
  int _sBreak = 0;
  int _lBreak = 0;
  int _pCount = 0;

  // Get pomodoro/break time & count values from SharedPrefs Cache
  void _getValuesFromCache() {
    _pDuration =
        Settings.getValue<double>(keyPDuration, defaultPDuration.toDouble())
            .round();
    _sBreak =
        Settings.getValue<double>(keySBreak, defaultSBreak.toDouble()).round();
    _lBreak =
        Settings.getValue<double>(keyLBreak, defaultLBreak.toDouble()).round();
    _pCount =
        Settings.getValue<double>(keyPCount, defaultPCount.toDouble()).round();
  }

  // Stop pomodoro/break timer
  void stop() {
    minutes.value = _pDuration.toString().padLeft(2, '0');
    seconds.value = '00';
    percentage.value = 1.0;
    isPause.value = false;
    isBreak.value = false;
    isLBreak.value = false;

    _timerSub.cancel();
    _timerSub = null;
    _pCounter = 0;
    _next = false;
  }

  // Start pomodoro timer
  void play() {
    _getValuesFromCache();

    minutes.value = _pDuration.toString().padLeft(2, '0');
    seconds.value = '00';
    percentage.value = 1;

    _pCounter++;
    if (_pCounter >= _pCount) isLBreak.value = true;

    _timerSub = _timeStream(_pDuration * 60).listen((event) {
      if (event < 0) {
        isBreak.value = !isBreak.value;

        minutes.value =
            ((isLBreak.value) ? _lBreak : _sBreak).toString().padLeft(2, '0');
        seconds.value = '00';
        percentage.value = 1;

        _breakTime();
      } else {
        minutes.value = (event / 60).floor().toString().padLeft(2, '0');
        seconds.value = (event % 60).floor().toString().padLeft(2, '0');
        percentage.value = event / (_pDuration * 60);
      }
    });
  }

  // Start break timer after every pomodoro timer
  void _breakTime() {
    _timerSub = _timeStream(((isLBreak.value) ? _lBreak : _sBreak) * 60)
        .listen((event) {
      if (event < 0) {
        isBreak.value = !isBreak.value;
        isPause.value = true;

        minutes.value = _pDuration.toString().padLeft(2, '0');
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
        percentage.value =
            event / (((isLBreak.value) ? _lBreak : _sBreak) * 60);
      }
    });
  }

  // toggle button for play/pause
  void togglePlayPause() {
    isPause.value = !isPause.value;

    if (_next) {
      play();
    } else {
      if (isPause.value)
        _timerSub.pause();
      else
        _timerSub.resume();
    }
  }

  // returns a stream of value in time in seconds(int)
  Stream<int> _timeStream(int seconds) {
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

  // dispose timer subscription
  @override
  void disposeId(String id) {
    _timerSub?.cancel();
    _timerSub = null;

    super.disposeId(id);
  }
}
