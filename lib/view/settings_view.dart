import 'package:flutter/material.dart';
import 'package:netgalpi/view/components/layout.dart';
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
              return LayoutWidget(
                body: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: gray10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '내 정보',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: gray700),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    ' 내 이름',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: gray700,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    user!.nickname,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: gray700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    ' 아이디',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: gray700,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    user!.username,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: gray700,
                                    ),
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
