import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:pomodoro_timer/pages/splash_screen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    theme: ThemeData(
        primarySwatch: Colors.deepPurpleAccent[900],
        appBarTheme: AppBarTheme(color: Colors.deepPurpleAccent)),
  ));

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.deepPurpleAccent));
}
