import 'package:ekuabo/controller/otp_verification_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpVerification extends StatelessWidget
{
  final _con=Get.find<OtpVerificationController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(builder: (_)=>Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EkuaboString.otp_verification
                  .text
                  .bold
                  .size(25)
                  .makeCentered().p(10),
              EkuaboString.please_do_not_refresh_or_leave_the_page
                  .text
                  .size(12)
                  .bold.make().pOnly(left: 16,top: 50),
              VxCard(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "${EkuaboString.enter_the_otp_sent_to} ${_con.userBean==null?'':_con.userBean.data.contactNo}".text
                      .bold
                      .size(14)
                      .make().pOnly(top: 10,left: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: 45, minHeight: 45),
                    child: TextFormField(
                      controller: _con.otpCtl,
                      keyboardType: TextInputType.number,
                      decoration:const InputDecoration(

                          filled: true,
                          labelText: EkuaboString.otp,
                          labelStyle: TextStyle(
                              fontFamily: EkuaboAsset.CERA_PRO_FONT,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: MyColor.secondColor),
                          hintText: EkuaboString.enter_otp,
                          hintStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(7)),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: MyColor.mainColor))),
                    ).pOnly(left: 10,right: 10,top: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EkuaboString.did_nt_receive_otp.text
                          .medium
                          .size(12)
                          .make(),
                      EkuaboString.resend_otp.text
                          .bold
                          .color(MyColor.mainColor)
                          .size(12)
                          .make().onTap(()=>_con.resendOtp(context)),
                    ],
                  ).pOnly(top: 12,left: 10,right: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EkuaboString.use_another_number.text
                          .medium
                          .size(12)
                          .make(),
                      EkuaboString.change_registered_number.text
                          .bold
                          .color(MyColor.mainColor)
                          .size(12)
                          .make().onTap(()=>Get.back()),
                    ],
                  ).pOnly(top: 12,left: 10,right: 10),
                  MaterialButton(
                    minWidth: 170,
                    onPressed: () =>_con.verifyOtp(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: EkuaboString.verify
                        .toUpperCase()
                        .text
                        .color(MyColor.lightestGrey)
                        .make(),
                    color: MyColor.mainColor,
                    height: 45,
                  ).objectCenter().pOnly(top:20,bottom: 30),
                ],
              ).p(10)).withRounded(value: 12)
                  .color(MyColor.lightGrey)
                  .elevation(7)
                  .make().w(double.infinity).pOnly(left: 10,right: 10,top: 10)
            ],
          ),
        ),
      ),
    ),initState: (_){
      if(Get.parameters.containsKey("fromLogin"))
        {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _con.resendOtp(context);
          });
        }
    },);
  }

}