import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:pomodoro_timer/pages/home.dart';

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.deepPurpleAccent));
}
