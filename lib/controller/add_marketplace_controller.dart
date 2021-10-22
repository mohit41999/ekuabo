import 'package:ekuabo/model/apimodel/market_place/category_bean.dart';
import 'package:ekuabo/model/apimodel/market_place/sub_category_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddMarketPlaceController extends GetxController {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController listlocationcontroller = TextEditingController();
  TextEditingController listdesccontroller = TextEditingController();
  TextEditingController productpricecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  List<CategoryBeanData> categories = [];
  CategoryBeanData selectedCategory;
  List<SubCategoryBeanData> subCategories = [];
  SubCategoryBeanData selectedSubCategory;
  String currency_code = '';

  MarketPlaceRepository _marketPlaceRepository;

  AddMarketPlaceController() {
    _marketPlaceRepository = Get.find<MarketPlaceRepository>();
  }

  void clearcontrollers() {
    titlecontroller.clear();
    listlocationcontroller.clear();
    listdesccontroller.clear();
    productpricecontroller.clear();
    emailcontroller.clear();
    mobilenumbercontroller.clear();
  }

  void getCategory() async {
    selectedCategory = null;
    selectedSubCategory = null;
    // var loader=ProgressView(Get.context);
    // loader.show();
    var result = await _marketPlaceRepository.getCategory();
    // Get.back();
    if (result != null) {
      CategoryBean categoryBean = result;
      if (categoryBean.status) {
        categories = categoryBean.data;
      } else {
        Utils().showSnackBar(Get.context, categoryBean.message);
      }
    }
    update();
  }

  void getSubCategory(BuildContext context, String id) async {
    selectedSubCategory = null;
    var loader = ProgressView(context);
    loader.show();
    var result =
        await _marketPlaceRepository.getSubCategory({'category_id': id});
    Get.back();
    if (result != null) {
      SubCategoryBean subCategoryBean = result;
      if (subCategoryBean.status) {
        subCategories = subCategoryBean.data;
      } else {
        Utils().showSnackBar(context, subCategoryBean.message);
      }
    }
    update();
  }
}
