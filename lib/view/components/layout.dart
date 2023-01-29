import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/view/upload_view.dart';

import '../alarm_view.dart';

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({required this.body, this.floatingActionBtn});
  final body;
  final floatingActionBtn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.498),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: gray600),
        leading: Text(
          '  Netgalfi',
          style: GoogleFonts.dawningOfANewDay(
            textStyle: TextStyle(
              fontSize: 30,
              letterSpacing: 0.1,
              color: gray700,
            ),
          ),
          //TextStyle(fontSize: 28, letterSpacing: 0.1, color: gray700),
        ),
        leadingWidth: 110,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => UploadView());
            },
            icon: Icon(
              EvaIcons.plusSquareOutline,
              size: 30.0,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          IconButton(
            onPressed: () {
              Get.to(() => AlarmView());
            },
            icon: Icon(
              EvaIcons.bellOutline,
              size: 30.0,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        ],
      ),
      body: body,
      floatingActionButton: floatingActionBtn,
    );
  }
}
