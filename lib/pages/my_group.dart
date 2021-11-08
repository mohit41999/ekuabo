import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/my_group_controller.dart';
import 'package:ekuabo/pages/userShopMarketListing.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:ekuabo/widgets/lifecycle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'group_details.dart';

class MyGroups extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final _con = Get.find<MyGroupController>();
  @override
  Widget build(BuildContext context) {
    Get.parameters = {EkuaboRoute.myGroup: ""};
    _con.getMyGroups();
    _con.getMyJoiningGroup();
    return GetBuilder<MyGroupController>(
        builder: (_) => Scaffold(
              backgroundColor: Colors.white,
              appBar: EcuaboAppBar().getAppBar(context),
              body: SingleChildScrollView(
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
                            EkuaboString.myGroup.text.heightTight
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
                                .pushNamed(EkuaboRoute.postNewGroup);
                          }),
                          shadows: const [
                            BoxShadow(
                                color: MyColor.inactiveColor, blurRadius: 10)
                          ],
                        ).wh(40, 40),
                      ],
                    ).pOnly(left: 10, right: 10),
                    16.heightBox,
                    _con.myGroups.isEmpty
                        ? EkuaboString.no_results_found.text
                            .color(MyColor.blackColor)
                            .size(10)
                            .make()
                            .pOnly(left: 10)
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _con.myGroups.length,
                            itemBuilder: (ctx, index) {
                              return VxCard(Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: _con.myGroups[index].image ?? '',
                                    placeholder: (ctx, _) => const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.fill,
                                    errorWidget: (_, __, ___) => Image.asset(
                                      EkuaboAsset.no_image,
                                      width: 150,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  /*  Image.asset(EkuaboAsset.demo_blog1,
                            width: 150,
                            height: 200,
                            fit: BoxFit.fill,
                          ),*/
                                  10.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.heightBox,
                                      _con.myGroups[index].groupName.text
                                          .size(16)
                                          .medium
                                          .make(),
                                      10.heightBox,
                                      Flexible(
                                        child: _con
                                            .myGroups[index].groupDesc.text
                                            .maxLines(3)
                                            .ellipsis
                                            .size(12)
                                            .medium
                                            .align(TextAlign.justify)
                                            .color(MyColor.blackColor
                                                .withOpacity(0.6))
                                            .make()
                                            .pOnly(right: 20),
                                      ),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          Image.asset(
                                            EkuaboAsset.ic_calender,
                                            width: 16,
                                            height: 16,
                                          ),
                                          10.widthBox,
                                          _con.myGroups[index].createdDate.text
                                              .size(12)
                                              .medium
                                              .color(MyColor.blackColor
                                                  .withOpacity(0.8))
                                              .make()
                                        ],
                                      ),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          Image.asset(
                                            EkuaboAsset.ic_people,
                                            width: 16,
                                            height: 16,
                                          ),
                                          10.widthBox,
                                          "${_con.myGroups[index].totalMember} Members"
                                              .text
                                              .size(12)
                                              .medium
                                              .color(MyColor.blackColor
                                                  .withOpacity(0.8))
                                              .make(),
                                          10.widthBox,
                                          Image.asset(
                                            EkuaboAsset.ic_bookmark,
                                            width: 16,
                                            height: 16,
                                          ),
                                          10.widthBox,
                                          "${_con.myGroups[index].totalFeed} Posts"
                                              .text
                                              .size(12)
                                              .medium
                                              .color(MyColor.blackColor
                                                  .withOpacity(0.8))
                                              .make()
                                        ],
                                      ),
                                      MaterialButton(
                                        onPressed: () =>
                                            _con.deleteGroup(context, index),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                                color: MyColor.mainColor,
                                                width: 0.8)),
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              size: 16,
                                              color: MyColor.mainColor,
                                            ),
                                            10.widthBox,
                                            EkuaboString.delete_group.text
                                                .size(10)
                                                .medium
                                                .color(MyColor.mainColor)
                                                .make()
                                          ],
                                        ),
                                      ).pOnly(left: 20, top: 10)
                                    ],
                                  )
                                ],
                              ))
                                  .elevation(7)
                                  .color(MyColor.lightGrey)
                                  .withRounded(value: 16)
                                  .make()
                                  .wh(double.infinity, 200)
                                  .pOnly(top: 10, left: 10, right: 10)
                                  .onTap(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupDetails(
                                              group_id:
                                                  _con.myGroups[index].groupId,
                                              created_date: _con
                                                  .myGroups[index].createdDate,
                                              image_url:
                                                  _con.myGroups[index].image,
                                              grp_name: _con
                                                  .myGroups[index].groupName,
                                              members: _con
                                                  .myGroups[index].totalMember,
                                            )));
                              });
                            }),
                    16.heightBox,
                    EkuaboString.my_joining_groups.text.medium
                        .size(16)
                        .heightTight
                        .make()
                        .pOnly(left: 10),
                    UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
                    16.heightBox,
                    _con.myJoiningGroups.isEmpty
                        ? EkuaboString.no_results_found.text
                            .color(MyColor.blackColor)
                            .size(10)
                            .make()
                            .pOnly(left: 10)
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _con.myJoiningGroups.length,
                            itemBuilder: (ctx, index) {
                              return VxCard(Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        _con.myJoiningGroups[index].image ?? '',
                                    placeholder: (ctx, _) => const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.fill,
                                    errorWidget: (_, __, ___) => Image.asset(
                                      EkuaboAsset.no_image,
                                      width: 150,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  /* Image.asset(EkuaboAsset.demo_blog1,
                            width: 150,
                            height: 200,
                            fit: BoxFit.fill,
                          ),*/
                                  10.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.heightBox,
                                      _con.myJoiningGroups[index].groupName.text
                                          .size(16)
                                          .medium
                                          .make(),
                                      10.heightBox,
                                      Flexible(
                                        child: _con.myJoiningGroups[index]
                                            .groupDesc.text
                                            .maxLines(3)
                                            .ellipsis
                                            .size(12)
                                            .medium
                                            .align(TextAlign.justify)
                                            .color(MyColor.blackColor
                                                .withOpacity(0.6))
                                            .make()
                                            .pOnly(right: 20),
                                      ),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          Image.asset(
                                            EkuaboAsset.ic_calender,
                                            width: 16,
                                            height: 16,
                                          ),
                                          10.widthBox,
                                          _con.myJoiningGroups[index]
                                              .createdDate.text
                                              .size(12)
                                              .medium
                                              .color(MyColor.blackColor
                                                  .withOpacity(0.8))
                                              .make()
                                        ],
                                      ),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          Image.asset(
                                            EkuaboAsset.ic_people,
                                            width: 16,
                                            height: 16,
                                          ),
                                          10.widthBox,
                                          "${_con.myJoiningGroups[index].totalMember} Members"
                                              .text
                                              .size(12)
                                              .medium
                                              .color(MyColor.blackColor
                                                  .withOpacity(0.8))
                                              .make(),
                                          10.widthBox,
                                          Image.asset(
                                            EkuaboAsset.ic_bookmark,
                                            width: 16,
                                            height: 16,
                                          ),
                                          10.widthBox,
                                          "${_con.myJoiningGroups[index].totalFeed} Posts"
                                              .text
                                              .size(12)
                                              .medium
                                              .color(MyColor.blackColor
                                                  .withOpacity(0.8))
                                              .make()
                                        ],
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          _con
                                              .callLeaveMyGroupApi(
                                                  context,
                                                  _con.myJoiningGroups[index]
                                                      .groupId)
                                              .then((value) {
                                            _con.myJoiningGroups
                                                .removeAt(index);
                                            _con.getMyJoiningGroup();
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                                color: MyColor.mainColor,
                                                width: 0.8)),
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              size: 16,
                                              color: MyColor.mainColor,
                                            ),
                                            10.widthBox,
                                            EkuaboString.leave_group.text
                                                .size(10)
                                                .medium
                                                .color(MyColor.mainColor)
                                                .make()
                                          ],
                                        ),
                                      ).pOnly(left: 20, top: 10)
                                    ],
                                  )
                                ],
                              ))
                                  .elevation(7)
                                  .color(MyColor.lightGrey)
                                  .withRounded(value: 16)
                                  .make()
                                  .wh(double.infinity, 200)
                                  .onTap(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupDetails(
                                            group_id: _con
                                                .myJoiningGroups[index].groupId,
                                            created_date: _con
                                                .myJoiningGroups[index]
                                                .createdDate,
                                            image_url: _con
                                                .myJoiningGroups[index].image,
                                            grp_name: _con
                                                .myJoiningGroups[index]
                                                .groupName)));
                              }).pOnly(top: 10, left: 10, right: 10);
                            }),
                    Image.asset(
                      EkuaboAsset.bottom_image,
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ));
  }
}
