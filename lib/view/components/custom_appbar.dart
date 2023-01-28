import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netgalpi/constants.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.5),
      elevation: 0.0,
      iconTheme: const IconThemeData(color: gray600),
      leading: Text('Netgalfi',
          style: GoogleFonts.dawningOfANewDay(
            textStyle: TextStyle(
              fontSize: 28,
              letterSpacing: 0.1,
              color: gray700,
            ),
          )
          //TextStyle(fontSize: 28, letterSpacing: 0.1, color: gray700),
          ),
    );
  }
}
