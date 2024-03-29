import 'package:ekuabo/model/apimodel/home/home_market_place.dart';
import 'package:ekuabo/model/apimodel/home/most_recent_new_feed.dart';
import 'package:ekuabo/model/apimodel/home/news_feeds.dart';
import 'package:ekuabo/model/apimodel/market_place/market_place_bean.dart';
import 'package:ekuabo/network/repository/home_view_repository.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  HomeViewRepository _homeViewRepository;
  List<MarketPlaceData> homeMarketPlaces = [];
  List<MostRecentNewFeedData> mostRecentNewsFeeds = [];
  List<NewsFeedData> newsFeeds = [];

  HomeViewController() {
    _homeViewRepository = Get.find<HomeViewRepository>();
  }

  Future getMostRecentNewsFeed() async {
    var result = await _homeViewRepository.getNewsFeeds();
    if (result != null) {
      NewsFeedBean newsFeedBean = result;
      if (newsFeedBean.status) {
        newsFeeds = newsFeedBean.data;
      }
    }
    _getHomeMarketPlace();
  }

  Future getMostRecentBlogs() async {
    var result = await _homeViewRepository.getMostRecentNewsFeed();
    if (result != null) {
      MostRecentNewFeed mostRecentNewFeed = result;
      if (mostRecentNewFeed.status) {
        mostRecentNewsFeeds = mostRecentNewFeed.data.take(7);
      }
    }
    _getHomeMarketPlace();
  }

  void _getHomeMarketPlace() async {
    var result = await _homeViewRepository.getHomeMarketPlace();
    if (result != null) {
      MarketPlaceBean marketPlaceBean = result;
      if (marketPlaceBean.status) {
        homeMarketPlaces = marketPlaceBean.data.take(10).toList();
      }
    }
    update();
  }

  void reportMarketplace(BuildContext context, String marketplace_id) async {
    var loader = ProgressView(context);
    loader.show();
    var result = await _homeViewRepository.reportMarketplace(marketplace_id);
    if (result != null) {
      (!result.status)
          ? Utils().showSnackBar(context, result.message)
          : _getHomeMarketPlace();
      loader.dismiss();
    }
    loader.dismiss();
    update();
  }
}
