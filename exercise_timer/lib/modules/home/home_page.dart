import 'package:exercise_timer/modules/home/home_controller.dart';
import 'package:exercise_timer/theme/colors.dart';
import 'package:exercise_timer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
  final TextStyle tsHeader = TextStyle(fontSize: 25, color: colorPrimary);
  final TextStyle tsNumber = GoogleFonts.shareTechMono(fontSize: 70);
  static const double buttonSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        width: Get.context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _exercise,
            _rest,
            _laps,
            _buttons,
          ],
        ),
      ),
    );
  }

  Widget get _exercise {
    return GestureDetector(
      child: Column(
        children: [
          Text('Exercise', style: tsHeader),
          Obx(() => Text(controller.exerciseDisplayed, style: tsNumber)),
        ],
      ),
      onTap: controller.editExerciseTimer,
    );
  }

  Widget get _rest {
    return GestureDetector(
      child: Column(
        children: [
          Text('Rest', style: tsHeader),
          Obx(() => Text(controller.restDisplayed, style: tsNumber)),
        ],
      ),
      onTap: controller.editRestTimer,
    );
  }

  Widget get _laps {
    return GestureDetector(
      child: Column(
        children: [
          Text('Laps', style: tsHeader),
          Obx(() => Text(controller.lapsDisplayed, style: tsNumber)),
        ],
      ),
      onTap: controller.editLapCount,
    );
  }

  Widget get _buttons {
    return Obx(() => (controller.appState == AppState.notStarted)
        ? MaterialButton(
            child: Icon(
              Icons.play_arrow_rounded,
              size: buttonSize,
            ),
            onPressed: controller.play,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                child: Icon(
                  controller.appState == AppState.startedPlay
                      ? Icons.pause_rounded
                      : controller.play,
                  size: buttonSize,
                ),
                onPressed: controller.pause,
              ),
              MaterialButton(
                child: Icon(
                  Icons.stop_rounded,
                  size: buttonSize,
                ),
                onPressed: controller.stop,
              )
            ],
          ));
  }
}
