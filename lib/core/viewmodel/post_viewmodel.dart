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

  String? selectedNickName;

  // ====== Get user data ======
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _loading = false;
  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser().whenComplete(() => getPost());
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
}
