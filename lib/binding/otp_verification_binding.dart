import 'package:ekuabo/controller/otp_verification_controller.dart';
import 'package:ekuabo/network/repository/otp_verification_repository.dart';
import 'package:get/get.dart';

class OtpVerificationBinding extends Bindings
{
  @override
  void dependencies() {
    Get.put(OtpVerificationRepository());
    Get.put(OtpVerificationController());
  }

}