import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_timer/controllers/app_controller.dart';
import 'package:pomodoro_timer/controllers/timer_controller.dart';
import 'package:pomodoro_timer/pages/settings.dart';

class HomePage extends StatelessWidget {
  static const option1 = 'Settings';

  final AppController _cApp = Get.find<AppController>();
  final TimerController _cTimer = Get.find<TimerController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(() => (!_cApp.isPlayed.value)
              ? Stack(children: [
                  _bodyStart(),
                  _options(context),
                ])
              : _bodyPlay(context))),
    );
  }

  Widget _bodyPlay(BuildContext context) => Container(
        constraints: BoxConstraints.expand(),
        child: Obx(() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      (_cTimer.isBreak.value)
                          ? (_cTimer.isLBreak.value)
                              ? 'Long Break'
                              : 'Short Break'
                          : 'Pomodoro',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0)),
                  CircularPercentIndicator(
                    radius: MediaQuery.of(context).size.width - 50,
                    lineWidth: 13.0,
                    animation: false,
                    percent: _cTimer.percentage.value,
                    center: Text(
                      "${_cTimer.minutes}:${_cTimer.seconds}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 100.0),
                    ),
                    footer: _footer(),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: (_cTimer.isBreak.value)
                        ? Colors.greenAccent
                        : Colors.deepPurpleAccent,
                  ),
                ],
              ),
            )),
      );

  Widget _footer() => Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Obx(() => (_cTimer.isPause.value)
                  ? Icon(Icons.play_arrow)
                  : Icon(Icons.pause)),
              onPressed: _cTimer.togglePlayPause,
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                _cApp.toggleIsPlayed();
                _cTimer.stop();
              },
            ),
          ],
        ),
      );

  Widget _bodyStart() => GestureDetector(
        onTap: () {
          _cApp.toggleIsPlayed();
          _cTimer.play();
        },
        child: Center(
          child: Icon(Icons.play_arrow, size: 200),
        ),
      );

  // Show "More Options" button at top right of homepage
  Widget _options(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert),
          onSelected: (selected) => _optionChoice(selected),
          itemBuilder: (context) => <PopupMenuItem<String>>[
            PopupMenuItem(
              value: option1,
              child: Text(option1),
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      );

  void _optionChoice(String selected) {
    if (selected == option1) Get.to(SettingsPage());
  }
}
