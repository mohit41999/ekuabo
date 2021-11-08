import 'package:ekuabo/controller/setting_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:ekuabo/widgets/base_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Setting extends StatelessWidget {
  final _con = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EkuaboString.setting.text.medium
                  .size(18)
                  .heightTight
                  .make()
                  .pOnly(left: 10),
              UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
              16.heightBox,
              VxCard(Form(
                child: Column(
                  children: [
                    16.heightBox,
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 40),
                      child: TextFormField(
                        controller: _con.oldPasswordCtl,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                EkuaboAsset.ic_key,
                                width: 15.0,
                                height: 14.0,
                              ),
                              onPressed: null,
                            ),
                            /* suffixIcon: IconButton(
                                icon: Icon(_homeController.settingModel.old_password?Icons.visibility_off:Icons.visibility,size: 16,
                                  color: MyColor.blackColor.withOpacity(0.8),
                                ),
                                onPressed: () {
                                  var settingModel=_homeController.settingModel;
                                  settingModel.old_password=!settingModel.old_password;
                                  ChangeSettingModel(
                                      settingModel: settingModel);
                                }
                            ),*/

                            filled: true,
                            labelText: EkuaboString.enter_old_password,
                            labelStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.secondColor),
                            hintText: EkuaboString.enter_old_password,
                            hintStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w200),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.mainColor))),
                      ),
                    ),
                    16.heightBox,
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 40),
                      child: TextFormField(
                        controller: _con.newPasswordCtl,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        // obscureText: _homeController.settingModel.new_password,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                EkuaboAsset.ic_key,
                                width: 15.0,
                                height: 14.0,
                              ),
                              onPressed: null,
                            ),
                            /*suffixIcon: IconButton(
                                icon: Icon(_homeController.loginModel.hide_password?Icons.visibility_off:Icons.visibility,size: 16,
                                  color: MyColor.blackColor.withOpacity(0.8),
                                ),
                                onPressed: () {
                                  var settingModel=_homeController.settingModel;
                                  settingModel.new_password=!settingModel.new_password;
                                  ChangeSettingModel(
                                      settingModel:
                                      settingModel);
                                }
                            ),*/

                            filled: true,
                            labelText: EkuaboString.enter_new_passowrd,
                            labelStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.secondColor),
                            hintText: EkuaboString.enter_new_passowrd,
                            hintStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w200),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.mainColor))),
                      ),
                    ),
                    16.heightBox,
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 40),
                      child: TextFormField(
                        controller: _con.cPasswordCtl,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        // obscureText: _homeController.settingModel.confirm_password,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Image.asset(
                                EkuaboAsset.ic_key,
                                width: 15.0,
                                height: 14.0,
                              ),
                              onPressed: null,
                            ),
                            /* suffixIcon: IconButton(
                                icon: Icon(_homeController.settingModel.confirm_password?Icons.visibility_off:Icons.visibility,size: 16,
                                  color: MyColor.blackColor.withOpacity(0.8),
                                ),
                                onPressed: () {
                                  var settingModel=_homeController.settingModel;
                                  settingModel.confirm_password=!settingModel.confirm_password;
                                  ChangeSettingModel(
                                      settingModel:
                                      settingModel);
                                }
                            ),*/

                            filled: true,
                            labelText: EkuaboString.confirm_password,
                            labelStyle: const TextStyle(
                                fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                                color: MyColor.secondColor),
                            hintText: EkuaboString.confirm_password,
                            hintStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w200),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide(
                                    width: 1, color: MyColor.mainColor))),
                      ),
                    ),
                    16.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        20.widthBox,
                        EkuaboString.cancel
                            .toUpperCase()
                            .text
                            .medium
                            .size(14)
                            .color(MyColor.mainColor)
                            .make(),
                        MaterialButton(
                          minWidth: 170,
                          onPressed: () => _con.changePassword(context),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: EkuaboString.submit
                              .toUpperCase()
                              .text
                              .color(MyColor.lightestGrey)
                              .make(),
                          color: MyColor.mainColor,
                          height: 45,
                        )
                      ],
                    ).pOnly(bottom: 20)
                  ],
                ).pOnly(left: 20, right: 20),
              ))
                  .elevation(7)
                  .withRounded(value: 10)
                  .color(MyColor.lightGrey)
                  .make()
                  .pOnly(left: 16, right: 16),
              16.heightBox,
              VxCard(Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: MyColor.mainColor,
                    size: 24,
                  ),
                  16.widthBox,
                  EkuaboString.logout.text.medium
                      .color(MyColor.mainColor)
                      .size(16)
                      .make()
                ],
              ).p(10))
                  .elevation(7)
                  .withRounded(value: 10)
                  .color(MyColor.lightGrey)
                  .make()
                  .onFeedBackTap(() => _showLogoutDialog(context))
                  .pOnly(left: 16, right: 16),
              50.heightBox,
              Image.asset(
                EkuaboAsset.bottom_image,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
      initState: (_) {
        Get.parameters = {EkuaboRoute.setting: ""};
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    var baseDialog = BaseAlertDialog(
        title: EkuaboString.logout,
        content: EkuaboString.confirm_logout_action,
        yesOnPressed: () {
          PrefManager.destroySession();
          Get.offNamedUntil(EkuaboRoute.signInScreen, (route) => false);
        },
        noOnPressed: () {
          Get.back();
        },
        yes: EkuaboString.ok,
        no: EkuaboString.cancel);
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }
}
