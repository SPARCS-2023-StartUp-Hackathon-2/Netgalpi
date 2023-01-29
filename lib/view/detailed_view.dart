import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/post_viewmodel.dart';
import 'package:netgalpi/view/album_view.dart';
import 'package:netgalpi/view/components/detailed_card.dart';
import 'package:netgalpi/view/components/photo_view.dart';

class DetailedView extends StatefulWidget {
  const DetailedView({super.key, required this.index, this.close = false});
  final int index;
  final bool close;

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  late PageController controller;
  Iterable<CachedNetworkImageProvider> imageProviderList = [];
  int _currentPage = 0;
  var postController = Get.find<PostListViewModel>();

  @override
  void initState() {
    super.initState();
    controller =
        PageController(viewportFraction: 0.86, initialPage: widget.index);
    _currentPage = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var tempList = [];
    for (var element in postController.currentPostIdList) {
      tempList.add(postController.postImgMap[element]);
    }
    imageProviderList = tempList.map((e) => e);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => {
            if (!widget.close)
              Navigator.of(context).pop()
            else
              Get.to(() => AlbumView())
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: PageView(controller: controller, children: [
          ...postController.currentPostIdList.map((e) {
            var post = postController.postList
                .firstWhere((element) => element.postId == e);
            var imgProvider = postController.postImgMap[e];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: PhotoView(
                      imageProvider: imgProvider!,
                    ),
                  ),
                ),
                Expanded(
                  child: Transform.translate(
                      offset: Offset(0, 0),
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: DetailedCard(
                              postId: post.postId,
                              url: post.imageUrl,
                              date: post.uploadedAt,
                              title: post.title,
                              mention: post.mentionIdList,
                              contentIdList: post.contentIdList,
                            )),
                      )),
                ),
              ],
            );
          })
        ]),
      ),
    );
  }
}
