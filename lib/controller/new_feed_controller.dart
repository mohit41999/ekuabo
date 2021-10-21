import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/repository/new_feed_repository.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewFeedController extends GetxController {
  NewFeedRepository _feedRepository;
  var typeOfPost = EkuaboString.message.obs;
  final picker = ImagePicker();
  PickedFile mediaFile;

  var messageCtl = TextEditingController();

  void changeEventType(String type) {
    typeOfPost.value = type;
  }

  NewFeedController() {
    _feedRepository = Get.find<NewFeedRepository>();
  }
  void addFeed(
    BuildContext context,
  ) async {
    if (messageCtl.text.isNotEmpty) {
      var loader = ProgressView(context);
      loader.show();
      var userBean = await PrefManager.getUser();
      var param = {
        'feed_type': 'p',
        'message': messageCtl.text,
        'media_type':
            'n', //if no media uploaded use n otherwise use i for image.
        'user_id': userBean.data.id
      };
      var result = await _feedRepository.addFeed(param);
      loader.dismiss();
      messageCtl.clear();
      if (result != null) {
        BaseBean baseBean = result;
        Utils().showSnackBar(context, baseBean.message);
      }
    } else {
      Utils().showSnackBar(context, "Type Message");
    }
  }

  void addFeedwithImage(BuildContext context, PickedFile image) async {
    if (messageCtl.text.isNotEmpty) {
      var loader = ProgressView(context);
      loader.show();
      var userBean = await PrefManager.getUser();
      print('lllllllllllllllllllllllll');
      var param = {
        'feed_type': 'p',
        'message': messageCtl.text,
        'media_type':
            'i', //if no media uploaded use n otherwise use i for image.
        'user_id': userBean.data.id,
        'imagesrc': image.path
      };
      var result = await _feedRepository.postImage(param);
      loader.dismiss();
      messageCtl.clear();
      if (result != null) {
        BaseBean baseBean = result;
        Utils().showSnackBar(context, baseBean.message);
      }
    } else {
      Utils().showSnackBar(context, "Type Message");
    }
  }
}
