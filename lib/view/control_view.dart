import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/control_viewmodel.dart';
import 'package:netgalpi/view/album_view.dart';
import 'package:netgalpi/view/feed_view.dart';
import 'package:netgalpi/view/settings_view.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
        init: ControlViewModel(),
        builder: (controller) => Scaffold(
              body: IndexedStack(
                index: controller.navigatorIndex,
                children: [FeedView(), AlbumView(), SettingsView()],
              ),
              bottomNavigationBar: const CustomBottomNavigationBar(),
            ));
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      builder: (controller) => BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconSize: 32.0,
        selectedIconTheme: const IconThemeData(color: salmon500, size: 36.0),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.navigatorIndex,
        onTap: (index) {
          controller.changeCurrentScreen(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'feed'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'album'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'settings')
        ],
      ),
    );
  }
}
