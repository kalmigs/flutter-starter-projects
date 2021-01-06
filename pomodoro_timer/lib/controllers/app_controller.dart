import 'package:get/get.dart';

class AppController extends GetxController {
  final isPlayed = false.obs;

  // Toggle play/stop pomodoro timer
  void toggleIsPlayed() => isPlayed.value = !isPlayed.value;
}
