import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';
import 'package:netgalpi/view/components/layout.dart';
import 'package:netgalpi/view/grouped_album_view.dart';

import '../constants.dart';
import 'components/virtical_scroll_photo_view.dart';

class AlbumView extends StatelessWidget {
  const AlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize postList, show main album
    return LayoutWidget(
      body: SingleChildScrollView(
        child: GetBuilder<PostListViewModel>(
            init: PostListViewModel(),
            builder: (controller) {
              List<CachedNetworkImageProvider> imgUrlList = [];
              for (var e in controller.currentPostIdList) {
                imgUrlList.add(controller.postImgMap[e]!);
              }
              return Column(children: <Widget>[
                if (controller.selectedNickName != null)
                  Text(
                    controller.selectedNickName ?? '',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: gray700,
                    ),
                  ),
                VirticalScrollPhotoView(
                  gridx: 2,
                  imgList: imgUrlList,
                ),
              ]);
            }),
      ),
      floatingActionBtn: GestureDetector(
        child: Container(
          alignment: const Alignment(2.9, -0.62),
          child: SvgPicture.asset(
            'assets/bookmark.svg',
          ),
        ),
        onTap: () {
          // set current
          Get.to(() => const GroupedAlbumView());
        },
      ),
    );
  }
}
