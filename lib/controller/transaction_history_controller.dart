import 'package:ekuabo/model/apimodel/transaction/transaction_bean.dart';
import 'package:ekuabo/network/repository/transaction_history_repository.dart';
import 'package:get/get.dart';

class TransactionHistoryController extends GetxController
{
  TransactionHistoryRepository _repository;
  List<TransactionDataBean> transactions=[];
  TransactionHistoryController()
  {
    _repository=Get.find<TransactionHistoryRepository>();
  }
  void getTransaction()async
  {
    var result=await _repository.getTransaction();
    if(result!=null)
      {
        TransactionBean transactionBean=result;
        if(transactionBean.status)
          {
            transactions=transactionBean.data;
          }
      }
    update();
  }
}