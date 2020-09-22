import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:pomodoro_timer/pages/home.dart';

class AppController extends GetxController {
  final isPlayed = false.obs;

  // Toggle play/stop pomodoro timer
  void toggleIsPlayed() => isPlayed.value = !isPlayed.value;

  // Initialize app
  @override
  void onInit() {
    _init();
    super.onInit();
  }

  // Initialize settings for timer values then go to HomePage after it's done
  void _init() async {
    await Settings.init(cacheProvider: SharePreferenceCache());
    Get.off(HomePage());
  }
}
