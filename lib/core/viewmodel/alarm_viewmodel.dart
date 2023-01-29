import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_post.dart';
import 'package:netgalpi/core/service/firestore_user.dart';
import 'package:netgalpi/model/post_model.dart';
import 'package:netgalpi/model/user_model.dart';

import '../service/local_storage_user.dart';

class AlarmViewModel extends GetxController {
  List<PostModel> alarmList = [];

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _loading = false;
  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser().whenComplete(() => getPendingPosts());
  }

  getCurrentUser() async {
    _loading = true;
    UserModel? user = await LocalStorageUser.getUserData();
    _currentUser = await FirestoreUser().getUserFromFirestore(user!.userId);
    _loading = false;
  }

  getPendingPosts() async {
    print(_currentUser!.toJson());
    for (String pId in _currentUser!.pendingPostIdList) {
      var pendingPost = await FirestorePost().getPostFromFirestore(pId);
      alarmList.add(pendingPost);
    }

    update();
  }

  Future<bool> deletePending(String pid, bool isAccepted) async {
    try {
      _currentUser!.pendingPostIdList.removeWhere((item) => item == pid);
      alarmList.removeWhere((item) => item.postId == pid);

      if (isAccepted) {
        _currentUser!.postIdList.add(pid);
      }

      await FirestoreUser().updateUserToFireStore(_currentUser!);

      update();
      return true;
    } catch (e) {
      print("error $e");

      return false;
    }
  }
}
