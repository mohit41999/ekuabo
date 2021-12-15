import 'package:ekuabo/model/apimodel/banner/banner_bean.dart';
import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/banner_repository.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyPostedBannerAdController extends GetxController {
  BannerRepository _bannerRepository;
  List<BannerBeanData> bannerList = [];

  MyPostedBannerAdController() {
    _bannerRepository = Get.find<BannerRepository>();
  }
  void getBannerList() async {
    var result = await _bannerRepository.getBannerList();

    if (result != null) {
      BannerBean bannerBean = result;
      if (bannerBean.status) {
        bannerList = bannerBean.data.reversed.toList();
      }
    }
    update();
  }

  Future<void> deleteBannerAd(String banner_id, BuildContext context) async {
    var loader = ProgressView(context);
    loader.show();
    UserBean userBean = await PrefManager.getUser();
    var result = await _bannerRepository.deleteBannerAd({
      'token': HttpServiceImpl().TOKEN,
      'user_id': userBean.data.id,
      'banner_id': banner_id
    });
    loader.dismiss();
  }
}
