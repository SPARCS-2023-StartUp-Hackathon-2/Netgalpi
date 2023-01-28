import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:netgalpi/core/viewmodel/feed_viewmodel.dart';

import 'components/virtical_scroll_photo_view.dart';

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: GetBuilder<FeedViewModel>(
            init: FeedViewModel(),
            builder: (controller) {
              return VirticalScrollPhotoView(
                gridx: 1,
                postIdList: controller.feedIdList,
              );
            },
          ),
        ),
      ),
    );
  }
}
