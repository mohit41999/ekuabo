import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/banner/banner_ad_bean.dart';
import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/banner/display_banner_ads.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/repository/banner_repository.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class AddBannerController extends GetxController {
  BannerRepository _bannerRepository;
  List<BannerSlotBeanData> bannerSlots = [];
  final picker = ImagePicker();
  PickedFile mediaFile;
  var bannerTitleCtl = TextEditingController();
  var bannerUrlCtl = TextEditingController();
  var bannerDescCtl = TextEditingController();
  var bannerDaysCtl = TextEditingController();
  var bannerPriceCtl = TextEditingController();
  String currency_code = '\$';
  void clearcontrollers() {
    bannerPriceCtl.clear();
    bannerDaysCtl.clear();
    bannerDescCtl.clear();
    bannerUrlCtl.clear();
    bannerTitleCtl.clear();
  }

  // Future<void> launchURL(String _url, BuildContext context) async {
  //   if (!await launch(
  //     _url,
  //     forceSafariVC: false,
  //     forceWebView: false,
  //     headers: <String, String>{'my_header_key': 'my_header_value'},
  //   )) {
  //     print('ok');
  //   } else {
  //     print('notok');
  //   }
  // }
  Future<void> launchURL(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Invalid Url'),
              content: Text('Could not launch $url'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'))
              ],
            );
          });
    }
  }
  //   if (!await launch(_url)) throw 'Could not launch $_url';
  // }

  AddBannerController() {
    _bannerRepository = Get.find<BannerRepository>();
  }
  void getBannerSlot() async {
    var result = await _bannerRepository.getBannerSlot();

    if (result != null) {
      BannerSlotBean bannerSlotBean = result;
      if (bannerSlotBean.status) {
        bannerSlots = bannerSlotBean.data;
      }
    }
    update();
  }

  void createMyAd(BuildContext context, HomeController homeController) async {
    BannerSlotBeanData checkedSlot = null;
    bannerSlots.forEach((element) {
      if (element.isChecked) {
        checkedSlot = element;
      }
    });
    if (bannerTitleCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Title");
    } else if (checkedSlot == null) {
      Utils().showSnackBar(context, "Choose Slot");
    } else if (bannerUrlCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Redirect Url");
    } else if (bannerDescCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Description");
    } else if (bannerDaysCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Days");
    } else if (bannerPriceCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Price");
    } else {
      var loader = ProgressView(context);
      loader.show();
      print(currency_code.toString() + '---------------');
      var userBean = await PrefManager.getUser();
      var param = {
        'user_id': userBean.data.id,
        'slot_id': checkedSlot.slotId,
        'banner_title': bannerTitleCtl.text,
        'url': bannerUrlCtl.text,
        'description': bannerDescCtl.text,
        'total_days': bannerDaysCtl.text,
        'price': bannerPriceCtl.text,
        'currency_code': currency_code,
      };
      var result = await _bannerRepository.addBannerAd(param);
      loader.dismiss();
      clearcontrollers();
      if (result != null) {
        BannerAdBean bannerAdBean = result;
        Utils().showSnackBar(context, bannerAdBean.message);
        if (bannerAdBean.status) {
          Get.toNamed(EkuaboRoute.payment_web_view,
                  arguments: bannerAdBean.data.paymentUrl)
              .then((value) {
            homeController.bottomNavigatorKey.currentState.pop();
          });
        }
      }
    }
  }

  void createMyAdwithImage(BuildContext context, HomeController homeController,
      PickedFile image) async {
    BannerSlotBeanData checkedSlot = null;
    bannerSlots.forEach((element) {
      if (element.isChecked) {
        checkedSlot = element;
      }
    });
    if (bannerTitleCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Title");
    } else if (checkedSlot == null) {
      Utils().showSnackBar(context, "Choose Slot");
    } else if (bannerUrlCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Redirect Url");
    } else if (bannerDescCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Description");
    } else if (bannerDaysCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Days");
    } else if (bannerPriceCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Price");
    } else {
      var loader = ProgressView(context);
      loader.show();
      var userBean = await PrefManager.getUser();
      var param = {
        'user_id': userBean.data.id,
        'slot_id': checkedSlot.slotId,
        'banner_title': bannerTitleCtl.text,
        'url': bannerUrlCtl.text,
        'description': bannerDescCtl.text,
        'total_days': bannerDaysCtl.text,
        'price': bannerPriceCtl.text,
        'banner_image': image.path,
        'currency_code': currency_code
      };
      var result = await _bannerRepository.addBannerAdwithImage(param);
      loader.dismiss();
      clearcontrollers();
      if (result != null) {
        BannerAdBean bannerAdBean = result;
        Utils().showSnackBar(context, bannerAdBean.message);
        if (bannerAdBean.status) {
          Get.toNamed(EkuaboRoute.payment_web_view,
                  arguments: bannerAdBean.data.paymentUrl)
              .then((value) {
            homeController.bottomNavigatorKey.currentState.pop();
          });
        }
      }
    }
  }

  Future<BannerModel> getslotads(BuildContext context, String slot_id) async {
    var userBean = await PrefManager.getUser();
    var param = {'user_id': userBean.data.id, 'slot_id': slot_id};
    var result = await _bannerRepository.getpostads(param);
    return result;
  }
}
