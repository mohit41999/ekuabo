import 'dart:convert';

import 'package:ekuabo/model/apimodel/transaction/transaction_bean.dart';
import 'package:ekuabo/network/http_exception.dart';
import 'package:ekuabo/network/service/http_service.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:get/get.dart';

class TransactionHistoryRepository
{
  HttpService _httpService;

  TransactionHistoryRepository(){
    _httpService = HttpServiceImpl();
    _httpService.init();
  }
  Future<TransactionBean> getTransaction() async
  {
    try {
      var userBean=await PrefManager.getUser();
      var response = await _httpService.postRequest('get_transation_history.php',{'user_id':userBean.data.id});
      var jsonString = json.decode(response.data);
      return TransactionBean.fromJson(jsonString);
    } on HttpException catch (e) {
      Utils().showSnackBar(Get.context,e.response);
    }
    return null;
  }
}