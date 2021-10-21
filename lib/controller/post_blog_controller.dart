import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/repository/blog_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostBlogController extends GetxController {
  var blogTitleCtl = TextEditingController();
  var blogDescCtl = TextEditingController();
  final picker = ImagePicker();
  PickedFile mediaFile;
  BlogRepository _blogRepository;
  PostBlogController() {
    _blogRepository = Get.find<BlogRepository>();
  }
  void callPostBlogApi(BuildContext context) async {
    if (blogTitleCtl.text.isEmpty) {
      Utils().showSnackBar(context, 'Enter Blog title');
    } else if (mediaFile == null) {
      Utils().showSnackBar(context, 'Select Media');
    } else if (blogDescCtl.text.isEmpty) {
      Utils().showSnackBar(context, 'Enter Blog description');
    } else {
      var userBean = await PrefManager.getUser();
      var param = {
        'token': '123456789',
        'user_id': userBean.data.id,
        'blog_title': blogTitleCtl.text,
        'blog_desc': blogDescCtl.text,
        'image': mediaFile.path,
      };
      var loader = ProgressView(context);
      loader.show();
      var result = await _blogRepository.addPostBlog(param);
      loader.dismiss();
      if (result != null) {
        BaseBean baseBean = result;
        Utils().showSnackBar(context, baseBean.message);
      }
    }
  }
}
