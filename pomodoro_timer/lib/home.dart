import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_timer/app_controller.dart';

class Home extends StatelessWidget {
  final AppController _cApp = Get.put(AppController());
  final TimerController _cTimer = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(() => (!_cApp.isPlayed.value)
              ? Stack(children: [
                  _bodyStart(),
                  _settings(context),
                ])
              : _bodyPlay(context))),
    );
  }

  _bodyPlay(BuildContext context) => Container(
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

  _footer() => Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Obx(() => (_cTimer.isPause.value)
                  ? Icon(Icons.play_arrow)
                  : Icon(Icons.pause)),
              onPressed: _cTimer.toggle,
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

  _bodyStart() => GestureDetector(
        onTap: () {
          _cApp.toggleIsPlayed();
          _cTimer.play();
        },
        child: Center(
          child: Icon(Icons.play_arrow, size: 200),
        ),
      );

  _settings(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      );
}
