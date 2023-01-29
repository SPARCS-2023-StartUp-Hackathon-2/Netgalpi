import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../core/viewmodel/auth_viewmodel.dart';
import '../components/custom_textformfield.dart';
import 'login_view.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  final AuthViewModel _auth = AuthViewModel();
  final _formKey = GlobalKey<FormState>();

  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      builder: ((controller) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Netgalfi',
                    style: GoogleFonts.dawningOfANewDay(
                      textStyle: TextStyle(
                        fontSize: 54,
                        letterSpacing: 0.1,
                        color: gray700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70.0, vertical: 30.0),
                        child: Column(children: [
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextFormField(
                                  title: '아이디',
                                  hintText: '',
                                  validatorFn: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      controller.validatorTitle = '회원가입 실패';
                                      controller.validatorMessage =
                                          '아이디를 6자 이상으로 적어주세요';
                                    }
                                  },
                                  onSavedFn: (value) {
                                    controller.username = value;
                                  },
                                ),
                              ),
                              Container(
                                width: 58,
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 25.0, 0.0, 0.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: ElevatedButton(
                                  child: Text(
                                    '중복확인',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: salmon500),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: salmon50,
                                    padding: EdgeInsets.all(0.0),
                                  ),
                                  onPressed: () async {
                                    _formKey.currentState!.save();
                                    controller.validatorTitle = '중복 없음';
                                    controller.validatorMessage =
                                        '사용 가능한 아이디입니다.';
                                    _formKey.currentState!.save();
                                    if (controller.username!.isEmpty ||
                                        controller.username!.length < 6) {
                                      controller.validatorTitle = '회원가입 실패';
                                      controller.validatorMessage =
                                          '아이디를 6자 이상으로 적어주세요';
                                    }
                                    bool isOkay =
                                        await controller.loginDistinctValidator(
                                            controller.username!);
                                    if (isOkay) {
                                      Get.snackbar(controller.validatorTitle,
                                          controller.validatorMessage);
                                    } else {
                                      controller.validatorTitle = '존재하는 아이디';
                                      controller.validatorMessage =
                                          '이미 존재하는 아이디입니다.';
                                      Get.snackbar(controller.validatorTitle,
                                          controller.validatorMessage);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            obscureText: true,
                            title: '비밀번호',
                            hintText: '',
                            validatorFn: (value) {
                              if (value!.isEmpty || value.length < 8) {
                                controller.validatorTitle = '회원가입 실패';
                                controller.validatorMessage =
                                    '비밀번호를 8자 이상으로 적어주세요';
                              }
                            },
                            onSavedFn: (value) {
                              controller.password = value;
                            },
                            helpinfo: '8자 이상의 영/특수문자 조합',
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            title: '이름',
                            hintText: '',
                            validatorFn: (value) {
                              if (value!.isEmpty || value.length < 2) {
                                controller.validatorTitle = '회원가입 실패';
                                controller.validatorMessage =
                                    '이름을 두 자 이상으로 적어주세요';
                              }
                            },
                            onSavedFn: (value) {
                              controller.nickname = value;
                            },
                            helpinfo: '친구들의 책갈피에 이름으로 표시돼요!',
                          ),
                          SizedBox(height: 20),
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
                                child: const Text(
                                  '회원가입',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    controller
                                        .registerWithUsernameAndPassword();
                                  }
                                },
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all(salmon50),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Text(
                                '이미 아이디가 있으신가요?',
                                style: TextStyle(
                                  color: gray400,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(height: 0),
                              ),
                              TextButton(
                                child: Text(
                                  '로그인하기',
                                  style: TextStyle(
                                      color: salmon500,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Get.to(() => LoginView());
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 100.0)
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
