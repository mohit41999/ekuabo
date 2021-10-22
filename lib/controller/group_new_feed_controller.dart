import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/repository/group_post_new_feed_repository.dart';
import 'package:ekuabo/network/repository/new_feed_repository.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GroupNewFeedController extends GetxController {
  GroupNewFeedRepository _groupnewfeedRepository;
  var typeOfPost = EkuaboString.message.obs;
  final picker = ImagePicker();
  PickedFile mediaFile;

  var messageCtl = TextEditingController();

  void changeEventType(String type) {
    typeOfPost.value = type;
  }

  GroupNewFeedController() {
    _groupnewfeedRepository = Get.find<GroupNewFeedRepository>();
  }

  void addFeed(BuildContext context, String group_id) async {
    if (messageCtl.text.isNotEmpty) {
      var loader = ProgressView(context);
      loader.show();
      var userBean = await PrefManager.getUser();
      var param = {
        'group_id': group_id,
        'feed_type': 'p',
        'message': messageCtl.text,
        'media_type':
            'n', //if no media uploaded use n otherwise use i for image.
        'user_id': userBean.data.id
      };
      var result = await _groupnewfeedRepository.addGroupFeed(param);
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

  void addFeedwithImage(
      BuildContext context, PickedFile image, String group_id) async {
    if (messageCtl.text.isNotEmpty) {
      var loader = ProgressView(context);
      loader.show();
      var userBean = await PrefManager.getUser();
      print('lllllllllllllllllllllllll');
      var param = {
        'feed_type': 'p',
        'group_id': group_id,
        'message': messageCtl.text,
        'media_type':
            'i', //if no media uploaded use n otherwise use i for image.
        'user_id': userBean.data.id,
        'upload': image.path
      };
      var result = await _groupnewfeedRepository.postImage(param);
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
