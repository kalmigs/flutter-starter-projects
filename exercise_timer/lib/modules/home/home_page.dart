import 'package:exercise_timer/modules/home/home_controller.dart';
import 'package:exercise_timer/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
  final TextStyle tsHeader = TextStyle(fontSize: 25, color: colorPrimary);
  final TextStyle tsNumber = GoogleFonts.shareTechMono(fontSize: 70);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        width: Get.context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _exercise(context),
            _rest,
            _laps,
          ],
        ),
      ),
    );
  }

  Widget _exercise(BuildContext context) {
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
}
