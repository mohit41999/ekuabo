import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInRepository {
  HttpService _httpService;

  SignInRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }

  Future<UserBean> signIn(Map<String, dynamic> param) async {
    try {
      var response = await _httpService.postRequest('login.php', param);
      var jsonString = json.decode(response.data);

      return UserBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
}
