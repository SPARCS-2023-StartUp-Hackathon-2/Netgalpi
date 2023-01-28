import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/alarm_viewmodel.dart';
import 'package:netgalpi/helper/datetime_parsor.dart';
import 'package:netgalpi/model/post_model.dart';

import 'components/photo_view.dart';

class AlarmView extends GetWidget<AlarmViewModel> {
  PostModel pm = PostModel(
    postId: 'postId',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/sparcs-hackathon.appspot.com/o/image%2Fpost%2Fdummy3.jpg?alt=media&token=0db69d77-f0a5-4814-8d80-ca71fc622fb4',
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
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: gray500),
            ),
            body: ListView.separated(
              itemCount: controller.alarmList.length,
              separatorBuilder: (context, index) => SizedBox(height: 5),
              itemBuilder: (context, index) => Container(
                height: 140,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(children: [
                    Container(
                      height: 108,
                      width: 72,
                      child: PhotoView(
                          imageProvider: new CachedNetworkImageProvider(
                              controller.alarmList[index].imageUrl)),
                    ),
                    SizedBox(width: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datetimeParsor(DateTime.parse(
                              controller.alarmList[index].uploadedAt)),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: gray500,
                          ),
                        ),
                        Text(
                          controller.alarmList[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: gray700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'by @' + controller.alarmList[index].writerId,
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
                              onPressed: () {
                                controller.deletePending(
                                    controller.alarmList[index].postId, false);
                              },
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
                              onPressed: () {
                                controller.deletePending(
                                    controller.alarmList[index].postId, true);
                                //Get.to(() => Detailview(index인자로));
                              },
                              child: Text(
                                '수락',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: validGreen,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 206, 238, 198),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
          );
        });
  }
}
