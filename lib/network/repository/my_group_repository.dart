import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/home/home_market_place.dart';
import 'package:ekuabo/model/apimodel/groups/my_group_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class MyGroupRepository {
  HttpService _httpService;

  MyGroupRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<BaseBean> addNewGroup(Map<String, String> param) async {
    try {
      var response =
          await _httpService.postRequest('group/add_group.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<MyGroupBean> getMyGroups() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService
          .postRequest('group/my_group.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return MyGroupBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<MyGroupBean> getMyJoiningGroups() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'group/my_joining_group.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return MyGroupBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BaseBean> deleteGroup(Map<String, String> param) async {
    try {
      var response =
          await _httpService.postRequest('group/delete_my_group.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BaseBean> leaveGroup(Map<String, String> param) async {
    try {
      var response =
          await _httpService.postRequest('group/leave_group.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<MyGroupBean> getGroupInvitationList() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'group/group_invitation_list.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return MyGroupBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<MyGroupBean> getGroupJoinRequestList() async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'group/group_join_request_list.php', {'user_id': userBean.data.id});
      var jsonString = json.decode(response.data);
      return MyGroupBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<MyGroupBean> AcceptGroupJoinRequest(String group_join_id) async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'group/accept_group_join_request.php',
          {'user_id': userBean.data.id, 'group_join_id': group_join_id});
      var jsonString = json.decode(response.data);
      return MyGroupBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future RejectGroupJoinRequest(String group_join_id) async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'group/reject_group_join_request.php',
          {'user_id': userBean.data.id, 'group_join_id': group_join_id});
      var jsonString = json.decode(response.data);
      return MyGroupBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future AcceptGroupInvitationRequest(String invite_id) async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'group/accept_group_invitation.php',
          {'user_id': userBean.data.id, 'invite_id': invite_id});
      var jsonString = json.decode(response.data);
      return jsonString;
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future RejectGroupInvitationRequest(String invite_id) async {
    try {
      var userBean = await PrefManager.getUser();
      var response = await _httpService.postRequest(
          'group/reject_group_invitation.php',
          {'user_id': userBean.data.id, 'invite_id': invite_id});
      var jsonString = json.decode(response.data);
      return jsonString;
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
}
