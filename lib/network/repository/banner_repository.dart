import 'dart:convert';

import 'package:ekuabo/model/apimodel/banner/banner_ad_bean.dart';
import 'package:ekuabo/model/apimodel/banner/banner_bean.dart';
import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/banner/display_banner_ads.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

String tkn = '123456789';

class BannerRepository {
  HttpService _httpService;

  BannerRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<BannerBean> getBannerList() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'banner/get_my_banner_list.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return BannerBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BannerSlotBean> getBannerSlot() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'banner/get_banner_slot.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return BannerSlotBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BannerAdBean> addBannerAd(Map<String, dynamic> param) async {
    try {
      var response =
          await _httpService.postRequest('banner/add_banner.php', param);
      var jsonString = json.decode(response.data);
      return BannerAdBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BannerAdBean> addBannerAdwithImage(Map<String, dynamic> param) async {
    {
      var request = http.MultipartRequest(
          "POST", Uri.parse("https://eku-abo.com/api/banner/add_banner.php"));
      request.fields['token'] = tkn;
      request.fields['user_id'] = param['user_id'];
      request.fields['slot_id'] = param['slot_id'];
      request.fields['banner_title'] = param['banner_title'];
      request.fields['url'] = param['url'];

      request.fields['description'] = param['description'];
      request.fields['total_days'] = param['total_days'];
      request.fields['price'] = param['price'];

      var pic = await http.MultipartFile.fromPath(
          "banner_image", param['banner_image']);
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();

      var responseString = String.fromCharCodes(responseData);
      var ResponseString = jsonDecode(responseString);
      print(responseString + 'kkkkkkkkkkkkkkkkkkkkkkkkk');
      return BannerAdBean.fromJson(ResponseString);
    }
  }

  Future<BannerModel> getpostads(Map<String, dynamic> param) async {
    try {
      var response =
          await _httpService.postRequest('banner/get_banner.php', param);
      var jsonString = json.decode(response.data);
      return BannerModel.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
}
