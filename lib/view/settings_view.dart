import 'package:flutter/material.dart';
import 'package:netgalpi/view/components/layout.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
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
