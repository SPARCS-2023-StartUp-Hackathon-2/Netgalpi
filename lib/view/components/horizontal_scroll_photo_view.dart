import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netgalpi/view/components/default_photo_card.dart';

class HorizontalScrollPhoto extends StatefulWidget {
  const HorizontalScrollPhoto(
      {super.key, this.index = 0, required this.imageList});
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
    _controller =
        PageController(viewportFraction: 0.86, initialPage: widget.index);
    _currentPage = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    imageProviderList =
        widget.imageList.map((e) => CachedNetworkImageProvider(e));
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3 / 0.86,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if ((_currentPage - _controller.page!).abs() > 0.8) {
            _currentPage = _controller.page!.round();
          }
          return true;
        },
        child: PageView(controller: _controller, children: [
          ...imageProviderList.map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: DefaultPhotoCard(
                imgProvider: e,
              )))
        ]),
      ),
    );
  }
}
