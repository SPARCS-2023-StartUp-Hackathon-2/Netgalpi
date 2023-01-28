import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:netgalpi/view/post_view.dart';

import '../../helper/datetime_parsor.dart';

class DetailedCard extends StatefulWidget {
  const DetailedCard(
      {super.key,
      required this.date,
      required this.title,
      required this.mention,
      required this.url,
      required this.contentIdList});
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
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return PostView(
          url: widget.url,
          date: widget.date,
          title: widget.title,
          mention: widget.mention,
          contentIdList: widget.contentIdList,
        );
      },
      closedBuilder: (BuildContext _, VoidCallback __) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            // boxShadow: [
            //   BoxShadow(blurRadius: 4.0, color: Colors.black26),
            // ],
          ),
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
                      ]))
                ],
              )),
        );
      },
    );
  }
}
