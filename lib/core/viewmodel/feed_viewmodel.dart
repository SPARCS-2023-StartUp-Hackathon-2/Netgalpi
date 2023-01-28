import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_apis.dart';
import 'package:netgalpi/model/post_model.dart';

class FeedViewModel extends GetxController {
  List<PostModel> feedList = [];
  List<String> feedIdList = [];
  Map<String, CachedNetworkImageProvider> feedImgMap = {};

  @override
  void onInit() {
    super.onInit();
    getFeed();
  }

  getFeed() async {
    feedList = await FirestoreApis().getFeedList();

    for (var element in feedList) {
      feedImgMap[element.postId] = CachedNetworkImageProvider(element.imageUrl);
      feedIdList.add(element.postId);
    }
    update();
  }
}
