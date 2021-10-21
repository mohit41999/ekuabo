import 'dart:convert';

import 'package:ekuabo/model/apimodel/banner/banner_ad_bean.dart';
import 'package:ekuabo/model/apimodel/banner/banner_bean.dart';
import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class BannerRepository{
  HttpService _httpService;

  BannerRepository(){
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<BannerBean> getBannerList() async
  {
    try {
      var userBean=await PrefManager.getUser();
      var response = await _httpService.postRequest('banner/get_my_banner_list.php',{'user_id':userBean.data.id});
      var jsonString = json.decode(response.data);
      return BannerBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<BannerSlotBean> getBannerSlot() async
  {
    try {
      var userBean=await PrefManager.getUser();
      var response = await _httpService.postRequest('banner/get_banner_slot.php',{'user_id':userBean.data.id});
      var jsonString = json.decode(response.data);
      return BannerSlotBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
  Future<BannerAdBean> addBannerAd(Map<String,dynamic> param) async
  {
    try {
      var response = await _httpService.postRequest('banner/add_banner.php',param);
      var jsonString = json.decode(response.data);
      return BannerAdBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
}