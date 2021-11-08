import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/my_banner_ad_controller.dart';

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

class MyPostedBannerAd extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final _con = Get.find<MyPostedBannerAdController>();

  @override
  Widget build(BuildContext context) {
    Get.parameters = {EkuaboRoute.myPostBannerAd: ""};
    _con.getBannerList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(context),
      body: GetBuilder<MyPostedBannerAdController>(
        builder: (_) => Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              EkuaboAsset.bottom_image,
              width: double.infinity,
            ).objectBottomLeft(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EkuaboString.myPostedBannerAd.text.heightTight
                              .size(16)
                              .medium
                              .make(),
                          UnderlineWidget().getUnderlineWidget(),
                        ],
                      ),
                      VxCircle(
                        backgroundColor: MyColor.mainColor,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ).onFeedBackTap(() {
                          _homeController.navigationQueue.addLast(4);
                          _homeController.bottomNavigatorKey.currentState
                              .pushNamed(EkuaboRoute.createMyAd);
                        }),
                        shadows: const [
                          BoxShadow(
                              color: MyColor.inactiveColor, blurRadius: 10)
                        ],
                      ).wh(40, 40),
                    ],
                  ).pOnly(left: 10, right: 10),
                  16.heightBox,
                  _con.bannerList.isEmpty
                      ? EkuaboString.no_results_found.text
                          .color(MyColor.blackColor)
                          .size(10)
                          .make()
                          .pOnly(left: 10)
                      : Container(
                          constraints: const BoxConstraints(
                              maxHeight: 350, maxWidth: double.infinity),
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              var banner = _con.bannerList[index];
                              return VxCard(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  16.heightBox,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      VxBox(
                                              child: Hero(
                                        tag: "Blog",
                                        child: CachedNetworkImage(
                                          imageUrl: banner.image ?? '',
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (_, __, ___) =>
                                              Image.asset(
                                            EkuaboAsset.no_image,
                                            width: 150,
                                            height: 200,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ))
                                          .width(134)
                                          .height(134)
                                          .bottomLeftRounded(value: 12)
                                          .makeCentered()
                                          .pOnly(left: 20),
                                      10.widthBox,
                                      const Icon(
                                        Icons.more_vert,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                  16.heightBox,
                                  VxBox(
                                          child: Center(
                                    child: banner.isApproved == 'n'
                                        ? EkuaboString.approved.text
                                            .color(Colors.grey)
                                            .medium
                                            .size(14)
                                            .make()
                                        : EkuaboString.pending.text
                                            .color(Colors.grey)
                                            .medium
                                            .size(14)
                                            .make(),
                                  ))
                                      .withRounded(value: 10)
                                      .height(30)
                                      .border(color: Colors.grey, width: 1)
                                      .make()
                                      .pOnly(left: 10, right: 10),
                                  20.heightBox,
                                  "Public"
                                      .text
                                      .color(MyColor.mainColor)
                                      .medium
                                      .size(16)
                                      .make()
                                      .pOnly(left: 16),
                                  VxBox(
                                          child: banner.slotName.text.medium
                                              .size(14)
                                              .color(MyColor.mainColor)
                                              .makeCentered()
                                              .p(5))
                                      .withRounded(value: 10)
                                      .border(
                                          color: MyColor.mainColor, width: 0.4)
                                      .width(double.infinity)
                                      .height(30)
                                      .make()
                                      .pOnly(left: 16, right: 16, top: 10),
                                  "${banner.defaultCurrency}${banner.price}"
                                      .text
                                      .medium
                                      .underline
                                      .size(18)
                                      .color(MyColor.mainColor)
                                      .make()
                                      .objectCenter()
                                      .pOnly(top: 10),
                                ],
                              ).backgroundColor(Colors.white))
                                  .elevation(5)
                                  .withRounded(value: 7)
                                  .white
                                  .make()
                                  .w(200)
                                  .onTap(() {})
                                  .pOnly(top: 10, left: 10, right: 10);
                            },
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _con.bannerList.length,
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
        initState: (_) {},
      ),
    );
  }
}
