import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:netgalpi/view/post_view.dart';

import '../../constants.dart';
import '../../helper/datetime_parsor.dart';

class DetailedCard extends StatefulWidget {
  const DetailedCard(
      {super.key,
      required this.postId,
      required this.date,
      required this.title,
      required this.mention,
      required this.url,
      required this.contentIdList});
  final String postId;
  final String date;
  final String title;
  final List<dynamic> mention;
  final String url;
  final List<dynamic> contentIdList;

  @override
  State<DetailedCard> createState() => _DetailedCardState();
}

class _DetailedCardState extends State<DetailedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
        child: OpenContainer(
          transitionType: ContainerTransitionType.fade,
          openBuilder: (BuildContext context, VoidCallback _) {
            return PostView(
              postId: widget.postId,
              url: widget.url,
              date: widget.date,
              title: widget.title,
              mention: widget.mention,
              contentIdList: widget.contentIdList,
            );
          },
          closedBuilder: (BuildContext _, VoidCallback __) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 0),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                      SizedBox(
                        height: 56,
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            height: 1,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: RichText(
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
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}
