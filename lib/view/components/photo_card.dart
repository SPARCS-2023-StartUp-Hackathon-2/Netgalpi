import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netgalpi/helper/image_pixels.dart';

class PhotoCard extends StatefulWidget {
  const PhotoCard({super.key, required this.imageUrl, this.description,required this.author}) 
    : assert(imageUrl != null || description != null);
  final String imageUrl;
  final String? description;
  final String author;

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
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
                      "너무너무 수고하셨어요~! 나중에 또 좋은 작품으로 만나요 대박나길!!",
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
}