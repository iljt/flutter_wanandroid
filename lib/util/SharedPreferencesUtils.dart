import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../entity/user_info_entity.dart';
import '../generated/json/base/json_convert_content.dart';

class SharedPreferencesUtils {

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static setInt(String key, int value) {
    getSharedPreferences().then((SharedPreferences prefs) {
      prefs.setInt(key, value);
    });
  }

  static setString(String key, String value) {
    getSharedPreferences().then((SharedPreferences prefs) {
      prefs.setString(key, value);
    });
  }

  static setBool(String key, bool value) {
    getSharedPreferences().then((SharedPreferences prefs) {
      prefs.setBool(key, value);
    });
  }

  static setDouble(String key, double value) {
    getSharedPreferences().then((SharedPreferences prefs) {
      prefs.setDouble(key, value);
    });
  }

  static setStringList(String key, List<String> value) {
    getSharedPreferences().then((prefs) {
      prefs.setStringList(key, value);
    });
  }

  // 移除
  static remove(String key) {
    getSharedPreferences().then((prefs) {
      prefs.remove(key);
    });
  }

  /*登录用户数据缓存*/
  static saveUserInfo(UserInfoEntity user) {
    getSharedPreferences().then((prefs) {
      String jsonStr = jsonEncode(user);
      prefs.setString('user_info', jsonStr);
    });
  }

  /*获取登录用户数据缓存*/
  static Future<UserInfoEntity?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserInfoEntity? userInfoEntity = JsonConvert.fromJsonAsT<UserInfoEntity>(jsonDecode(prefs.getString('user_info').toString()));
    return userInfoEntity;
  }

  /*移除登录用户数据缓存*/
  static removeUserInfo() {
    getSharedPreferences().then((prefs) {
      prefs.remove('user_info');
    });
  }
}
