import 'package:ekuabo/model/apimodel/home/home_market_place.dart';
import 'package:ekuabo/model/apimodel/home/most_recent_new_feed.dart';
import 'package:ekuabo/network/repository/home_view_repository.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  HomeViewRepository _homeViewRepository;
  List<HomeMarketPlaceData> homeMarketPlaces = [];
  List<MostRecentNewFeedData> mostRecentNewsFeeds = [];

  HomeViewController() {
    _homeViewRepository = Get.find<HomeViewRepository>();
  }

  Future getMostRecentNewsFeed() async {
    var result = await _homeViewRepository.getMostRecentNewsFeed();
    if (result != null) {
      MostRecentNewFeed mostRecentNewFeed = result;
      if (mostRecentNewFeed.status) {
        mostRecentNewsFeeds = mostRecentNewFeed.data;
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
      HomeMarketPlaceBean marketPlaceBean = result;
      if (marketPlaceBean.status) {
        homeMarketPlaces = marketPlaceBean.data;
      }
    }
    update();
  }
}
