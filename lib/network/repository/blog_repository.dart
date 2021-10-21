import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/model/apimodel/blog/most_recent_blog.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BlogRepository {
  HttpService _httpService;

  BlogRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<MostRecentBlog> getMostRecentBlog() async {
    try {
      var response =
          await _httpService.postRequest('blog/most_recent_blog.php', {});
      var jsonString = json.decode(response.data);
      return MostRecentBlog.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
  // {
  // 'token': '123456789',
  // 'user_id': userBean.data.id,
  // 'blog_title': blogTitleCtl.text,
  // 'blog_desc': blogDescCtl.text,
  // 'image': mediaFile.path,
  // };

  Future<BaseBean> addPostBlog(Map<String, dynamic> param) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://eku-abo.com/api/blog/add_blog.php"));
    request.fields['user_id'] = param['user_id'];
    request.fields['blog_title'] = param['blog_title'];

    request.fields['blog_desc'] = param['blog_desc'];

    request.fields['token'] = '123456789';
    print(param['user_id']);
    print(param['message']);

    var pic = await http.MultipartFile.fromPath("blog_image", param['image']);
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();

    var responseString = String.fromCharCodes(responseData);
    print(responseString + 'kkkkkkkkkkkkkkkkkkkkkkkkk');
  }

  // Future<BaseBean> addPostBlog(Map<String,dynamic> param) async
  // {
  //   try {
  //
  //     var response = await _httpService.postRequest('blog/add_blog.php',param);
  //     var jsonString = json.decode(response.data);
  //     return BaseBean.fromJson(jsonString);
  //   } on HttpException catch (e) {
  //     Utils().showSnackBar(Get.context,e.response);
  //   }
  //   return null;
  // }
  Future<BaseBean> addComment(Map<String, dynamic> param) async {
    try {
      var response =
          await _httpService.postRequest('blog/add_blog_comment.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }

  Future<BaseBean> deleteBlog(Map<String, dynamic> param) async {
    try {
      var response =
          await _httpService.postRequest('blog/delete_blog.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
}
