import 'package:ekuabo/model/apimodel/home/home_market_place.dart';
import 'package:ekuabo/model/apimodel/home/most_recent_new_feed.dart';
import 'package:ekuabo/model/apimodel/home/news_feeds.dart';
import 'package:ekuabo/model/apimodel/market_place/market_place_bean.dart';
import 'package:ekuabo/network/repository/home_view_repository.dart';
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
        mostRecentNewsFeeds = mostRecentNewFeed.data;
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
}
