import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/setting_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  SettingRepository _settingRepository;
  UserBean userBean;

  var oldPasswordCtl = TextEditingController();
  var newPasswordCtl = TextEditingController();
  var cPasswordCtl = TextEditingController();

  SettingController() {
    _settingRepository = Get.find<SettingRepository>();
  }
  void changePassword(BuildContext context) async {
    if (!Utils.isPasswordValid(oldPasswordCtl.text)) {
      Utils().showSnackBar(context, 'Enter valid old password*');
    } else if (!Utils.isPasswordValid(newPasswordCtl.text)) {
      Utils().showSnackBar(context, 'Enter valid new password*');
    } else if (newPasswordCtl.text == oldPasswordCtl.text) {
      Utils().showSnackBar(
          context, 'New password should not same as old password');
    } else if (newPasswordCtl.text != cPasswordCtl.text) {
      Utils().showSnackBar(context, "New password doesn't match");
    } else {
      userBean = await PrefManager.getUser();
      var loader = ProgressView(context);
      loader.show();
      var param = {
        'user_id': userBean.data.id,
        'old_password': oldPasswordCtl.text,
        'new_password': newPasswordCtl.text,
        'confirm_password': cPasswordCtl.text
      };
      var result = await _settingRepository.changePassword(param);
      print('11111  ' + cPasswordCtl.text + '22222  ' + newPasswordCtl.text);
      loader.dismiss();
      if (result != null) {
        BaseBean baseBean = result;
        Utils().showSnackBar(
            context, baseBean.message + '${oldPasswordCtl.text.toString()}');
      }
    }
  }
}
