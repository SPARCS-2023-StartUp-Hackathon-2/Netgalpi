import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netgalpi/helper/image_pixels.dart';

class HorizontalScrollPhoto extends StatefulWidget {
  const HorizontalScrollPhoto({super.key, this.index = 0, required this.imageList});
  final int index;
  final List<String> imageList;
  
  @override
  State<HorizontalScrollPhoto> createState() => _HorizontalScrollPhotoState();
}

class _HorizontalScrollPhotoState extends State<HorizontalScrollPhoto> {
  late PageController _controller;
  Iterable<CachedNetworkImageProvider> imageProviderList = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.86, initialPage: widget.index);
    _currentPage = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    imageProviderList = widget.imageList.map((e) => CachedNetworkImageProvider(e));
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2/3 /0.86,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if((_currentPage - _controller.page!).abs() > 0.8) {
            _currentPage = _controller.page!.round();
          }
          return true;
        },
        child: PageView(
          controller: _controller, 
          children: [
            ...imageProviderList.map((e) => 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                                  imageProvider: e,
                                  colorAlignment: Alignment.topLeft,
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 4/3,
                                child: ImagePixels.container(
                                  imageProvider: e,
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
                      child: Image(image: e)
                    ),
                  ]
                ),
              )
            )
          ]
        ),
      ),
    );
  }
}