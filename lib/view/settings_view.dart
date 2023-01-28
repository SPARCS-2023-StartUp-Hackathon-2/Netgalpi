import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netgalpi/constants.dart';
import 'package:netgalpi/core/service/local_storage_user.dart';
import 'package:netgalpi/view/alarm_view.dart';
import 'package:netgalpi/view/auth/login_view.dart';
import '../core/viewmodel/auth_viewmodel.dart';
import '../model/user_model.dart';

class SettingsView extends StatelessWidget {
  late UserModel? user;

  getUser() async {
    user = await LocalStorageUser.getUserData();
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
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 0.5),
                  elevation: 0.0,
                  iconTheme: const IconThemeData(color: gray500),
                  leading: Text(
                    ' Netgalfi',
                    style: GoogleFonts.dawningOfANewDay(
                      textStyle: TextStyle(
                        fontSize: 36,
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
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          color: gray50,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '내 이름',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    user!.nickname,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '아이디',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    user!.username,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox.shrink()),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                colors: [linearSalmonLight, linearSalmonDark],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: TextButton(
                              child: Text(
                                '로그아웃',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              onPressed: () {
                                Get.find<AuthViewModel>().signOut();
                                Get.snackbar('로그아웃 성공', '로그아웃에 성공하셨습니다.');
                              },
                              style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            case ConnectionState.none:
              return const CircularProgressIndicator();
          }
        });
  }
}
