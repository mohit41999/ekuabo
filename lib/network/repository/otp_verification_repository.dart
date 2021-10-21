import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class OtpVerificationRepository
{
  HttpService _httpService;
  OtpVerificationRepository()
  {
    _httpService=HttpServiceImpl();
    _httpService.init();
  }
  Future<BaseBean> verifyOtp(Map<String,dynamic> param) async
  {
    try {

      var response = await _httpService.postRequest('verify_otp.php',param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<BaseBean> resendOtp(Map<String,dynamic> param) async
  {
    try {

      var response = await _httpService.postRequest('resend_otp.php',param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
}