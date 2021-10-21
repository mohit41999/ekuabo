import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/otp_verification_repository.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController
{
  var otpCtl=TextEditingController();

  UserBean userBean;

  OtpVerificationRepository _otpVerificationRepository;

  OtpVerificationController()
  {
    _otpVerificationRepository=Get.find<OtpVerificationRepository>();
  }
  @override
  void onInit() {
    super.onInit();
    PrefManager.getUser().then((value){
      userBean=value;
      update();
    });
  }
  void verifyOtp(BuildContext context)async
  {
    if (otpCtl.text.isNotEmpty) {
      var loader=ProgressView(context);
      loader.show();
      var param={
        'user_id':userBean.data.id,
        'mobile_no':userBean.data.contactNo,
        'otp':otpCtl.text
      };
      var result=await _otpVerificationRepository.verifyOtp(param);
      loader.dismiss();
      if(result!=null)
        {
          BaseBean baseBean=result;
          Utils().showSnackBar(context, baseBean.message);
          if(baseBean.status)
            {
              PrefManager.startSession();
              Get.offAllNamed(EkuaboRoute.homeScreen,parameters: {"fromSignup":"true"});
            }
        }
    }
  }
  void resendOtp(BuildContext context)async
  {
    userBean=await PrefManager.getUser();
    var loader=ProgressView(context);
    loader.show();
    var param={
      'user_id':userBean.data.id,
      'mobile_no':userBean.data.contactNo
    };
    var result=await _otpVerificationRepository.resendOtp(param);
    Get.back();
    if(result!=null)
    {
      BaseBean baseBean=result;
      if(!Get.parameters.containsKey("fromLogin"))
      Utils().showSnackBar(context, baseBean.message);
      else
        {

          Utils().showSnackBar(context, EkuaboString.otp_sent);
          Get.parameters={};
        }
    }
  }
}