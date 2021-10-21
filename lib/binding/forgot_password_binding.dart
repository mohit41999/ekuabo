import 'package:ekuabo/controller/forgot_password_controller.dart';
import 'package:ekuabo/network/repository/forgot_password_repository.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings
{
  @override
  void dependencies() {
 Get.put(ForgotPasswordRepository());
 Get.put(ForgotPasswordController());
  }

}