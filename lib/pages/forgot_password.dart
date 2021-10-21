import 'package:ekuabo/controller/forgot_password_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPassword extends StatelessWidget {
  final _con = Get.find<ForgotPasswordController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              16.heightBox,
              EkuaboString.forgotPassword
                  .replaceAll('?', '')
                  .text
                  .fontWeight(FontWeight.w500)
                  .color(Colors.black)
                  .size(25)
                  .makeCentered(),
              30.heightBox,
              VxCard(Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: 40, maxHeight: 40),
                    child: TextFormField(
                      controller: _con.emailCtl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: EkuaboString.email,
                          labelStyle: const TextStyle(
                              fontFamily: EkuaboAsset.CERA_PRO_FONT,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: MyColor.secondColor),
                          prefixIcon: IconButton(
                              icon: Image.asset(
                                EkuaboAsset.ic_email,
                                width: 15.0,
                                height: 12.0,
                              ),
                              onPressed: null),
                          hintText: EkuaboString.email,
                          hintStyle: const TextStyle(
                              fontFamily: EkuaboAsset.CERA_PRO_FONT,
                              fontSize: 12,
                              fontWeight: FontWeight.w200),
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  width: 1, color: MyColor.mainColor))),
                    ),
                  ).pOnly(top: 20, left: 16, right: 16),
                  MaterialButton(
                    minWidth: 170,
                    onPressed: () => _con.callForgotPasswordApi(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: EkuaboString.submit
                        .toUpperCase()
                        .text
                        .color(MyColor.lightestGrey)
                        .make(),
                    color: MyColor.mainColor,
                    height: 45,
                  ).pOnly(top: 30, bottom: 30)
                ],
              ))
                  .elevation(5)
                  .color(const Color(0xffF5F5F5))
                  .shadowColor(const Color(0xff000029))
                  .makeCentered()
                  .cornerRadius(12)
                  .pOnly(top: Get.height * 0.15, left: 16, right: 16),
            ],
          ),
        ),
      ),
    );
  }
}
