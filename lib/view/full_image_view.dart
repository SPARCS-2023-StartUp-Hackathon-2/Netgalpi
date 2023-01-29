import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class FullImageView extends StatefulWidget {
  const FullImageView({super.key});

  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Draggable(
          feedback: Container(
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              child: CachedNetworkImage(
                imageUrl: Get.arguments['imageUrl'],
                fadeInDuration: const Duration(microseconds: 0),
                fadeOutDuration: const Duration(microseconds: 0),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          onDragEnd: (info) {
            Get.back();
          },
          childWhenDragging: SizedBox(),
          child: FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
            child: CachedNetworkImage(
              imageUrl: Get.arguments['imageUrl'],
              fadeInDuration: const Duration(microseconds: 0),
              fadeOutDuration: const Duration(microseconds: 0),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}