import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pomodoro_timer/controllers/app_controller.dart';
import 'package:pomodoro_timer/controllers/timer_controller.dart';

class SplashScreen extends StatelessWidget {
  final AppController cApp = Get.put(AppController());
  final TimerController cTimer = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.deepPurpleAccent),
        ),
      ),
    );
  }
}
