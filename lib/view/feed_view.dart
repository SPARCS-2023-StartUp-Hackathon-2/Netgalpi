import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../core/viewmodel/post_viewmodel.dart';
import 'components/virtical_scroll_photo_view.dart';

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<PostListViewModel>(
        builder: (controller) {
          return VirticalScrollPhotoView(
            gridx: 1,
            postIdList: controller.currentPostIdList,
          );
        },
      ),
    );
  }
}
