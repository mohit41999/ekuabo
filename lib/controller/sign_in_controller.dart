import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/model/localmodel/remember_me.dart';
import 'package:ekuabo/network/repository/sign_in_repository.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/log.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var hide_password = true.obs;
  var rememberMe = false.obs;

  var emailCtl = TextEditingController();
  var passwordCtl = TextEditingController();

  RememberMeBean rememberMeBean;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SignInRepository _signInRepo;
  SignInController() {
    _signInRepo = Get.find<SignInRepository>();
  }
  @override
  void onInit() async {
    super.onInit();
    var jsonString = await PrefManager.getString(PrefManager.REMEMBER_ME);
    Log.info(jsonString);
    if (jsonString != null) {
      PrefManager.getRememberMeBean().then((value) {
        rememberMeBean = value;
        rememberMe.value = true;
        emailCtl.text = rememberMeBean.email;
        passwordCtl.text = rememberMeBean.password;
      });
    }
  }

  void callSignInApi(BuildContext context) async {
    if (!Utils.isEmailValid(emailCtl.text)) {
      Utils().showSnackBar(context, "Enter valid email");
    } else if (passwordCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter password");
    } else {
      var progressView = ProgressView(context);
      progressView.show();
      var param = {
        'email': emailCtl.text,
        'password': passwordCtl.text,
        'token': '123456789'
      };
      var result = await _signInRepo.signIn(param);
      progressView.dismiss();
      if (result != null) {
        UserBean userBean = result;
        if (!userBean.status && userBean.data == null) {
          Utils().showSnackBar(context, userBean.message);
        } else if (userBean.data != null) {
          if (rememberMe.value) {
            var rememberMeBean = RememberMeBean(
                email: emailCtl.text, password: passwordCtl.text);
            String jsonString = json.encode(rememberMeBean);
            PrefManager.putString(PrefManager.REMEMBER_ME, jsonString);
          }
          String jsonString = json.encode(userBean);
          PrefManager.putString(PrefManager.USER_DATA, jsonString);
          Log.info(userBean.data.verifiedNumber);
          if (userBean.data.verifiedNumber == 'n') {
            Get.toNamed(EkuaboRoute.otpVerificationScreen,
                parameters: {"fromLogin": "true"});
          } else {
            PrefManager.startSession();
            Get.offAllNamed(EkuaboRoute.homeScreen);
          }
        } else {
          Utils().showSnackBar(context, userBean.message);
        }
      }
    }
  }
}
