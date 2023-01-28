import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/viewmodel/control_viewmodel.dart';
import 'package:netgalpi/view/album_view.dart';
import 'package:netgalpi/view/feed_view.dart';
import 'package:netgalpi/view/settings_view.dart';

import '../core/service/local_storage_user.dart';
import '../model/user_model.dart';
import 'auth/login_view.dart';

class ControlView extends StatelessWidget {
  ControlView({super.key});

  late UserModel? user;

  getUser() async {
    user = await LocalStorageUser.getUserData();
    print('resultOfGetUser');
    print(user?.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              if (user == null) {
                print('opening loginview');
                FlutterNativeSplash.remove();
                return LoginView();
              } else {
                print('opening controlview');
                FlutterNativeSplash.remove();
                return GetBuilder<ControlViewModel>(
                  init: ControlViewModel(),
                  builder: (controller) => Scaffold(
                    body: IndexedStack(
                      index: controller.navigatorIndex,
                      children: [FeedView(), AlbumView(), SettingsView()],
                    ),
                    bottomNavigationBar: const CustomBottomNavigationBar(),
                  ),
                );
              }
            case ConnectionState.none:
              return const CircularProgressIndicator();
          }
        });
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
