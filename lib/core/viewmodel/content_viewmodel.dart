import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_content.dart';
import 'package:netgalpi/core/service/local_storage_user.dart';
import 'package:netgalpi/model/content_model.dart';
import 'package:netgalpi/model/user_model.dart';

class ContentViewModel extends GetxController {
  String? contentImgUrl, contentText, writerId, contentPostId;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _loading = false;
  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  getCurrentUser() async {
    _loading = true;
    _currentUser = await LocalStorageUser.getUserData();
    _loading = false;
  }

  void addContent() {
    ContentModel cm = new ContentModel(
        contentId: '',
        contentPostId: contentPostId!,
        contentImgUrl: contentImgUrl!,
        contentText: contentText!,
        uploadedAt: DateTime.now().toIso8601String(),
        writerId: _currentUser!.userId);

    FirestoreContent().addContentToFirestore(cm);
  }
}
