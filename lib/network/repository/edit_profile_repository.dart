import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/chat/chat_bean.dart';
import 'package:ekuabo/model/apimodel/chat/user_chat_bean.dart';
import 'package:ekuabo/model/apimodel/transaction/transaction_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class EditProfileRepository
{
  HttpService _httpService;

  EditProfileRepository(){
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<BaseBean> updateProfile(Map<String,String> param) async
  {
    try {
      var userBean=await PrefManager.getUser();
      var response = await _httpService.postRequest('update_profile.php',param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<BaseBean> deleteChat(Map<String,String> param) async
  {
    try {
      var response = await _httpService.postRequest('message/get_chat_user_list.php',param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<UserChatBean> getUserChatList(Map<String,String> param) async
  {
    try {
      var response = await _httpService.postRequest('message/get_chat.php',param);
      var jsonString = json.decode(response.data);
      return UserChatBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<BaseBean> sendMsg(Map<String,String> param) async
  {
    try {
      var response = await _httpService.postRequest('message/send_msg.php',param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
}