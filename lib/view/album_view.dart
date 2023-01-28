import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';
import 'package:netgalpi/view/grouped_album_view.dart';

import 'components/virtical_scroll_photo_view.dart';

class AlbumView extends StatelessWidget {
  const AlbumView({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize postList, show main album
    return GetBuilder<PostListViewModel>(
        init: PostListViewModel(),
        builder: (controller) {
          return Stack(
            children: <Widget>[
              VirticalScrollPhotoView(
                gridx: 2,
                postIdList: controller.currentPostIdList,
              ),
              Positioned(
                top: 60,
                right: -160,
                child: GestureDetector(
                  child: SvgPicture.asset(
                    'assets/bookmark.svg',
                  ),
                  onTap: () {
                    // set current
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const GroupedAlbumView()));
                    // Get.to(() => const GroupedAlbumView());
                  },
                ),
              ),
            ],
          );
        });
  }
}
