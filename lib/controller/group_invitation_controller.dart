import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/groups/my_group_bean.dart';
import 'package:ekuabo/network/repository/my_group_repository.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GroupInvitationController extends GetxController {
  MyGroupRepository _groupRepository;

  List<MyGroupDataBean> groupInvitations = [];

  GroupInvitationController() {
    _groupRepository = Get.find<MyGroupRepository>();
  }
  void getGroupInvitationList() async {
    var result = await _groupRepository.getGroupInvitationList();
    if (result != null) {
      MyGroupBean myGroupBean = result;
      if (myGroupBean.status) {
        groupInvitations = myGroupBean.data;
      } else {
        groupInvitations = [];
      }
    }
    update();
  }

  void AcceptGroupInvitation(String invite_id) async {
    var result = await _groupRepository.AcceptGroupInvitationRequest(invite_id);
    if (result != null) {
      getGroupInvitationList();
    }
    update();
  }

  void RejectGroupInvitation(String invite_id) async {
    var result = await _groupRepository.RejectGroupInvitationRequest(invite_id);
    getGroupInvitationList();

    update();
  }
}
