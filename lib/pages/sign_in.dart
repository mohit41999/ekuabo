import 'package:ekuabo/controller/sign_in_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';

class SignInScreen extends StatelessWidget {
  final _con = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.heightBox,
              EkuaboString.signIn.text.medium
                  .size(28)
                  .color(const Color(0xff333232))
                  .makeCentered(),
              30.heightBox,
              VxCard(Column(
                children: [
                  Form(
                      key: _con.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          16.heightBox,
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 40, maxHeight: 60),
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
                          ),
                          16.heightBox,
                          Obx(() => ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 60, minHeight: 40),
                                child: TextFormField(
                                  controller: _con.passwordCtl,
                                  keyboardType: TextInputType.text,
                                  obscureText: _con.hide_password.value,
                                  decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        icon: Image.asset(
                                          EkuaboAsset.ic_key,
                                          width: 15.0,
                                          height: 14.0,
                                        ),
                                        onPressed: null,
                                      ),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _con.hide_password.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 16,
                                            color: MyColor.blackColor
                                                .withOpacity(0.8),
                                          ),
                                          onPressed: () {
                                            _con.hide_password.value =
                                                !_con.hide_password.value;
                                          }),
                                      filled: true,
                                      labelText: EkuaboString.password,
                                      labelStyle: const TextStyle(
                                          fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: MyColor.secondColor),
                                      hintText: EkuaboString.password,
                                      hintStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200),
                                      errorStyle: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200),
                                      fillColor: Colors.white,
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: MyColor.mainColor))),
                                ),
                              )),
                          16.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              EkuaboString.forgotPassword.text
                                  .color(
                                      MyColor.lightBlueColor.withOpacity(0.8))
                                  .medium
                                  .make()
                                  .onTap(() => Get.toNamed(
                                      EkuaboRoute.forgotPasswordScreen)),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Obx(
                                        () => Checkbox(
                                            value: _con.rememberMe.value,
                                            onChanged: (value) {
                                              _con.rememberMe.value = value;
                                            }),
                                      )),
                                  EkuaboString.rememberMe.text
                                      .color(MyColor.lightBlueColor
                                          .withOpacity(0.8))
                                      .medium
                                      .make(),
                                ],
                              )
                            ],
                          ),
                          16.heightBox,
                        ],
                      )).p(15),
                  MaterialButton(
                    minWidth: 170,
                    onPressed: () => _con.callSignInApi(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: EkuaboString.submit
                        .toUpperCase()
                        .text
                        .color(MyColor.lightestGrey)
                        .make(),
                    color: MyColor.mainColor,
                    height: 45,
                  ).pOnly(bottom: 50)
                ],
              ))
                  .elevation(5)
                  .color(const Color(0xffF5F5F5))
                  .shadowColor(const Color(0xff000029))
                  .makeCentered()
                  .cornerRadius(12)
                  .p(10),
              16.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EkuaboString.notMemberYet.text.medium.size(11).make(),
                  10.widthBox,
                  EkuaboString.registerHere.text
                      .color(MyColor.mainColor)
                      .medium
                      .size(11)
                      .make()
                      .onTap(() => Get.toNamed(EkuaboRoute.signUpScreen)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
