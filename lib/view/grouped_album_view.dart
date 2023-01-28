import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';

import 'components/virtical_scroll_photo_view.dart';

class AlbumView extends StatelessWidget {
  const AlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize postList, show main album
    return Center(
      child: GetBuilder<PostListViewModel>(
          init: PostListViewModel(),
          builder: (controller) {
            return Stack(
              children: <Widget>[
                VirticalScrollPhotoView(
                  gridx: 2,
                  postIdList: controller.currentPostIdList,
                ),
                GestureDetector(
                  child: Positioned(
                    right: 0,
                    top: 100,
                    child: SvgPicture.asset(
                      'assets/bookmark.svg',
                    ),
                  ),
                  onTap: () {
                    // Get.to(() => group_album_view.);
                  },
                ),
              ],
            );
          }),
    );
  }
}
