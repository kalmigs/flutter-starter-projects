import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/home/home_binding.dart';
import 'modules/home/home_page.dart';
import 'theme/colors.dart';

void main() async {
  await Get.putAsync(
    () async => await SharedPreferences.getInstance(),
    permanent: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
