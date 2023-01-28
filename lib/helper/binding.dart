import 'package:get/get.dart';
import 'package:netgalpi/core/viewmodel/auth_viewmodel.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';

import '../core/viewmodel/album_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlbumViewModel());
    Get.put(() => AuthViewModel());
    Get.lazyPut(() => PostListViewModel());
  }
}
