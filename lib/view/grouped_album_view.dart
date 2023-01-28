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
    const nicknameList = ['동우', '세진', '동원', '재모'];
    return Center(
      child: GetBuilder<PostListViewModel>(
          init: PostListViewModel(),
          builder: (controller) {
            return Stack(
              children: <Widget>[
                // User Nickname - post image perview box
                // Column(
                //   children: List.generate(nicknameList.length, (index) => {
                //     return
                //   }),
                // ),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/bookmark.svg',
                  ),
                  onTap: () {
                    Get.off(() => const AlbumView());
                  },
                ),
              ],
            );
          }),
    );
  }
}
