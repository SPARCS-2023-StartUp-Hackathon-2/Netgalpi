import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

class LocalStorageUser {
  static setUserData(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(userModel.toJson()));
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return UserModel.fromJson(
          json.decode(prefs.getString('user')!) as Map<dynamic, dynamic>);
    } catch (e) {
      print('failed to getuserdata');
      return null;
    }
  }

  static clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
