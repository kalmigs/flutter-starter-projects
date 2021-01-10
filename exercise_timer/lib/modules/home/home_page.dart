import 'package:exercise_timer/modules/home/home_controller.dart';
import 'package:exercise_timer/theme/colors.dart';
import 'package:exercise_timer/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
  final TextStyle tsHeader = TextStyle(fontSize: 25, color: colorPrimary);
  final TextStyle tsNumberStopped = GoogleFonts.shareTechMono(fontSize: 70);
  final TextStyle tsNumberStarted = GoogleFonts.shareTechMono(fontSize: 140);
  final TextStyle tsNumberSmall = GoogleFonts.shareTechMono(fontSize: 35);
  static const double buttonSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        width: Get.context.width,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (controller.appState == AppState.stopped ||
                  controller.isExercise)
                _exercise,
              if (controller.appState == AppState.stopped ||
                  !controller.isExercise)
                _rest,
              if (controller.appState == AppState.stopped) _laps,
              _buttons,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _exercise {
    return GestureDetector(
      child: Column(
        children: [
          Text('Exercise', style: tsHeader),
          Text(controller.exerciseDisplayed,
              style: controller.appState == AppState.stopped
                  ? tsNumberStopped
                  : tsNumberStarted),
          if (!(controller.appState == AppState.stopped))
            Text(
              controller.lapCount.toString() + '/' + controller.lapsDisplayed,
              style: tsNumberSmall,
            ),
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
          Text(controller.restDisplayed,
              style: controller.appState == AppState.stopped
                  ? tsNumberStopped
                  : tsNumberStarted),
          if (!(controller.appState == AppState.stopped))
            Text(
              controller.lapCount.toString() + '/' + controller.lapsDisplayed,
              style: tsNumberSmall,
            ),
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
          Text(controller.lapsDisplayed, style: tsNumberStopped),
        ],
      ),
      onTap: controller.editLapCount,
    );
  }

  Widget get _buttons {
    return (controller.appState == AppState.stopped)
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
                      : Icons.play_arrow_rounded,
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
          );
  }
}
