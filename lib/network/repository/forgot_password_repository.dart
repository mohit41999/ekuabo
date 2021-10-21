import 'dart:convert';

import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class ForgotPasswordRepository{
  HttpService _httpService;

  ForgotPasswordRepository(){
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<BaseBean> forgotPassword(Map<String,String> param) async
  {
    try {
      var response = await _httpService.postRequest('forgot_password.php',param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
}