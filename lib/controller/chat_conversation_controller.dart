import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/chat/user_chat_bean.dart';
import 'package:ekuabo/network/repository/private_msg_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatConversationController extends GetxController {
  PrivateMsgRepository _repository;
  List<UserChatDataBean> chatList = [];
  var msgCtl = TextEditingController();
  ChatConversationController() {
    _repository = Get.find<PrivateMsgRepository>();
  }
  void getUserChatList(String chatId) async {
    var userBean = await PrefManager.getUser();
    var param = {'chat_id': chatId, 'user_id': userBean.data.id};
    /*var param={
    'chat_id':'6',
    'user_id':'1'};*/
    var result = await _repository.getUserChatList(param);

    if (result != null) {
      UserChatBean userChatBean = result;
      if (userChatBean.status) {
        chatList = userChatBean.data;
      } else {
        chatList = [];
      }
    }
    else{
      chatList = [];
    }
    update();
  }

  void sendMsg(String chatId) async {
    if (msgCtl.text.isNotEmpty) {
      var userBean = await PrefManager.getUser();
      var param = {
        'chat_id': chatId,
        'user_id': userBean.data.id,
        'message': msgCtl.text,
        'is_media': 'n',
        'media_type': ''
      };
      var result = await _repository.sendMsg(param);
      if (result != null) {
        BaseBean baseBean = result;
        msgCtl.text = "";
        if (baseBean.status) {
          getUserChatList(chatId);
        } else
          Utils().showSnackBar(Get.context, baseBean.message);
      }
      update();
    }
  }
}
