import 'dart:convert';

import 'package:ekuabo/model/apimodel/market_place/category_bean.dart';
import 'package:ekuabo/model/apimodel/market_place/market_place_bean.dart';
import 'package:ekuabo/model/apimodel/market_place/marketplace_Details_model.dart';
import 'package:ekuabo/model/apimodel/market_place/searchMarketplaceModel.dart';
import 'package:ekuabo/model/apimodel/market_place/sub_category_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class MarketPlaceRepository {
  HttpService _httpService;

  MarketPlaceRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }

  Future<MarketPlaceBean> getMarketPlace() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'marketplace/search_marketplace.php',
          {'user_id': userBean.data.id, 'token': '123456789'});
      var jsonString = json.decode(response.data);
      return MarketPlaceBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
  }

  Future<MarketPlaceBean> getMyMarketPlace() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'marketplace/my_marketplace_list.php',
          {'user_id': userBean.data.id, 'token': '123456789'});
      var jsonString = json.decode(response.data);
      return MarketPlaceBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
  }

  Future<MarketPlaceBean> getShopMarketPlace(String user_id) async {
    try {
      var response = await _httpService.postRequest(
          'marketplace/my_marketplace_list.php',
          {'user_id': user_id, 'token': '123456789'});
      var jsonString = json.decode(response.data);
      return MarketPlaceBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<CategoryBean> getCategory() async {
    try {
      var response =
          await _httpService.postRequest('marketplace/get_category.php', {});
      var jsonString = json.decode(response.data);
      return CategoryBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<SubCategoryBean> getSubCategory(Map<String, dynamic> param) async {
    try {
      var response = await _httpService.postRequest(
          'marketplace/get_sub_category.php', param);
      var jsonString = json.decode(response.data);
      return SubCategoryBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
}
