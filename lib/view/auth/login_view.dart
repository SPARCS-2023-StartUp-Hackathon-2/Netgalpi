import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netgalpi/view/auth/register_view.dart';

import '../../constants.dart';
import '../../core/viewmodel/auth_viewmodel.dart';
import '../components/custom_textformfield.dart';

class LoginView extends GetWidget<AuthViewModel> {
  final AuthViewModel _auth = AuthViewModel();
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

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
                          CustomTextFormField(
                            title: '아이디',
                            hintText: '아이디',
                            validatorFn: (value) {
                              if (value!.isEmpty) {
                                controller.validatorTitle = '로그인 실패';
                                controller.validatorMessage = '이름은 필수 항목입니다.';
                              }
                            },
                            onSavedFn: (value) {
                              controller.username = value;
                            },
                            showLabel: false,
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            obscureText: true,
                            title: '비밀번호',
                            hintText: '비밀번호',
                            validatorFn: (value) {
                              if (value!.isEmpty) {
                                controller.validatorTitle = '로그인 실패';
                                controller.validatorMessage = '비밀번호는 필수 항목입니다.';
                              }
                            },
                            onSavedFn: (value) {
                              controller.password = value;
                            },
                            showLabel: false,
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
                                  '로그인하기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    controller.loginWithUsernameAndPassword();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  '처음이신가요?',
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
                                    '회원가입하기',
                                    style: TextStyle(
                                        color: salmon500,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Get.to(() => RegisterView());
                                  },
                                ),
                              ],
                            ),
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
