import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:pomodoro_timer/controllers/timer_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() => Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            SliderSettingsTile(
              title: 'Pomodoro duration (in minutes)',
              settingKey: TimerController.keyPDuration,
              defaultValue: TimerController.defaultPDuration.toDouble(),
              min: 1,
              max: 100,
              step: 1,
            ),
            SliderSettingsTile(
              title: 'Break duration (in minutes)',
              settingKey: TimerController.keySBreak,
              defaultValue: TimerController.defaultSBreak.toDouble(),
              min: 1,
              max: 100,
              step: 1,
            ),
            SliderSettingsTile(
              title: 'Long break duration (in minutes)',
              settingKey: TimerController.keyLBreak,
              defaultValue: TimerController.defaultLBreak.toDouble(),
              min: 1,
              max: 100,
              step: 1,
            ),
            SliderSettingsTile(
              title: 'Pomodoros before a long break',
              settingKey: TimerController.keyPCount,
              defaultValue: TimerController.defaultPCount.toDouble(),
              min: 1,
              max: 20,
              step: 1,
            ),
            SimpleSettingsTile(
              title: 'Reset to Default',
              subtitle: '',
              onTap: () async {
                bool choice = await _popupChoice();
                if (choice ?? false) {
                  Settings.clearCache();
                  Get.back();
                }
              },
            ),
          ],
        ),
      );

  // if "yes" is selected, we restore default values for the pomodoro timer
  Future<bool> _popupChoice() async {
    bool choice = false;
    await Get.defaultDialog(
      title: '',
      content: Text('Are you sure?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            choice = true;
            Get.back();
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            choice = false;
            Get.back();
          },
        ),
      ],
    );
    return choice;
  }
}
