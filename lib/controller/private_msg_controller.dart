import 'package:ekuabo/model/apimodel/banner/banner_slot.dart';
import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/chat/chat_bean.dart';
import 'package:ekuabo/network/repository/banner_repository.dart';
import 'package:ekuabo/network/repository/private_msg_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class PrivateMessageBoardController extends GetxController {
  PrivateMsgRepository _repository;
  List<ChatDataBean> chatList = [];

  PrivateMessageBoardController() {
    _repository = Get.find<PrivateMsgRepository>();
  }
  void getChatList() async {
    var result = await _repository.getChatList();

    if (result != null) {
      ChatBean chatBean = result;
      if (chatBean.status) {
        chatList = chatBean.data;
      }
    }
    update();
  }

  void deleteChat(int index) async {
    var userBean = await PrefManager.getUser();
    var param = {
      'chat_id': chatList[index].chatId.toString(),
      'user_id': userBean.data.id
    };
    var result = await _repository.deleteChat(param);
    if (result != null) {
      BaseBean baseBean = result;
      if (baseBean.status) {
        chatList.removeAt(index);
      }
      Utils().showSnackBar(Get.context, baseBean.message);
    }
    update();
  }
}
