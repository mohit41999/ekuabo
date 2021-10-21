import 'package:ekuabo/model/apimodel/market_place/market_place_bean.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:get/get.dart';

class MarketPlaceController extends GetxController {
  MarketPlaceRepository _marketPlaceRepository;

  List<MarketPlaceData> marketPlaces = [];
  List<MarketPlaceData> mymarketPlaces = [];

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
