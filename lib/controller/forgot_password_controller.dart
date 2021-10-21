import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/repository/forgot_password_repository.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordRepository _repository;
  var emailCtl = TextEditingController();
  ForgotPasswordController() {
    _repository = Get.find<ForgotPasswordRepository>();
  }
  void callForgotPasswordApi(BuildContext context) async {
    if (!Utils.isEmailValid(emailCtl.text)) {
      Utils().showSnackBar(context, "Enter valid email");
    } else {
      var loader = ProgressView(context);
      loader.show();
      var param = {'email': emailCtl.text};
      var result = await _repository.forgotPassword(param);
      loader.dismiss();
      if (result != null) {
        BaseBean baseBean = result;
        Utils().showSnackBar(context, baseBean.message);
      }
    }
  }
}
