import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
      builder: (controller) => Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconSize: 32.0,
          selectedIconTheme: const IconThemeData(color: salmon500),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.navigatorIndex,
          onTap: (index) {
            controller.changeCurrentScreen(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.compassOutline),
                label: 'feed',
                activeIcon: Container(
                  width: 54,
                  height: 40,
                  decoration: BoxDecoration(
                      color: salmon100,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(
                    EvaIcons.compassOutline,
                    color: salmon500,
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.gridOutline),
                label: 'album',
                activeIcon: Center(
                  child: Container(
                    width: 54,
                    height: 40,
                    decoration: BoxDecoration(
                        color: salmon100,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Icon(
                      EvaIcons.gridOutline,
                      color: salmon500,
                    ),
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(EvaIcons.settingsOutline),
                label: 'settings',
                activeIcon: Center(
                  child: Container(
                    width: 54,
                    height: 40,
                    decoration: BoxDecoration(
                        color: salmon100,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Icon(
                      EvaIcons.settingsOutline,
                      color: salmon500,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
