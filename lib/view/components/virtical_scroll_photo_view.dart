import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';
import 'package:netgalpi/view/detailed_view.dart';

import 'default_photo_card.dart';

class VirticalScrollPhotoView extends StatelessWidget {
  const VirticalScrollPhotoView({
    super.key,
    this.viewOnly = false,
    required this.gridx,
    required this.postIdList,
  });
  final int gridx;
  final List<String> postIdList;
  final bool viewOnly;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth * 3 / 2;

    return Center(
      child: GridView.count(
        crossAxisCount: gridx,
        controller: ScrollController(keepScrollOffset: true),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(postIdList.length, (index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                if (!viewOnly) {
                  Get.to(() => const DetailedView()); //postIdx: index));
                }
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: DefaultPhotoCard(
                    imgProvider: Get.find<PostListViewModel>()
                        .postImgMap[postIdList[index]]!,
                  )),
            ),
          );
        }),
      ),
    );
  }
}
