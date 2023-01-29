import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:netgalpi/helper/image_pixels.dart';
import 'package:netgalpi/view/full_image_view.dart';
import 'package:netgalpi/core/service/firestore_content.dart';
import 'package:netgalpi/model/content_model.dart';

class PhotoCard extends StatefulWidget {
  const PhotoCard({super.key, required this.contentId});
  final String contentId;

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  late ContentModel? content;
  @override
  void initState() {
    super.initState();
  }

  getContents() async {
    return await FirestoreContent().getContentFromFirestore(widget.contentId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getContents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data.contentImgUrl,
                      fadeInDuration: const Duration(microseconds: 0),
                      fadeOutDuration: const Duration(microseconds: 0),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 80),
                      color: Color.fromARGB(222, 255, 255, 255),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              snapshot.data.contentText,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }
}
