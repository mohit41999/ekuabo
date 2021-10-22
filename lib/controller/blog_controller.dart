import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/blog/most_recent_blog.dart';
import 'package:ekuabo/network/repository/blog_repository.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  List<MostRecentBlogData> mostRecentBlogs = [];
  BlogRepository _blogRepository;
  BlogController() {
    _blogRepository = Get.find<BlogRepository>();
  }
  Future getMostRecent() async {
    var result = await _blogRepository.getMostRecentBlog();
    if (result != null) {
      MostRecentBlog mostRecentBlog = result;
      if (mostRecentBlog.status) {
        mostRecentBlogs = mostRecentBlog.data;
      } else {
        mostRecentBlogs = [];
      }
    } else {
      mostRecentBlogs = [];
    }
    update();
  }

  void callDeleteBlogApi(BuildContext context, int index) async {
    var userBean = await PrefManager.getUser();
    var loader = ProgressView(context);
    loader.show();
    var param = {
      'user_id': userBean.data.id,
      'blog_id': mostRecentBlogs[index].blogId
    };
    var result = await _blogRepository.deleteBlog(param);

    loader.dismiss();
    if (result != null) {
      BaseBean baseBean = result;
      if (baseBean.status) {
        // mostRecentBlogs.removeAt(index);
        update();
      }
      Utils().showSnackBar(context, baseBean.message);
    }
  }
}
