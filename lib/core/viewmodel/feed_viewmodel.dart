import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_apis.dart';
import 'package:netgalpi/model/post_model.dart';

import '../../model/user_model.dart';
import '../service/local_storage_user.dart';

class FeedViewModel extends GetxController {
  List<PostModel> feedList = [];
  List<String> feedIdList = [];
  Map<String, CachedNetworkImageProvider> feedImgMap = {};

  String? selectedNickName;

  // ====== Get user data ======
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _loading = false;
  bool get loading => _loading;

  @override
  void onInit() {
    _loading = true;
    _loading = true;
    super.onInit();
    getCurrentUser().whenComplete(() {
      getFeed();
      for (var element in feedList) {
        feedImgMap[element.postId] =
            CachedNetworkImageProvider(element.imageUrl);
        feedIdList.add(element.postId);
      }
      update();
    });
    _loading = false;
  }

  @override
  void onReady() async {
    update();
  }

  getCurrentUser() async {
    _loading = true;
    _currentUser = await LocalStorageUser.getUserData();
    _loading = false;
  }

  getFeed() async {
    feedList = await FirestoreApis().getFeedList();
  }

  // =================================
}
