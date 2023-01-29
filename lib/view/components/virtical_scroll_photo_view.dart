import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/view/components/photo_view.dart';
import 'package:netgalpi/view/detailed_view.dart';

class VirticalScrollPhotoView extends StatelessWidget {
  const VirticalScrollPhotoView({
    super.key,
    this.viewOnly = false,
    required this.gridx,
    required this.imgList,
  });
  final int gridx;
  final List<CachedNetworkImageProvider> imgList;
  final bool viewOnly;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth * 3 / 2;

    return Center(
      child: GridView.count(
        crossAxisCount: gridx,
        controller: ScrollController(keepScrollOffset: true),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(imgList.length, (idx) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                if (!viewOnly) {
                  Get.to(() => DetailedView(
                        index: idx,
                      ));
                }
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: PhotoView(
                    imageProvider: imgList[idx],
                  )),
            ),
          );
        }),
      ),
    );
  }
}
