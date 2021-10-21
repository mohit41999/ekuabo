import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/home/home_market_place.dart';
import 'package:ekuabo/model/apimodel/home/most_recent_new_feed.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';
import 'package:ekuabo/model/apimodel/home/news_feeds.dart';

class HomeViewRepository {
  HttpService _httpService;

  HomeViewRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<HomeMarketPlaceBean> getHomeMarketPlace() async {
    try {
      var response = await _httpService
          .postRequest('marketplace/get_homepage_marketplace_list.php', {});
      var jsonString = json.decode(response.data);
      return HomeMarketPlaceBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<HomeMarketPlaceBean> getHomeRecentBlogs() async {
    try {
      var response =
          await _httpService.postRequest('blog/most_recent_blog.php', {});
      var jsonString = json.decode(response.data);
      return HomeMarketPlaceBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<MostRecentNewFeed> getMostRecentNewsFeed() async {
    try {
      var response =
          await _httpService.postRequest('feed/most_recent_feed.php', {});
      var jsonString = json.decode(response.data);
      return MostRecentNewFeed.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<NewsFeedBean> getNewsFeeds() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService
          .postRequest('feed/feed_list.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return NewsFeedBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BaseBean> comment(Map<String, String> param) async {
    try {
      var response =
          await _httpService.postRequest('feed/feed_add_comment.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BaseBean> report(Map<String, String> param) async {
    try {
      var response =
          await _httpService.postRequest('feed/feed_add_reported.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BaseBean> like(Map<String, String> param) async {
    try {
      var response =
          await _httpService.postRequest('feed/feed_like.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BaseBean> unlike(Map<String, String> param) async {
    try {
      var response =
          await _httpService.postRequest('feed/feed_unlike.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
}
