import 'package:cached_network_image/src/image_provider/cached_network_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netgalpi/helper/image_pixels.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key, required this.imageProvider});
  final CachedNetworkImageProvider imageProvider;
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit:BoxFit.fitWidth,
              child: SizedBox(
                width: 2/3,
                height: 1,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 4/3,
                      child: ImagePixels.container(
                        imageProvider: widget.imageProvider,
                        colorAlignment: Alignment.topLeft,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 4/3,
                      child: ImagePixels.container(
                        imageProvider: widget.imageProvider,
                        colorAlignment: Alignment.bottomRight,
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
          FittedBox(
            clipBehavior: Clip.antiAlias,
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            child: Image(image: widget.imageProvider)
          ),
        ]
      ),
    );
  }
}