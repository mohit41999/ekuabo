import 'package:ekuabo/controller/payment_webview_controller.dart';
import 'package:get/get.dart';

class PaymentBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(PaymentWebViewController());
  }

}