import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/groups/my_group_bean.dart';
import 'package:ekuabo/network/repository/my_group_repository.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GroupJoinRequestController extends GetxController {
  MyGroupRepository _groupRepository;

  List<MyGroupDataBean> groupJoinRequests = [];
  GroupJoinRequestController() {
    _groupRepository = Get.find<MyGroupRepository>();
  }
  void getGroupJoinRequestList() async {
    var result = await _groupRepository.getGroupJoinRequestList();
    if (result != null) {
      MyGroupBean myGroupBean = result;
      if (myGroupBean.status) {
        groupJoinRequests = myGroupBean.data;
      } else {
        groupJoinRequests = [];
      }
    }
    update();
  }

  Future AcceptGroupjoinRequest(String group_join_id) async {
    var result = await _groupRepository.AcceptGroupJoinRequest(group_join_id);
    getGroupJoinRequestList();
    print(result);
  }

  Future RejectGroupjoinRequest(String group_join_id) async {
    var result = await _groupRepository.RejectGroupJoinRequest(group_join_id);
    getGroupJoinRequestList();
    print(result);
  }
}
