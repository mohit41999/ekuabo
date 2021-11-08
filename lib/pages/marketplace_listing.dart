import 'dart:convert';

import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/market_place/marketplace_Details_model.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/pages/market_place.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class MarketPlaceListing extends StatefulWidget {
  // const MarketPlaceListing();
  @override
  State<MarketPlaceListing> createState() => _MarketPlaceListingState();
}

class _MarketPlaceListingState extends State<MarketPlaceListing> {
  final _homeController = Get.find<HomeController>();
  MarketplaceDetails marketplaceDetails;
  UserBean userbean;
  bool loading = true;

  Future<MarketplaceDetails> getmarketplacedetails() async {
    userbean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse(
            'https://eku-abo.com/api/marketplace/marketplace_details.php'),
        body: {
          'user_id': userbean.data.id,
          'token': '123456789',
          'marketplace_id': '${m_id}'
        });
    var Response = jsonDecode(response.body);

    print(Response);
    print(m_id.toString());

    print(userbean.data.id);
    return MarketplaceDetails.fromJson(Response);
  }

  @override
  void initState() {
    // TODO: implement initState

    getmarketplacedetails().then((value) {
      setState(() {
        marketplaceDetails = value;
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(context),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  EkuaboString.marketPlaceListing.text.heightTight
                      .size(18)
                      .medium
                      .make()
                      .pOnly(left: 10),
                  UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
                  VxCard(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VxBox(
                            child: Image.network(
                              marketplaceDetails.data[0].image[0].image,
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 134,
                              fit: BoxFit.cover,
                            ),
                          ).bottomLeftRounded(value: 10).make().pOnly(left: 20),
                          30.widthBox,
                          Icon(
                            Icons.more_vert_outlined,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      16.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "${marketplaceDetails.data[0].title}"
                              .text
                              .size(16)
                              .medium
                              .make()
                              .pOnly(left: 10),
                          16.heightBox,
                          Row(
                            children: [
                              "${marketplaceDetails.data[0].categoryName}",
                              "${marketplaceDetails.data[0].subCategoryName}"
                            ].map((e) {
                              return VxBox(
                                      child: e.text.white
                                          .size(10)
                                          .medium
                                          .makeCentered()
                                          .pOnly(
                                              top: 3,
                                              bottom: 3,
                                              left: 5,
                                              right: 5))
                                  .color(MyColor.blackColor.withOpacity(0.4))
                                  .withRounded(value: 10)
                                  .height(20)
                                  .withConstraints(
                                      const BoxConstraints(minWidth: 40))
                                  .make()
                                  .pOnly(left: 10);
                            }).toList(),
                          ),
                        ],
                      ).pOnly(right: 10),
                      16.heightBox,
                      marketplaceDetails.data[0].listingDescription.text
                          .size(12)
                          .medium
                          .align(TextAlign.justify)
                          .make()
                          .pOnly(left: 10, right: 10),
                      VxBox(
                              child: Row(
                        children: [
                          20.widthBox,
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                marketplaceDetails.data[0].userDetails.profile,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                          20.widthBox,
                          "${marketplaceDetails.data[0].userDetails.username}"
                              .text
                              .size(16)
                              .medium
                              .color(MyColor.lightBlueColor)
                              .make()
                        ],
                      ).p(5))
                          .withDecoration(BoxDecoration(
                              border: Border.all(
                                  color: MyColor.lightBlack, width: 0.3),
                              color: MyColor.lightGrey,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12))))
                          .width(double.infinity)
                          .height(100)
                          .make()
                          .pOnly(left: 10, right: 10, top: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          '${marketplaceDetails.data[0].neigborhood}'
                              .text
                              .medium
                              .size(16)
                              .make(),
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                "\$"
                                    .text
                                    .medium
                                    .size(16)
                                    .color(MyColor.lightestGrey)
                                    .make(),
                                3.widthBox,
                                "${marketplaceDetails.data[0].price}"
                                    .text
                                    .underline
                                    .medium
                                    .size(16)
                                    .white
                                    .make(),
                              ],
                            ),
                            minWidth: 100,
                            color: MyColor.mainColor,
                            height: 30,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12))),
                          )
                        ],
                      ).pOnly(left: 10, right: 10),
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_location,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          "${marketplaceDetails.data[0].location}"
                              .text
                              .medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 10),
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
                          "${marketplaceDetails.data[0].contactNumber}"
                              .text
                              .medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 10),
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
                          "${marketplaceDetails.data[0].email}"
                              .text
                              .medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 10),
                      10.heightBox,
                      Row(
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_calender,
                            color: MyColor.mainColor,
                            width: 13,
                            height: 16,
                          ),
                          10.widthBox,
                          "${marketplaceDetails.data[0].created}"
                              .substring(0, 10)
                              .text
                              .medium
                              .size(12)
                              .make(),
                        ],
                      ).pOnly(left: 10),
                    ],
                  ).p(5))
                      .elevation(5)
                      .withRounded(value: 7)
                      .make()
                      .p(10),
                  10.heightBox,
                  EkuaboString.servicesOffered.text.heightTight
                      .size(18)
                      .medium
                      .make()
                      .pOnly(left: 10),
                  UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
                  Container(
                    constraints: const BoxConstraints(
                        maxHeight: 350, maxWidth: double.infinity),
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return VxCard(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            16.heightBox,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VxBox(
                                        child: Image.asset(
                                  index == 0
                                      ? EkuaboAsset.car1
                                      : EkuaboAsset.car2,
                                  fit: BoxFit.cover,
                                  width: 134,
                                  height: 134,
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
                            "Cars".text.size(16).medium.make().pOnly(left: 10),
                            16.heightBox,
                            Row(
                              children: ["mechanic", "car"].map((e) {
                                return VxBox(
                                        child: e.text.white
                                            .size(10)
                                            .medium
                                            .makeCentered()
                                            .pOnly(
                                                top: 3,
                                                bottom: 3,
                                                left: 5,
                                                right: 5))
                                    .color(MyColor.blackColor.withOpacity(0.4))
                                    .withRounded(value: 10)
                                    .height(20)
                                    .withConstraints(
                                        const BoxConstraints(minWidth: 40))
                                    .make()
                                    .pOnly(left: 10);
                              }).toList(),
                            ),
                            16.heightBox,
                            EkuaboString.public.text
                                .color(MyColor.mainColor)
                                .size(16)
                                .medium
                                .make()
                                .pOnly(left: 10),
                            10.heightBox,
                            Row(
                              children: [
                                Image.asset(
                                  EkuaboAsset.ic_location,
                                  color: MyColor.mainColor,
                                  width: 16,
                                  height: 16,
                                ),
                                10.widthBox,
                                "Lorem Ipsum".text.size(12).medium.make(),
                                16.heightBox,
                              ],
                            ).pOnly(left: 10),
                            10.heightBox,
                            Row(
                              children: [
                                "100"
                                    .text
                                    .size(20)
                                    .medium
                                    .underline
                                    .color(MyColor.mainColor)
                                    .make(),
                                3.widthBox,
                                "\$"
                                    .text
                                    .size(20)
                                    .medium
                                    .color(MyColor.mainColor)
                                    .make()
                              ],
                            ).pOnly(
                                left: MediaQuery.of(context).size.width * 0.18,
                                bottom: 10)
                          ],
                        ))
                            .elevation(5)
                            .withRounded(value: 7)
                            .white
                            .make()
                            .onTap(() => _homeController.bottomNavPop())
                            .pOnly(top: 10, left: 10, right: 10);
                      },
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                    ),
                  ),
                  Image.asset(
                    EkuaboAsset.bottom_image,
                    width: double.infinity,
                  )
                ],
              ),
            ),
    );
  }
}
