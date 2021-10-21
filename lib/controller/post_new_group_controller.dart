import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/my_group_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PostNewGroupController extends GetxController {
  MyGroupRepository _repository;

  var groupNameCtl = TextEditingController();
  var groupDescCtl = TextEditingController();
  final picker = ImagePicker();
  PickedFile mediaFile;
  PostNewGroupController() {
    _repository = Get.find<MyGroupRepository>();
  }
  void addNewGroup(BuildContext context) async {
    if (groupNameCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Group Name");
    } else if (groupDescCtl.text.isEmpty) {
      Utils().showSnackBar(context, "Enter Group Description");
    } else {
      if (mediaFile.toString() != null.toString()) {
        UserBean userBean = await PrefManager.getUser();
        var request = http.MultipartRequest(
            "POST", Uri.parse("https://eku-abo.com/api/group/add_group.php"));
        request.fields['user_id'] = userBean.data.id;
        request.fields['token'] = '123456789';
        request.fields['group_name'] = groupNameCtl.text;
        request.fields['group_desc'] = groupDescCtl.text.toString();
        var pic =
            await http.MultipartFile.fromPath("group_image", mediaFile.path);
        request.files.add(pic);
        var response = await request.send();

        //Get the response from the server
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print(responseString);
      } else {
        var userBean = await PrefManager.getUser();
        var loader = ProgressView(context);
        var param = {
          'group_name': groupNameCtl.text,
          'group_desc': groupDescCtl.text,
          'user_id': userBean.data.id,
          'group_image': 'n'
        };
        loader.show();
        var result = await _repository.addNewGroup(param);
        loader.dismiss();
        if (result != null) {
          BaseBean baseBean = result;
          Utils().showSnackBar(context, baseBean.message);
        }
      }
    }
  }
}
