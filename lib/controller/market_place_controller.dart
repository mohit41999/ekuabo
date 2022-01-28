import 'package:ekuabo/model/apimodel/market_place/category_bean.dart';
import 'package:ekuabo/model/apimodel/market_place/market_place_bean.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MarketPlaceController extends GetxController {
  MarketPlaceRepository _marketPlaceRepository;

  List<MarketPlaceData> marketPlaces = [];
  List<MarketPlaceData> mymarketPlaces = [];
  Future<CategoryBean> getMarketPlaceCategory =
      MarketPlaceRepository().getCategory();
  MarketPlaceController() {
    _marketPlaceRepository = Get.find<MarketPlaceRepository>();
  }
  void getMarketPlace() async {
    var result = await _marketPlaceRepository.getMarketPlace();
    if (result != null) {
      MarketPlaceBean marketPlaceBean = result;
      if (marketPlaceBean.status) {
        marketPlaces = marketPlaceBean.data;
      }
    }
    update();
  }

  void reportMarketplace(BuildContext context, String marketplace_id) async {
    var loader = ProgressView(context);
    loader.show();
    var result = await _marketPlaceRepository.reportMarketplace(marketplace_id);
    if (result != null) {
      (!result.status)
          ? Utils().showSnackBar(context, result.message)
          : getMarketPlace();
      loader.dismiss();
    }
    loader.dismiss();
    update();
  }

  void getMyMarketPlace() async {
    var result = await _marketPlaceRepository.getMyMarketPlace();
    if (result != null) {
      MarketPlaceBean marketPlaceBean = result;
      if (marketPlaceBean.status) {
        mymarketPlaces = marketPlaceBean.data;
      }
    }
    update();
  }

  void getShopMarketPlace(String user_id) async {
    var result = await _marketPlaceRepository.getShopMarketPlace(user_id);
    if (result != null) {
      MarketPlaceBean marketPlaceBean = result;
      if (marketPlaceBean.status) {
        marketPlaces = marketPlaceBean.data;
      }
    }
    update();
  }
}
