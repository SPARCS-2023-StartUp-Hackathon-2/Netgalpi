import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_post.dart';
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
    getCurrentUser().whenComplete(() async {
      for (String pId in _currentUser!.pendingPostIdList) {
        var pendingPost = await FirestorePost().getPostModelFromFirestore(pId);
      }
    });
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
}
