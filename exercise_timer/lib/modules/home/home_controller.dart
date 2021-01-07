import 'package:exercise_timer/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';

Widget widgetTitle(String title) => Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(title, style: TextStyle(fontSize: 25, color: colorPrimary)),
    );

TextStyle tsCancel = TextStyle(color: colorBlack, fontSize: 20);
TextStyle tsConfirm = TextStyle(color: colorBlack, fontSize: 20);
TextStyle tsSelected = TextStyle(color: colorPrimary);

class HomeController extends GetxController {
  int _exerciseMin = 15;
  int _exerciseSec = 0;
  int _restMin = 0;
  int _restSec = 30;
  int _laps = 3;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _exerciseDisplayed = ''.obs;
  get exerciseDisplayed => this._exerciseDisplayed.value;
  set exerciseDisplayed(value) => this._exerciseDisplayed.value = value;

  final _restDisplayed = '00:30'.obs;
  get restDisplayed => this._restDisplayed.value;
  set restDisplayed(value) => this._restDisplayed.value = value;

  final _lapsDisplayed = ''.obs;
  get lapsDisplayed => this._lapsDisplayed.value;
  set lapsDisplayed(value) => this._lapsDisplayed.value = value;

  @override
  void onInit() {
    exerciseDisplayed = intTimeToString(_exerciseMin, _exerciseSec);
    restDisplayed = intTimeToString(_restMin, _restSec);
    lapsDisplayed = _laps.toString().padLeft(2, '0');
    super.onInit();
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
        selecteds: [_exerciseMin, _exerciseSec],
        cancelTextStyle: tsCancel,
        confirmTextStyle: tsConfirm,
        selectedTextStyle: tsSelected,
        columnPadding: const EdgeInsets.all(8.0),
        height: Get.height / 3,
        onConfirm: (Picker picker, List<int> value) {
          _exerciseMin = value[0];
          _exerciseSec = value[1];
          exerciseDisplayed = intTimeToString(_exerciseMin, _exerciseSec);
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
        selecteds: [_restMin, _restSec],
        cancelTextStyle: tsCancel,
        confirmTextStyle: tsConfirm,
        selectedTextStyle: tsSelected,
        columnPadding: const EdgeInsets.all(8.0),
        height: Get.height / 3,
        onConfirm: (Picker picker, List<int> value) {
          _restMin = value[0];
          _restSec = value[1];
          restDisplayed = intTimeToString(_restMin, _restSec);
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
          lapsDisplayed = _laps.toString().padLeft(2, '0');
        });
    picker.show(scaffoldKey.currentState);
  }

  intTimeToString(int minute, int second) {
    return minute.toString().padLeft(2, '0') +
        ':' +
        second.toString().padLeft(2, '0');
  }
}
