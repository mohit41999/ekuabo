import 'package:ekuabo/model/apimodel/banner/banner_bean.dart';
import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/repository/banner_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyPostedBannerAdController extends GetxController
{
  BannerRepository _bannerRepository;
  List<BannerBeanData> bannerList=[];

  MyPostedBannerAdController(){
  _bannerRepository=Get.find<BannerRepository>();
}
void getBannerList()async
{
  var result =await _bannerRepository.getBannerList();

  if(result!=null)
    {
      BannerBean bannerBean=result;
      if(bannerBean.status)
        {
          bannerList=bannerBean.data;
        }
    }
  update();
}
}