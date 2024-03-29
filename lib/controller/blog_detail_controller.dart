import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/repository/blog_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BlogDetailController extends GetxController {
  var commentCtl = TextEditingController();
  bool isExpand = false;

  BlogRepository _blogRepository;

  BlogDetailController() {
    _blogRepository = Get.find<BlogRepository>();
  }

  Future callAddCommentApi(BuildContext context, String blogId) async {
    if (commentCtl.text.isNotEmpty) {
      var loader = ProgressView(context);
      loader.show();
      var userBean = await PrefManager.getUser();
      var param = {
        'user_id': userBean.data.id,
        'blog_id': blogId,
        'comment': commentCtl.text
      };
      var result = await _blogRepository.addComment(param);
      commentCtl.text = "";
      loader.dismiss();
      if (result != null) {
        BaseBean baseBean = result;
        Utils().showSnackBar(context, baseBean.message);
      }
    }
    update();
  }

  Future ReportBlog(BuildContext context, String blog_id) async {
    var userBean = await PrefManager.getUser();
    var param = {
      'token': '123456789',
      'user_id': userBean.data.id,
      'blog_id': blog_id,
    };
    var loader = ProgressView(context);
    loader.show();
    var result = await _blogRepository.reportBlog(param);
    loader.dismiss();
    if (result != null) {
      BaseBean baseBean = result;
      if (baseBean.status) {
        Utils().showSnackBar(context, baseBean.message);
      } else {
        Utils().showSnackBar(context, "You cannot Report your Own Blog");
      }
    }

    // update();
  }
}
