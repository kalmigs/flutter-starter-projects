import 'package:exercise_timer/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final TextStyle tsHeader = TextStyle(fontSize: 25, color: colorPrimary);
  final TextStyle tsNumber = GoogleFonts.shareTechMono(fontSize: 70);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
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
          Text('15:00', style: tsNumber),
        ],
      ),
      onTap: () {
        Picker picker = Picker(
            adapter: PickerDataAdapter<String>(
              pickerdata: [
                List.generate(60, (index) => index),
                List.generate(60, (index) => index),
              ],
              isArray: true,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text("Exercise Timer",
                  style: TextStyle(fontSize: 25, color: colorPrimary)),
            ),
            selecteds: [3, 3],
            cancelTextStyle: TextStyle(color: colorBlack, fontSize: 20),
            confirmTextStyle: TextStyle(color: colorBlack, fontSize: 20),
            textStyle: TextStyle(color: colorBlack),
            textAlign: TextAlign.left,
            selectedTextStyle: TextStyle(color: colorPrimary),
            columnPadding: const EdgeInsets.all(8.0),
            height: Get.height / 3,
            onConfirm: (Picker picker, List value) {
              print(value.toString());
              print(picker.getSelectedValues());
            });
        picker.show(_scaffoldKey.currentState);
      },
    );
  }

  Widget get _rest {
    return GestureDetector(
      child: Column(
        children: [
          Text('Rest', style: tsHeader),
          Text('00:30', style: tsNumber),
        ],
      ),
    );
  }

  Widget get _laps {
    return GestureDetector(
      child: Column(
        children: [
          Text('Laps', style: tsHeader),
          Text('05', style: tsNumber),
        ],
      ),
    );
  }
}
