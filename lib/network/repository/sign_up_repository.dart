import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/sign_up/country_bean.dart';
import 'package:ekuabo/model/apimodel/sign_up/lga_bean.dart';
import 'package:ekuabo/model/apimodel/sign_up/sign_up_bean.dart';
import 'package:ekuabo/model/apimodel/sign_up/state_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/log.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class SignUpRepository {
  HttpService _httpService;

  SignUpRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }

  Future<SignupBean> signUp(Map<String, dynamic> param) async
  {
    try {

      var response = await _httpService.postRequest('signup.php', param);
        var jsonString = json.decode(response.data);
        return SignupBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<CountryBean> getCountry() async
  {
    try {

      var response = await _httpService.postRequest('get_country.php',{});
      var jsonString = json.decode(response.data);
      return CountryBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<StateBean> getState(Map<String,String> param) async
  {
    try {

      var response = await _httpService.postRequest('get_state.php',param);
      var jsonString = json.decode(response.data);
      return StateBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<LgaBean> getLGA(Map<String,String> param) async
  {
    try {

      var response = await _httpService.postRequest('get_lga.php',param);
      var jsonString = json.decode(response.data);
      return LgaBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
}