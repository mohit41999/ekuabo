import 'dart:convert';

import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/model/localmodel/remember_me.dart';
import 'package:ekuabo/network/dio_logger.dart';
import 'package:ekuabo/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager{
  static const String IS_LOGGED_IN="is_logged_in";
  static const String REMEMBER_ME="remember_me";
  static const String USER_DATA="user-data";
  static void startSession() async
  {
    var prefs= await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGGED_IN,true);
  }
  static Future<bool> isSessionStart() async
  {
    var prefs= await SharedPreferences.getInstance();
     return prefs.getBool(IS_LOGGED_IN);
  }
  static Future<void> destroySession() async
  {
    var prefs= await SharedPreferences.getInstance();
    prefs.remove(IS_LOGGED_IN);
    // prefs.setBool(IS_LOGGED_IN,false);
  }
  static Future<UserBean> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawData = prefs.getString(USER_DATA);
    Log.info(rawData);
    Map<String,dynamic> map= json.decode(rawData);
    UserBean userBean=UserBean.fromJson(map);
    return userBean;
  }
  static Future<RememberMeBean> getRememberMeBean() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawData = prefs.getString(REMEMBER_ME);
    Log.info(rawData);
    Map<String,dynamic> map= json.decode(rawData);
    RememberMeBean rememberMeBean=RememberMeBean.fromJson(map);
    return rememberMeBean;
  }
  static putString(String key,String value) async
  {
    var prefs= await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static Future<String>  getString(String key) async
  {
    var prefs= await SharedPreferences.getInstance();
   return prefs.getString(key);
  }
}