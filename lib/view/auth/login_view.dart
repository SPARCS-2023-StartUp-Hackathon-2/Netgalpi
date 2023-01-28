import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netgalpi/view/auth/register_view.dart';
import 'package:netgalpi/view/components/c_text_input.dart';

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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Container(
                    width: 200,
                    height: 100,
                    color: gray100,
                    child: Text('로고자리'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(70.0),
                        child: Column(children: [
                          CustomTextFormField(
                            title: '아이디',
                            hintText: '아이디',
                            validatorFn: (value) {
                              if (value!.isEmpty)
                                return '이메일 또는 아이디는 필수 항목입니다.';
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
                              if (value!.isEmpty) return '비밀번호는 필수 항목입니다.';
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
                                    fontSize: 14,
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
                                    fontSize: 11,
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
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Get.to(() => RegisterView());
                                  },
                                )
                              ],
                            ),
                          )
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
