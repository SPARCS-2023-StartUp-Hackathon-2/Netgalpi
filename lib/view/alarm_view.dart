import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/alarm_viewmodel.dart';
import 'package:netgalpi/model/post_model.dart';

class AlarmView extends GetWidget<AlarmViewModel> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlarmViewModel>(
        init: AlarmViewModel(),
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: gray500),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'This is AlbumView',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class OneAlarm extends StatelessWidget {
  final PostModel _alarm;
  const OneAlarm(this._alarm, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(children: [
          //Image
          SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_alarm.uploadedAt),
              Text(_alarm.title),
              Text('by @' + _alarm.writerId),
              Row(children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('거절'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('수락'),
                ),
              ]),
            ],
          )
        ]),
      ),
    );
  }
}
