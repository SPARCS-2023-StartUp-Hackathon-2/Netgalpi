import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:netgalpi/view/components/detailed_card.dart';
import 'package:netgalpi/view/components/photo_view.dart';
import 'package:netgalpi/view/post_view.dart';

class DetailedView extends StatefulWidget {
  const DetailedView({super.key, this.index = 0, required this.imageList});
  final int index;
  final List<String> imageList;

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  late PageController controller;
  Iterable<CachedNetworkImageProvider> imageProviderList = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 0.86, initialPage: widget.index);
    _currentPage = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    imageProviderList = widget.imageList.map((e) => CachedNetworkImageProvider(e));
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
          onPressed: () => Navigator.of(context).pop(),
          splashColor: Colors.transparent,  
          highlightColor: Colors.transparent,
        ), 
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        // child: 
        //   NotificationListener<ScrollNotification>(
        //   onNotification: (notification) {
        //     print(controller.page);
        //     if((_currentPage - controller.page!).abs() > 0.8) {
        //       _currentPage = controller.page!.round();
        //     }
        //     return true;
        //   },
        child: PageView(
          controller: controller,
          children: [
            ...imageProviderList.map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 2/3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: PhotoView(imageProvider: e,),
                  ),
                ),
                Expanded(
                  child: Transform.translate(
                    offset: Offset(0, 0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        // horizontal: MediaQuery.of(context).size.width * 0.065,
                        vertical: 16,
                      ),
                      child: DetailedCard(
                        url: e.url,
                        date: "2023년 1월 28일",
                        title: "브로커 화이팅~! 가나다라가🌟나다라가나다라가나다라가나다라가나다라",
                        mention: ["star", "star", "star", "s"]
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ]
        ),
      ),
    );
  }
}