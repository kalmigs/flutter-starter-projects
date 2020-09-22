import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:pomodoro_timer/pages/home.dart';

class AppController extends GetxController {
  final isPlayed = false.obs;

  toggleIsPlayed() => isPlayed.value = !isPlayed.value;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() async {
    await Settings.init(cacheProvider: SharePreferenceCache());
    Get.off(HomePage());
  }
}
