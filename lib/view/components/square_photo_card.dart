import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netgalpi/helper/image_pixels.dart';

class SquarePhotoCard extends StatelessWidget {
  const SquarePhotoCard({
    super.key,
    required this.imgProvider,
  });
  final CachedNetworkImageProvider imgProvider;

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                  width: 1,
                  height: 1,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: ImagePixels.container(
                          imageProvider: imgProvider,
                          colorAlignment: Alignment.topLeft,
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: ImagePixels.container(
                          imageProvider: imgProvider,
                          colorAlignment: Alignment.bottomRight,
                        ),
                      )
                    ],
                  )),
            ),
          ),
          FittedBox(
              clipBehavior: Clip.antiAlias,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
              child: Image(image: imgProvider)),
        ]);
  }
}
