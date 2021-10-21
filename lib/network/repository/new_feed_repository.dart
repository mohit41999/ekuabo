import 'dart:convert';

import 'package:ekuabo/model/apimodel/base_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewFeedRepository {
  HttpService _httpService;

  NewFeedRepository() {
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<BaseBean> addFeed(Map<String, dynamic> param) async {
    try {
      var response =
          await _httpService.postRequest('feed/post_feed.php', param);
      var jsonString = json.decode(response.data);
      return BaseBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context, e.response);
    }
    return null;
  }
  // 'feed_type': 'p',
  // 'message': messageCtl.text,
  // 'media_type':
  // 'i', //if no media uploaded use n otherwise use i for image.
  // 'user_id': userBean.data.id,
  // 'imagesrc': image.path

  Future<BaseBean> postImage(Map<String, dynamic> param) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://eku-abo.com/api/feed/post_feed.php"));
    request.fields['user_id'] = param['user_id'];
    request.fields['feed_type'] = 'p';
    request.fields['message'] = param['message'];
    request.fields['media_type'] = 'i';
    request.fields['token'] = '123456789';
    print(param['user_id']);
    print(param['message']);

    var pic = await http.MultipartFile.fromPath("upload", param['imagesrc']);
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();

    var responseString = String.fromCharCodes(responseData);
    print(responseString + 'kkkkkkkkkkkkkkkkkkkkkkkkk');
  }
}
