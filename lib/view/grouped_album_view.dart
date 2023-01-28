import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';

class GroupedAlbumView extends StatelessWidget {
  const GroupedAlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize postList, show main album
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<PostListViewModel>(
          builder: (controller) {
            return Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  // height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        controller.groupedPostIdListMap.keys.length, (index) {
                      String nicknameKey =
                          controller.groupedPostIdListMap.keys.elementAt(index);
                      List<String> postIdList =
                          controller.groupedPostIdListMap[nicknameKey]!;
                      return GestureDetector(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                nicknameKey,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: gray700,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                    min(3, postIdList.length), (index) {
                                  var size = MediaQuery.of(context).size;
                                  final double itemWidth =
                                      size.width / 3 - 4 * 4;
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: SizedBox(
                                        height: itemWidth,
                                        width: itemWidth,
                                        child: Image(
                                          image: controller
                                              .postImgMap[postIdList[index]]!,
                                          fit: BoxFit.cover,
                                        )),
                                  );
                                }),
                              ),
                              // ignore: prefer_const_constructors
                              SizedBox(
                                height: 20, // <-- SEE HERE
                              ),
                            ]),
                        onTap: () {
                          // Click filter card view
                          controller.setSelectedNickName(nicknameKey);
                          controller.setCurrentPostIdList(postIdList);
                          Get.back();
                        },
                      );
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: GestureDetector(
        child: Container(
          alignment: const Alignment(1.5, -0.62),
          child: Stack(
            alignment: Alignment(0.2, 0.0),
            children: <Widget>[
              SvgPicture.asset(
                'assets/bookmark.svg',
              ),
              Text(
                '함께한 친구들',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // set current
          Get.find<PostListViewModel>().setSelectedNickName(null);
          Get.back(canPop: true);
        },
      ),
    );
  }
}
