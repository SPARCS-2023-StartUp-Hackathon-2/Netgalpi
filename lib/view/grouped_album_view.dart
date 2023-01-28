import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';
import 'package:netgalpi/view/components/square_photo_card.dart';

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
    ];
    return GetBuilder<PostListViewModel>(
      builder: (controller) {
        return Stack(
          children: <Widget>[
            Column(
              children: List.generate(namePostMapList.length, (index) {
                String nicknameKey = namePostMapList[index].keys.elementAt(0);
                List<String> postIdList = namePostMapList[index][nicknameKey]!;
                return Column(children: <Widget>[
                  Text(
                    nicknameKey,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                  // Row(
                  //   children: List.generate(3, (index) {
                  //     if (controller.postImgMap[postIdList[index]] != null) {
                  //       return SquarePhotoCard(
                  //           imgProvider:
                  //               controller.postImgMap[postIdList[index]]!);
                  //     }
                  //     return const Text('아직 찍은 사진이 없어요!');
                  //   }),
                  // )
                ]);
              }),
            ),
            Positioned(
              top: 60,
              right: -60,
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/bookmark.svg',
                ),
                onTap: () {
                  // Get.off(() => AlbumView());
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
