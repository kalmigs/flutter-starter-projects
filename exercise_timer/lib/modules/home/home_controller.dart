import 'dart:async';

import 'package:exercise_timer/theme/colors.dart';
import 'package:exercise_timer/utils/app_const.dart';
import 'package:exercise_timer/utils/countdown_timer_stream.dart';
import 'package:exercise_timer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget widgetTitle(String title) => Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(title, style: TextStyle(fontSize: 25, color: colorPrimary)),
    );

TextStyle tsCancel = TextStyle(color: colorBlack, fontSize: 20);
TextStyle tsConfirm = TextStyle(color: colorBlack, fontSize: 20);
TextStyle tsSelected = TextStyle(color: colorPrimary);

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription _countDownSub;

  int lapCount = 0;
  bool isExercise = true;

  get _eMin => _sp.getInt(AppConst.eMinStr);
  get _eSec => _sp.getInt(AppConst.eSecStr);
  get _rMin => _sp.getInt(AppConst.rMinStr);
  get _rSec => _sp.getInt(AppConst.rSecStr);
  get _laps => _sp.getInt(AppConst.lapsStr);
  set _eMin(v) => _sp.setInt(AppConst.eMinStr, v);
  set _eSec(v) => _sp.setInt(AppConst.eSecStr, v);
  set _rMin(v) => _sp.setInt(AppConst.rMinStr, v);
  set _rSec(v) => _sp.setInt(AppConst.rSecStr, v);
  set _laps(v) => _sp.setInt(AppConst.lapsStr, v);

  final _exerciseDisplayed = ''.obs;
  get exerciseDisplayed => this._exerciseDisplayed.value;
  set exerciseDisplayed(value) => this._exerciseDisplayed.value = value;

  final _restDisplayed = ''.obs;
  get restDisplayed => this._restDisplayed.value;
  set restDisplayed(value) => this._restDisplayed.value = value;

  final _lapsDisplayed = ''.obs;
  get lapsDisplayed => this._lapsDisplayed.value;
  set lapsDisplayed(value) => this._lapsDisplayed.value = value;

  final _appState = AppState.stopped.obs;
  get appState => this._appState.value;
  set appState(value) => this._appState.value = value;

  final _sp = Get.find<SharedPreferences>();

  @override
  void onInit() {
    _clearFields();
    super.onInit();
  }

  @override
  void dispose() {
    _countDownSub?.cancel();
    super.dispose();
  }

  _clearFields() {
    _countDownSub?.cancel();
    appState = AppState.stopped;
    lapCount = 0;
    isExercise = true;
    if (_eMin == null) {
      // should have more checking, but this is only a test
      _eMin = AppConst.eMin;
      _eSec = AppConst.eSec;
      _rMin = AppConst.rMin;
      _rSec = AppConst.rSec;
      _laps = AppConst.laps;
    }
    exerciseDisplayed = intTimeToString(_eMin, _eSec);
    restDisplayed = intTimeToString(_rMin, _rSec);
    // lapsDisplayed = (_laps).toString().padLeft(2, '0');
    lapsDisplayed = _laps.toString();
  }

  void editExerciseTimer() {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: [
            List.generate(101, (index) => index),
            List.generate(60, (index) => index),
          ],
          isArray: true,
        ),
        title: widgetTitle("Exercise Timer"),
        selecteds: [_eMin, _eSec],
        cancelTextStyle: tsCancel,
        confirmTextStyle: tsConfirm,
        selectedTextStyle: tsSelected,
        columnPadding: const EdgeInsets.all(8.0),
        height: Get.height / 3,
        onConfirm: (Picker picker, List<int> value) {
          _eMin = value[0];
          _eSec = value[1];
          exerciseDisplayed = intTimeToString(_eMin, _eSec);
        });
    picker.show(scaffoldKey.currentState);
  }

  void editRestTimer() {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: [
            List.generate(31, (index) => index),
            List.generate(60, (index) => index),
          ],
          isArray: true,
        ),
        title: widgetTitle("Rest Timer"),
        selecteds: [_rMin, _rSec],
        cancelTextStyle: tsCancel,
        confirmTextStyle: tsConfirm,
        selectedTextStyle: tsSelected,
        columnPadding: const EdgeInsets.all(8.0),
        height: Get.height / 3,
        onConfirm: (Picker picker, List<int> value) {
          _rMin = value[0];
          _rSec = value[1];
          restDisplayed = intTimeToString(_rMin, _rSec);
        });
    picker.show(scaffoldKey.currentState);
  }

  void editLapCount() {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: [
            List.generate(51, (index) => index),
          ],
          isArray: true,
        ),
        title: widgetTitle("Lap Count"),
        selecteds: [_laps],
        cancelTextStyle: tsCancel,
        confirmTextStyle: tsConfirm,
        selectedTextStyle: tsSelected,
        columnPadding: const EdgeInsets.all(8.0),
        height: Get.height / 3,
        onConfirm: (Picker picker, List<int> value) {
          _laps = value[0];
          // lapsDisplayed = _laps.toString().padLeft(2, '0');
          lapsDisplayed = _laps.toString();
        });
    picker.show(scaffoldKey.currentState);
  }

  intTimeToString(int minute, int second) {
    return minute.toString().padLeft(2, '0') +
        ':' +
        second.toString().padLeft(2, '0');
  }

  void play() {
    appState = AppState.startedPlay;
    exercise();
  }

  void exercise() {
    isExercise = true;
    restDisplayed = intTimeToString(_rMin, _rSec);
    lapCount++;
    _countDownSub?.cancel();
    _countDownSub = CountdownTimerStream(counter: _eMin * 60 + _eSec)
        .stream()
        .listen((sec) {
      if (sec >= 0)
        exerciseDisplayed =
            intTimeToString((sec / 60).floor(), (sec % 60).floor());
    }, onDone: () {
      if (lapCount < _laps)
        restTimer();
      else {
        //TODO display "Exercise Complete, Well done!" before "_clearFields();"
        _clearFields();
      }
    });
  }

  void restTimer() {
    isExercise = false;
    exerciseDisplayed = intTimeToString(_eMin, _eSec);
    _countDownSub?.cancel();
    _countDownSub = CountdownTimerStream(counter: _rMin * 60 + _rSec)
        .stream()
        .listen((sec) {
      if (sec >= 0)
        restDisplayed = intTimeToString((sec / 60).floor(), (sec % 60).floor());
    }, onDone: exercise);
  }

  void pause() {
    if (appState == AppState.startedPlay) {
      _countDownSub.pause();
      appState = AppState.startedPaused;
    } else {
      _countDownSub.resume();
      appState = AppState.startedPlay;
    }
  }

  void stop() => _clearFields();
}
