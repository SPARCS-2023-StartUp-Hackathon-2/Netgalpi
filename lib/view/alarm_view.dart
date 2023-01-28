import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/alarm_viewmodel.dart';
import 'package:netgalpi/helper/datetime_parsor.dart';
import 'package:netgalpi/model/post_model.dart';

class AlarmView extends GetWidget<AlarmViewModel> {
  PostModel pm = PostModel(
    postId: 'postId',
    imageUrl: 'imageUrl',
    mp4Url: 'mp4Url',
    title: 'title',
    isOpened: true,
    writerId: 'writerId',
    uploadedAt: DateTime.now().toUtc().toIso8601String(),
    mentionIdList: ['mentionIdList'],
    likerIdList: ['likerIdList'],
    contentIdList: ['contentIdList'],
  );
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
            body: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => SizedBox(height: 5),
              itemBuilder: (context, index) => OneAlarm(pm),
            ),
            // body: ListView.separated(
            //   itemCount: controller.alarmList.length,
            //   separatorBuilder: (context, index) => Divider(),
            //   itemBuilder: (context, index) =>
            //       OneAlarm(controller.alarmList[index]),
            // ),
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
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(children: [
          //Image
          SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                datetimeParsor(DateTime.parse(_alarm.uploadedAt)),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: gray500,
                ),
              ),
              Text(
                _alarm.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: gray700,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'by @' + _alarm.writerId,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: gray300,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 24,
                child: Row(children: [
                  FilledButton(
                    onPressed: () {},
                    child: Text(
                      '거절',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: salmon500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: salmon50,
                    ),
                  ),
                  SizedBox(width: 10),
                  FilledButton(
                    onPressed: () {},
                    child: Text(
                      '수락',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: validGreen,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 206, 238, 198),
                    ),
                  ),
                ]),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
