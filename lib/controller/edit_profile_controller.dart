import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/edit_profile_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  EditProfileRepository _repository;
  final picker = ImagePicker();
  PickedFile mediaFile;

  var nameCtl = TextEditingController();
  var emailCtl = TextEditingController();
  var contactNoCtl = TextEditingController();
  var homeContactCtl = TextEditingController();
  var homeTownCtl = TextEditingController();
  var occupationCtl = TextEditingController();
  var interestCtl = TextEditingController();
  var funFactCtl = TextEditingController();

  Future<void> fillvalues() async {
    var userBean = await PrefManager.getUser();
    nameCtl.text = userBean.data.userName;
    emailCtl.text = userBean.data.email;
    contactNoCtl.text = userBean.data.contactNo;
    homeContactCtl.text = userBean.data.homeContactNo;
    homeTownCtl.text = userBean.data.homeTown;
    occupationCtl.text = userBean.data.occupation;
    interestCtl.text = userBean.data.interests;
    funFactCtl.text = userBean.data.funFacts;
  }

  void clearControllers() {
    nameCtl.clear();
    emailCtl.clear();
    contactNoCtl.clear();
    homeContactCtl.clear();
    homeTownCtl.clear();
    occupationCtl.clear();
    interestCtl.clear();
    funFactCtl.clear();
  }

  EditProfileController() {
    _repository = Get.find<EditProfileRepository>();
  }
  void updateProfile(BuildContext context) async {
    if (nameCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter name");
    } else if (!Utils.isEmailValid(emailCtl.text)) {
      Utils().showSnackBar(context, "Enter valid email");
    } else if (contactNoCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Contact no.");
    } else if (homeContactCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Home contact no.");
    } else if (homeTownCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter home town");
    }
    /* else if(interestCtl.text.isEmpty)
      {
        Utils().showSnackBar(context, "Enter Interest");
      }*/
    else if (funFactCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Fun Fact");
    } else {
      var loader = ProgressView(context);
      var userBean = await PrefManager.getUser();
      loader.show();
      userBean.data.userName = nameCtl.text;
      userBean.data.email = emailCtl.text;
      userBean.data.homeContactNo = homeContactCtl.text;
      userBean.data.homeTown = homeTownCtl.text;
      userBean.data.mobileContactNo = contactNoCtl.text;
      userBean.data.funFacts = funFactCtl.text;
      userBean.data.occupation = occupationCtl.text;
      userBean.data.interests = interestCtl.text;
      String jsonString = json.encode(userBean);

      PrefManager.putString(PrefManager.USER_DATA, jsonString);
      var param = {
        'user_id': userBean.data.id,
        'userName': nameCtl.text,
        'public_email': emailCtl.text,
        'home_phone_no': homeContactCtl.text,
        'mobile_no': contactNoCtl.text,
        'home_town': homeTownCtl.text,
        'occupation': occupationCtl.text,
        'interest': interestCtl.text,
        'fun_facts': funFactCtl.text,
      };
      var result = await _repository.updateProfile(param);
      loader.dismiss();
      clearControllers();
      Navigator.pop(context);
      UserBean w = await PrefManager.getUser();
      print(w.data.userName.toString() + 'heloooooooowowowowoooooooooo');
      if (result != null) {
        BaseBean baseBean = result;
        print('json string' + jsonString);
        Utils().showSnackBar(context, baseBean.message);
      }
    }
  }

  Future updateProfilewithImage(BuildContext context, String imagePath) async {
    var loader = ProgressView(context);
    var userBean = await PrefManager.getUser();
    loader.show();
    userBean = await PrefManager.getUser();

    var request = http.MultipartRequest(
        "POST", Uri.parse("https://eku-abo.com/api/update_profile.php"));
    request.fields['user_id'] = userBean.data.id;
    request.fields['token'] = '123456789';
    request.fields['userName'] = nameCtl.text;
    request.fields['public_email'] = emailCtl.text;
    request.fields['home_phone_no'] = homeContactCtl.text;
    request.fields['mobile_no'] = contactNoCtl.text;
    request.fields['home_town'] = homeTownCtl.text;
    request.fields['occupation'] = occupationCtl.text;
    request.fields['interest'] = interestCtl.text;
    request.fields['fun_facts'] = funFactCtl.text;

    var pic = await http.MultipartFile.fromPath("profile_img", imagePath);
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    loader.dismiss();
    Navigator.pop(context);
  }
}
