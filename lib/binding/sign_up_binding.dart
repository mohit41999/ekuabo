import 'package:ekuabo/controller/sign_up_controller.dart';
import 'package:ekuabo/network/repository/sign_up_repository.dart';
import 'package:flutter_country/countries.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings
{
  @override
  void dependencies() {
    Get.put(SignUpRepository());
    Get.put(SignUpController());
  }

}