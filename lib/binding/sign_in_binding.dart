import 'package:ekuabo/controller/sign_in_controller.dart';
import 'package:ekuabo/network/repository/sign_in_repository.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings
{
  @override
  void dependencies() {
    Get.put(SignInRepository());
    Get.put(SignInController());
  }

}