import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_apis.dart';

import '../../model/user_model.dart';
import '../../model/post_model.dart';
import '../service/local_storage_user.dart';

class PostListViewModel extends GetxController {
  List<PostModel> postList = [];
  Map<String, CachedNetworkImageProvider> postImgMap = {};
  List<String> currentPostIdList = [];
  Map<String, List<String>> friendsPostIdList = {};

  String? selectedNickName;

  // ====== Get user data ======
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _loading = false;
  bool get loading => _loading;

  @override
  void onInit() {
    _loading = true;
    super.onInit();
    getCurrentUser().whenComplete(() {
      getPost();
      setGroupedPostIdMap();
    });
    _loading = false;
  }

  @override
  void onReady() async {
    update();
  }

  getCurrentUser() async {
    _currentUser = await LocalStorageUser.getUserData();
  }

  getPost() async {
    // TODO: Use Real user name instead of test _currentUser!.username
    postList = await FirestoreApis().getPostList('test');
    // set postImage map
    for (var element in postList) {
      postImgMap[element.postId] = CachedNetworkImageProvider(element.imageUrl);
      currentPostIdList.add(element.postId);
    }
    update();
  }
  // =================================

  void setCurrentPostIdList(List<String> postIdList) {
    currentPostIdList = [...postIdList];
    update();
  }

  void addNewPost(PostModel newPost) {
    postList.add(newPost);
    postImgMap[newPost.postId] = CachedNetworkImageProvider(newPost.imageUrl);
    update();
  }

  void setSelectedNickName(String? nickname) {
    selectedNickName = nickname;
    update();
  }

  void setGroupedPostIdMap() async {
    friendsPostIdList =
        await FirestoreApis().groupPostByUser(_currentUser!.userId);
    update();
  }
}
