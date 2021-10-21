import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/sign_up/country_bean.dart' as CountryBean;
import 'package:ekuabo/model/apimodel/sign_up/lga_bean.dart' as LgaBean;
import 'package:ekuabo/model/apimodel/sign_up/sign_up_bean.dart';
import 'package:ekuabo/model/apimodel/sign_up/state_bean.dart' as StateBean;
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/dio_logger.dart';
import 'package:ekuabo/network/repository/sign_up_repository.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/log.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country/flutter_country.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class SignUpController extends GetxController {
  BuildContext mContext;
  var hide_password = true.obs;
  var hide_password2 = true.obs;

  var emailCtl = TextEditingController();
  var passwordCtl = TextEditingController();
  var cPasswordCtl = TextEditingController();
  var mobileCtl = TextEditingController();
  var fullNameCtl = TextEditingController();
  var homeAddressCtl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  SignUpRepository _signUpRepo;
  var countries=<CountryBean.Data>[].obs;
  var states = <StateBean.Data>[].obs;
  var lgas = <LgaBean.Data>[].obs;
  CountryBean.Data selectedCountryBean;
  StateBean.Data selectedState;
  LgaBean.Data selectedLga;
  var countryList=<Country>[].obs;
 var selectedCountry=Country(name: "").obs;

  SignUpController() {
    _signUpRepo = Get.find<SignUpRepository>();
    countryList.value = Countries.all();
    for (var country in countryList) {
      if(country.name=='India')
      {
        selectedCountry.value=country;
      }
    }
  }

  void getCountry(BuildContext context) async {
    mContext=context;
    var progressView = ProgressView(context);
    progressView.show();
    var result = await _signUpRepo.getCountry();
    progressView.dismiss();
    if (result != null) {
      CountryBean.CountryBean countryBean = result;

      if (countryBean.status) {
        countries.value = countryBean.data;
        selectedState = null;
        states.value = [];
        selectedLga = null;
        lgas.value = [];
      } else {
        Utils().showSnackBar(context, countryBean.message);
      }
    }
  }

  void getState(CountryBean.Data data) async {
    var loader = ProgressView(mContext);
    loader.show();
    var result = await _signUpRepo.getState({'country_id': data.countryId});
   loader.dismiss();
    if (result != null) {
      StateBean.StateBean stateBean = result;
      if(stateBean.status)
        {
          states.value = stateBean.data;
          selectedCountryBean = data;
          selectedState = null;
          selectedLga = null;
          lgas.value = [];
        }
      else
        {
          Utils().showSnackBar(mContext, stateBean.message);
        }
    }
  }

  void getLga( StateBean.Data data)async {
    var loader = ProgressView(mContext);
    loader.show();
    var result=await _signUpRepo.getLGA({ 'state_id': data.stateID});
    loader.dismiss();
     if(result!=null)
       {
         LgaBean.LgaBean lgaBean=result;
         if(lgaBean.status)
           {
             lgas.value = lgaBean.data;
             selectedState = data;
             selectedLga = null;
           }
         else
           {
             Utils().showSnackBar(mContext, lgaBean.message);
           }
       }
  }

  void callSignUpApi(BuildContext context) async {
    if(selectedCountryBean==null)
      {
        Utils().showSnackBar(context, "Select Country");
      }
    else if(selectedState==null)
      {
        Utils().showSnackBar(context, "Select State");
      }
    else if(selectedLga==null)
      {
        Utils().showSnackBar(context, "Select LGA");
      }
    else if (!Utils.isEmailValid(emailCtl.text)) {
      Utils().showSnackBar(context, "Enter valid email");
    }
    else if(homeAddressCtl.text.isEmpty)
      {
        Utils().showSnackBar(context, "Enter home address");
      }
    else if(fullNameCtl.text.isEmpty)
      {
        Utils().showSnackBar(context, "Enter full name");
      }
    else if (!Utils.isPasswordValid(passwordCtl.text)) {
      Utils().showSnackBar(context, "Password should be have at least one capital character, one numeric, one special character and greater than and equal to 8 in length*");
    }
    else if(cPasswordCtl.text!=passwordCtl.text)
      {
        Utils().showSnackBar(context, "Password doesn't match");
      }
    else if(mobileCtl.text.isEmpty)
      {
        Utils().showSnackBar(context, "Enter phone number");
      }
    else {
      var progressView = ProgressView(context);
      progressView.show();
      var param = {
      'country_id':selectedCountryBean.countryId,
      'state_id':selectedState.stateID,
      'lga_id':selectedLga.id,
      'full_name':fullNameCtl.text,
      'email':emailCtl.text,
    'contact_no':"+${selectedCountry.value.callingCodes[0]}${mobileCtl.text}",
    'home_address':homeAddressCtl.text,
    'password':passwordCtl.text};
     var result = await _signUpRepo.signUp(param);
      progressView.dismiss();
      Log.info(json.encode(param));
      if (result != null) {
        SignupBean signupBean = result;
        if (signupBean.status && signupBean.data!=null) {
         // PrefManager.startSession();
          var userBean=UserBean(data: UserDataBean(contactNo: signupBean.data.mobileNo,id: signupBean.data.userId));
          String jsonString=json.encode(userBean);
          PrefManager.putString(PrefManager.USER_DATA, jsonString);
          Get.toNamed(EkuaboRoute.otpVerificationScreen);
        } else {
          Utils().showSnackBar(context, signupBean.message);
        }
      }
    }
  }
}
