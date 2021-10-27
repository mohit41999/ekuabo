import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/groups/my_group_bean.dart';
import 'package:ekuabo/network/repository/my_group_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyGroupController extends GetxController {
  MyGroupRepository _groupRepository;

  List<MyGroupDataBean> myGroups = [];
  List<MyGroupDataBean> myJoiningGroups = [];

  MyGroupController() {
    _groupRepository = Get.find<MyGroupRepository>();
  }
  void getMyGroups() async {
    var result = await _groupRepository.getMyGroups();
    if (result != null) {
      MyGroupBean myGroupBean = result;
      if (myGroupBean.status) {
        myGroups = myGroupBean.data;
      }
    }
    update();
  }

  void getMyJoiningGroup() async {
    var result = await _groupRepository.getMyJoiningGroups();
    if (result != null) {
      MyGroupBean myGroupBean = result;
      if (myGroupBean.status) {
        myJoiningGroups = myGroupBean.data;
      }
    }
    update();
  }

  Future callLeaveMyGroupApi(BuildContext context, String index) async {
    var loader = ProgressView(context);
    loader.show();
    var userBean = await PrefManager.getUser();
    var param = {
      'user_id': userBean.data.id,
      'group_id': index.toString(),
    };
    var result = await _groupRepository.leaveGroup(param);
    loader.dismiss();
    if (result != null) {
      BaseBean baseBean = result;
      Utils().showSnackBar(context, baseBean.message);
    }
  }

  void deleteGroup(BuildContext context, int index) async {
    var loader = ProgressView(context);
    loader.show();
    var userBean = await PrefManager.getUser();
    var param = {
      'user_id': userBean.data.id,
      'group_id': myGroups[index].groupId
    };
    var result = await _groupRepository.deleteGroup(param);
    loader.dismiss();
    if (result != null) {
      BaseBean baseBean = result;
      if (baseBean.status) {
        myGroups.removeAt(index);
        update();
      }
      Utils().showSnackBar(context, baseBean.message);
    }
  }
}
