import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:netgalpi/core/service/firestore_user.dart';
import 'package:netgalpi/view/auth/login_view.dart';
import 'package:netgalpi/view/control_view.dart';

import '../../model/user_model.dart';
import '../service/local_storage_user.dart';

class AuthViewModel extends GetxController {
  String? username, password, nickname;
  String validatorTitle = '';
  String validatorMessage = '';

  Rxn<User>? _user = Rxn<User>();

  String? get user => _user?.value?.uid;

  final _auth = FirebaseAuth.instance;

  // firebase auth 에 user 생성
  void registerWithUsernameAndPassword() async {
    if (validatorTitle != '' || validatorMessage != '') {
      Get.snackbar(validatorTitle, validatorMessage);
      validatorTitle = '';
      validatorMessage = '';
    }
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: '${username!}@netgalpi.com', password: password!)
          .then((user) {
        saveUser(user, username!, nickname!);
      });
      Get.offAll(LoginView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar('Failed to register...', errorMessage);
    }
  }

  void loginWithUsernameAndPassword() async {
    if (validatorTitle != '' || validatorMessage != '') {
      Get.snackbar(validatorTitle, validatorMessage);
      validatorTitle = '';
      validatorMessage = '';
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: '${username!}@netgalpi.com', password: password!);
      UserModel userModel =
          await FirestoreUser().getUserFromFirestore(userCredential.user!.uid);
      saveUserLocal(userModel).then((data) => Get.offAll(ControlView()));
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar('Failed to login...', errorMessage);
    }
  }

  // user repo 에 user 생성
  void saveUser(
    UserCredential userCredential,
    String username,
    String nickname,
  ) async {
    UserModel _userModel = UserModel(
      userId: userCredential.user!.uid,
      username: username,
      nickname: nickname,
      postIdList: [],
      pendingPostIdList: [],
    );
    FirestoreUser().addUserToFirestore(_userModel);
  }

  // 휴대전화 local 에 login 정보 저장
  Future<bool> saveUserLocal(UserModel userModel) async {
    await LocalStorageUser.setUserData(userModel);
    return true;
  }

  // 휴대전화 local 에서 login 정보 삭제
  void signOut() async {
    try {
      await _auth.signOut();
      LocalStorageUser.clearUserData();
      Get.offAll(LoginView());
    } catch (error) {
      print(error);
    }
  }
}
