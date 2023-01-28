import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netgalpi/helper/image_bg.dart';
import 'package:netgalpi/helper/image_pixels.dart';
import 'package:netgalpi/view/components/horizontal_scroll_photo_view.dart';
import 'package:netgalpi/view/components/photo_detail.dart';

class DetailedView extends StatefulWidget {
  const DetailedView({super.key});

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          HorizontalScrollPhoto(
            imageList: [
              'https://cdn.discordapp.com/attachments/797738827740479513/1068735195978666055/xZxIbAnBdrfM.jpg',
              'https://img.theqoo.net/img/pXDIo.png',
              'https://img.theqoo.net/img/YXbdu.png',
              'https://img.theqoo.net/img/VVDEV.png',
              'https://img.theqoo.net/img/Ptrjy.jpg',
              'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202208/28/e9fb2660-b8b9-403e-9c6b-6a73b781b749.jpg',
              'https://cdn.discordapp.com/attachments/951599755488792618/999666754768867338/frame.png',
              'https://media.istockphoto.com/id/517188688/ko/사진/산-풍경.jpg?s=1024x1024&w=is&k=20&c=6xjEh-IzcicEL9FQAqvNHHszVS6fzvyF3ptQ4kM-DBU=',
            ]
          ),
          PhotoDetail(),
        ],
      ),
    );
  }
}