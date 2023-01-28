import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/view/detailed_view.dart';

class VirticalScrollPhotoView extends StatelessWidget {
  const VirticalScrollPhotoView({
    super.key,
    this.viewOnly = false,
    required this.gridx,
    required this.imageUrlList,
  });
  final int gridx;
  final List<String> imageUrlList;
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
        children: List.generate(imageUrlList.length, (index) {
          return GestureDetector(
            onTap: () {
              if (!viewOnly)
                Get.to(() => const DetailedView()); //postIdx: index));
            },
            child: Card(
              color: Colors.white,
              margin: const EdgeInsets.all(4.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(imageUrlList[index], fit: BoxFit.cover)),
            ),
          );
        }),
      ),
    );
  }
}
