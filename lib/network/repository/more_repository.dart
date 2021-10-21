import 'dart:convert';

import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/more/user_profile_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class MoreRepository {
  HttpService _httpService;

  MoreRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<UserProfileBean> getUserProfile() async {
    try {
      var userBean = await PrefManager.getUser();
      print('fffffffffffffffff');
      var response = await _httpService
          .postRequest('get_user_profile.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return UserProfileBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
}
