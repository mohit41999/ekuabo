import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/home/most_recent_new_feed.dart';
import 'package:ekuabo/model/apimodel/sign_up/lga_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/home_view_repository.dart';
import 'package:ekuabo/model/apimodel/home/news_feeds.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewsFeedsViewAllController extends GetxController {
  bool isLoad = true;
  UserBean userBean;
  LgaBean lgaBean;
  HomeViewRepository _homeViewRepository;
  List<NewsFeedData> newsFeeds = [];
  TextEditingController commentCtl = TextEditingController();
  NewsFeedsViewAllController() {
    _homeViewRepository = Get.find<HomeViewRepository>();
  }

  void getNewsFeeds() async {
    isLoad = true;
    userBean = await PrefManager.getUser();

    var result = await _homeViewRepository.getNewsFeeds();
    if (result != null) {
      NewsFeedBean newsFeedBean = result;
      if (newsFeedBean.status) {
        newsFeeds = newsFeedBean.data;
      }
    }
    isLoad = false;
    update();
  }

  void comment(BuildContext context, String feedId) async {
    if (commentCtl.text.isNotEmpty) {
      var loader = ProgressView(context);
      loader.show();
      userBean = await PrefManager.getUser();
      var param = {
        'user_id': userBean.data.id,
        'feed_id': feedId,
        'comment': commentCtl.text
      };
      commentCtl.text = "";
      var result = await _homeViewRepository.comment(param);
      loader.dismiss();
      if (result != null) {
        BaseBean baseBean = result;
        Utils().showSnackBar(Get.context, baseBean.message);
      }
    }
    getNewsFeeds();
  }

  void report(BuildContext context, String feedId) async {
    var loader = ProgressView(context);
    loader.show();
    userBean = await PrefManager.getUser();
    var param = {
      'user_id': userBean.data.id,
      'feed_id': feedId,
    };
    var result = await _homeViewRepository.report(param);
    loader.dismiss();
    if (result != null) {
      BaseBean baseBean = result;
      Utils().showSnackBar(Get.context, baseBean.message);
    }
    getNewsFeeds();
  }

  void like(BuildContext context, String feedId) async {
    var loader = ProgressView(context);
    loader.show();
    userBean = await PrefManager.getUser();
    var param = {
      'user_id': userBean.data.id,
      'feed_id': feedId,
    };
    var result = await _homeViewRepository.like(param);
    loader.dismiss();
    if (result != null) {
      BaseBean baseBean = result;
      Utils().showSnackBar(Get.context, baseBean.message);
    }
    getNewsFeeds();
  }

  void unlike(BuildContext context, String feedId) async {
    var loader = ProgressView(context);
    loader.show();
    userBean = await PrefManager.getUser();
    var param = {
      'user_id': userBean.data.id,
      'feed_id': feedId,
    };
    var result = await _homeViewRepository.unlike(param);
    loader.dismiss();
    if (result != null) {
      BaseBean baseBean = result;
      Utils().showSnackBar(Get.context, baseBean.message);
    }
    getNewsFeeds();
  }
}
