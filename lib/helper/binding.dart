import 'package:get/get.dart';

import '../core/viewmodel/album_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlbumViewModel());
  }
}
