import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/more_controller.dart';

import 'package:ekuabo/pages/home_page.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class More extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final _con = Get.find<MoreController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(),
      body: GetBuilder<MoreController>(
        builder: (_) => _con.userProfileDataBean != null
            ? SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  IconButton(
                      onPressed: () => _homeController.bottomNavPop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: MyColor.mainColor,
                      )),
                  VxCard(Column(
                    children: [
                      16.heightBox,
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: CachedNetworkImage(
                            imageUrl:
                                _con.userProfileDataBean.profile.profilePicture,
                            placeholder: (_, __) => CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      16.heightBox,
                      _con.userProfileDataBean.profile.name.text
                          .size(16)
                          .medium
                          .heightTight
                          .make()
                          .pOnly(right: 50),
                      2.heightBox,
                      UnderlineWidget().getUnderlineWidget().pOnly(right: 50),
                      16.heightBox,
                      VxBox(
                              child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: MyColor.mainColor,
                          ),
                          10.widthBox,
                          Expanded(
                            child: _con
                                .userProfileDataBean.profile.createdDate.text
                                .color(MyColor.lightBlueColor)
                                .size(10)
                                .light
                                .make(),
                          )
                        ],
                      ))
                          .withRounded(value: 16)
                          .width(120)
                          .height(30)
                          .white
                          .make(),
                      16.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_location,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.profile.address.text.medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_call,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.profile.mobileNo.text.medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_call,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          "${_con.userProfileDataBean.profile.homeContactNo}(Home)"
                              .text
                              .medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_call,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          "${_con.userProfileDataBean.profile.mobileContactNo}(Mobile)"
                              .text
                              .medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_email,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.profile.publicEmailId.text
                              .medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_home2,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.profile.website.text.medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      MaterialButton(
                        onPressed: () {
                          _homeController.navigationQueue.addLast(4);
                          _homeController.bottomNavigatorKey.currentState
                              .pushNamed(EkuaboRoute.editProfile);
                        },
                        color: MyColor.mainColor,
                        height: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            10.widthBox,
                            EkuaboString.edit_profile.text
                                .size(10)
                                .medium
                                .white
                                .make()
                          ],
                        ),
                      ).w(120),
                    ],
                  ))
                      .elevation(5)
                      .color(const Color(0xffF5F5F5))
                      .make()
                      .w(double.infinity)
                      .cornerRadius(12)
                      .p(10),
                  50.heightBox,
                  EkuaboString.marketPlaceInfo.text
                      .size(14)
                      .medium
                      .make()
                      .pOnly(left: 16),
                  UnderlineWidget().getUnderlineWidget().pOnly(left: 16),
                  16.heightBox,
                  VxCard(Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: _con.userProfileDataBean.marketplaceInfo
                                .marketImage ??
                            '',
                        placeholder: (_, __) => SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                      /*Image.asset(EkuaboAsset.demo_blog1,
                    width: 100,
                    height: 100,
                  ),*/
                      ,
                      16.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _con.userProfileDataBean.marketplaceInfo.marketTitle
                              .text
                              .size(16)
                              .medium
                              .color(MyColor.lightBlueColor)
                              .make(),
                          5.heightBox,
                          _con.userProfileDataBean.marketplaceInfo.message.text
                              .light
                              .make(),
                        ],
                      )
                    ],
                  ).p(10))
                      .elevation(7)
                      .withRounded(value: 10)
                      .make()
                      .onTap(() {
                    _homeController.navigationQueue.addLast(4);
                    _homeController.bottomNavigatorKey.currentState
                        .pushNamed(EkuaboRoute.editMarketPlaceInfo);
                  }).pOnly(left: 16, right: 16),
                  16.heightBox,
                  EkuaboString.about.text
                      .size(14)
                      .medium
                      .make()
                      .pOnly(left: 16),
                  UnderlineWidget().getUnderlineWidget().pOnly(left: 16),
                  16.heightBox,
                  VxCard(Column(
                    children: [
                      16.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_home2,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.about.homeTown.text.medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_location,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.about.occupation.text.medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_location,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.about.funFacts.text.medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_location,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          _con.userProfileDataBean.about.interests.text.medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 20),
                      10.heightBox,
                    ],
                  ))
                      .elevation(7)
                      .withRounded(value: 10)
                      .make()
                      .pOnly(left: 16, right: 16),
                  Image.asset(
                    EkuaboAsset.bottom_image,
                    width: double.infinity,
                  )
                ],
              ))
            : Center(
                child: CircularProgressIndicator(),
              ),
        initState: (_) {
          Get.parameters = {EkuaboRoute.more: ""};
          _con.getUserProfile();
        },
      ),
    );
  }
}
