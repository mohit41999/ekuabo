import 'package:ekuabo/model/apimodel/more/user_profile_bean.dart';
import 'package:ekuabo/network/repository/more_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  MoreRepository _repository;

  UserProfileDataBean userProfileDataBean;
  MoreController() {
    _repository = Get.find<MoreRepository>();
  }
  void getUserProfile() async {
    userProfileDataBean = null;
    print('ooooooooooooooooooo');
    var result = await _repository.getUserProfile();
    print('ppppppppppppppppppppppppppp');
    if (result != null) {
      UserProfileBean userProfileBean = result;
      if (userProfileBean.status) {
        userProfileDataBean = userProfileBean.data;
        print('llllllllllllllllllllllllllll');
      } else {
        Utils().showSnackBar(Get.context, userProfileBean.message);
      }
    }
    update();
  }
}
