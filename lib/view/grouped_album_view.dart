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
    const namePostMapList = [
      {
        '동우': [
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu'
        ]
      },
      {
        '세진': [
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu'
        ]
      },
      {
        '동원': [
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu'
        ]
      },
      {
        '재모': [
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu'
        ]
      },
      {
        '도연': [
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu'
        ]
      },
      {
        '태연': [
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu'
        ]
      },
      {
        'xdjfks': [
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu',
          'rBi45E2Ldz1Qx58K5Buu'
        ]
      },
    ];
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
                    children: List.generate(namePostMapList.length, (index) {
                      String nicknameKey =
                          namePostMapList[index].keys.elementAt(0);
                      List<String> postIdList =
                          namePostMapList[index][nicknameKey]!;
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
                                children: List.generate(3, (index) {
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
