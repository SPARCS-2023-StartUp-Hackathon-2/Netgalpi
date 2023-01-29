import 'dart:io';
import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netgalpi/view/add_content_page.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/view/components/photo_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netgalpi/view/content_upload_page.dart';

import '../helper/datetime_parsor.dart';

class PostView extends StatefulWidget {
  const PostView(
      {super.key,
      required this.postId,
      required this.url,
      required this.date,
      required this.title,
      required this.mention,
      required this.contentIdList});
  final String postId;
  final String url;
  final String date;
  final String title;
  final List<dynamic> mention;
  final List<dynamic> contentIdList;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final picker = ImagePicker();
  File? _image;

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource, String pid) async {
    final image = await picker.pickImage(source: imageSource);
    if (image != null) {
      _image = File(image!.path);
      Get.to(() => ContentUploadPage(_image, pid));
    } else {
      Get.snackbar('이미지 미선택', '추억에 보관할 이미지를 선택해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AppBar(
              elevation: 0,
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              leadingWidth: 110,
              actions: <Widget>[
                IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(EvaIcons.collapse, size: 32, color: gray500),
                  onPressed: () => Navigator.of(context).pop(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                IconButton(
                  icon: const Icon(EvaIcons.editOutline,
                      size: 32, color: gray500),
                  onPressed: () => {
                    //getImage(ImageSource.gallery, widget.postId)
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 12,
                )
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  datetimeParsor(DateTime.parse(widget.date)),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 90, 90, 90),
                    fontSize: 18,
                    letterSpacing: -0.4,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    height: 1.1,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 138, 138, 138),
                          fontSize: 16,
                          height: 1,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                        children: [
                      ...widget.mention.map((e) => TextSpan(children: [
                            const TextSpan(text: '@'),
                            TextSpan(text: e),
                            const TextSpan(text: ' '),
                          ]))
                    ])),
                ...widget.contentIdList.map((e) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: PhotoCard(
                        contentId: e,
                      ));
                }),
              ],
            )),
      ),
    );
  }
}
