import 'package:get/get.dart';
import 'package:netgalpi/core/viewmodel/alarm_viewmodel.dart';
import 'package:netgalpi/core/viewmodel/auth_viewmodel.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';

import '../core/viewmodel/album_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => AuthViewModel());
    Get.lazyPut(() => AlbumViewModel());
    Get.lazyPut(() => AlarmViewModel());
    Get.lazyPut(() => PostListViewModel());
  }
}
