import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netgalpi/view/components/photo_card.dart';

import '../helper/datetime_parsor.dart';

class PostView extends StatefulWidget {
  const PostView(
      {super.key,
      required this.url,
      required this.date,
      required this.title,
      required this.mention,
      required this.contentIdList});
  final String url;
  final String date;
  final String title;
  final List<dynamic> mention;
  final List<dynamic> contentIdList;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
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
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close, size: 32, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
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
