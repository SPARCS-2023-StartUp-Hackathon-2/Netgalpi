import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/view/alarm_view.dart';
import 'package:netgalpi/view/components/custom_appbar.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.5),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: gray500),
        leading: Text(
          ' Netgalfi',
          style: GoogleFonts.dawningOfANewDay(
            textStyle: TextStyle(
              fontSize: 28,
              letterSpacing: 0.1,
              color: gray700,
            ),
          ),
        ),
        leadingWidth: 110,
        actions: [
          IconButton(
            onPressed: () {},
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
      ), //CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            height: 30,
          ),
          Text(
            'This is SettingsView',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
