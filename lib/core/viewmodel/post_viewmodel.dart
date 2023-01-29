import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_apis.dart';
import 'package:netgalpi/core/service/firestore_content.dart';

import '../../model/user_model.dart';
import '../../model/post_model.dart';
import '../../model/content_model.dart';
import '../service/firestore_post.dart';
import '../service/local_storage_user.dart';

class PostListViewModel extends GetxController {
  String? imageUrl, mp4Url, title;
  bool? check;
  List<String> mentionList = [];
  List<PostModel> postList = [];
  Map<String, CachedNetworkImageProvider> postImgMap = {};
  List<String> currentPostIdList = [];
  Map<String, List<String>> groupedPostIdListMap = {};

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
      getPost();
      setGroupedPostIdListMap();
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

  getPost() async {
    postList = await FirestoreApis().getPostList(_currentUser!.username);
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

  void setGroupedPostIdListMap() async {
    // _currentUser!.userId
    groupedPostIdListMap = await FirestoreApis().groupPostByUser('test');
    update();
  }

  Future<bool> contentFinal(
      String pid, String contentImgUrl, String contentText, String uid) async {
    try {
      ContentModel cm = ContentModel(
          contentId: "",
          contentPostId: pid,
          contentImgUrl: contentImgUrl,
          contentText: contentText,
          uploadedAt: DateTime.now().toIso8601String(),
          writerId: uid);
      String cid = await FirestoreContent().addContentToFirestore(cm);
      FirestoreApis().updateContentList(cid);

      return true;
    } catch (e) {
      print("Error: $e");

      return false;
    }
  }

  Future<String> finalPost(String imageUrl, String mp4Url, String title,
      bool isOpened, List<String> mentionIdList) async {
    try {
      String? uid = _currentUser!.userId;
      PostModel pm = PostModel(
          postId: '',
          imageUrl: imageUrl,
          mp4Url: mp4Url,
          title: title,
          isOpened: isOpened,
          writerId: uid!,
          uploadedAt: DateTime.now().toIso8601String(),
          mentionIdList: mentionIdList,
          likerIdList: [],
          contentIdList: []);
      String pid = await FirestorePost().addPostToFirestore(pm);
      FirestoreApis().updatePostIdList(pid, uid!);
      FirestoreApis().updatePendingList(pid);

      return pid;
    } catch (e) {
      print("error: $e");

      return "";
    }
  }
}
