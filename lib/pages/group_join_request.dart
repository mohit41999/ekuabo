import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/group_invitation_controller.dart';
import 'package:ekuabo/controller/group_join_request_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class GroupJoinRequest extends StatefulWidget {
  @override
  State<GroupJoinRequest> createState() => _GroupJoinRequestState();
}

class _GroupJoinRequestState extends State<GroupJoinRequest> {
  final _con = Get.find<GroupJoinRequestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(context),
      body: GetBuilder<GroupJoinRequestController>(
        builder: (_) => Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.heightBox,
                EkuaboString.group_join_request.text.heightTight
                    .size(16)
                    .medium
                    .make()
                    .pOnly(left: 10),
                UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
                16.heightBox,
                _con.groupJoinRequests.isEmpty
                    ? EkuaboString.group_join_request_not_found.text
                        .color(MyColor.blackColor)
                        .size(10)
                        .make()
                        .pOnly(left: 10)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: _con.groupJoinRequests.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColor.lightGrey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    10.heightBox,
                                    _con.groupJoinRequests[index].groupName.text
                                        .size(20)
                                        .medium
                                        .make(),
                                    10.heightBox,
                                    Container(
                                      child: _con.groupJoinRequests[index]
                                          .requested_username.text
                                          .maxLines(3)
                                          .ellipsis
                                          .size(16)
                                          .medium
                                          .align(TextAlign.justify)
                                          .color(MyColor.blackColor
                                              .withOpacity(0.6))
                                          .make()
                                          .pOnly(right: 20),
                                    ),
                                    10.heightBox,
                                    Container(
                                      child: (' wants to join Group')
                                          .text
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _con.RejectGroupjoinRequest(_con
                                                  .groupJoinRequests[index]
                                                  .group_join_id);
                                            },
                                            child: Text('Reject')),
                                        ElevatedButton(
                                            onPressed: () {
                                              _con.AcceptGroupjoinRequest(_con
                                                  .groupJoinRequests[index]
                                                  .group_join_id);
                                            },
                                            child: Text('Accept'))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          //   VxCard(
                          //     Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         CachedNetworkImage(
                          //           imageUrl:
                          //           _con.groupJoinRequests[index].image ?? '',
                          //           placeholder: (ctx, _) =>
                          //           const SizedBox(
                          //             width: 20,
                          //             height: 20,
                          //             child: Center(
                          //               child:
                          //               CircularProgressIndicator(),
                          //             ),
                          //           ),
                          //           width: 150,
                          //           height: 200,
                          //           fit: BoxFit.fill,
                          //         ),
                          //         /* Image.asset(EkuaboAsset.demo_blog1,
                          //         width: 150,
                          //         height: 200,
                          //         fit: BoxFit.fill,
                          //       ),*/
                          //         10.widthBox,
                          //         Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             10.heightBox,
                          //             _con.groupJoinRequests[index].groupName
                          //                 .text
                          //                 .size(16)
                          //                 .medium
                          //                 .make(),
                          //             10.heightBox,
                          //             Flexible(
                          //               child: _con.groupJoinRequests[index].groupDesc
                          //                   .text
                          //                   .maxLines(3)
                          //                   .ellipsis
                          //                   .size(12)
                          //                   .medium
                          //                   .align(TextAlign.justify)
                          //                   .color(MyColor.blackColor.withOpacity(0.6))
                          //                   .make().pOnly(right: 20),
                          //             ),
                          //             10.heightBox,
                          //             Row(
                          //               children: [
                          //                 Image.asset(EkuaboAsset.ic_calender,
                          //                   width: 16,
                          //                   height: 16,
                          //                 ),
                          //                 10.widthBox,
                          //                 _con.groupJoinRequests[index].createdDate
                          //                     .text
                          //                     .size(12)
                          //                     .medium
                          //                     .color(MyColor.blackColor.withOpacity(0.8))
                          //                     .make()
                          //               ],
                          //             ),
                          //             10.heightBox,
                          //             Row(
                          //               children: [
                          //                 Image.asset(EkuaboAsset.ic_people,
                          //                   width: 16,
                          //                   height: 16,
                          //                 ),
                          //                 10.widthBox,
                          //                 "${_con.groupJoinRequests[index].totalMember} Members"
                          //                     .text
                          //                     .size(12)
                          //                     .medium
                          //                     .color(MyColor.blackColor.withOpacity(0.8))
                          //                     .make(),
                          //                 10.widthBox,
                          //                 Image.asset(EkuaboAsset.ic_bookmark,
                          //                   width: 16,
                          //                   height: 16,
                          //                 ),
                          //                 10.widthBox,
                          //                 "${_con.groupJoinRequests[index].totalFeed} Posts"
                          //                     .text
                          //                     .size(12)
                          //                     .medium
                          //                     .color(MyColor.blackColor.withOpacity(0.8))
                          //                     .make()
                          //               ],
                          //             ),
                          //             /*MaterialButton(onPressed: ()=>_con.callLeaveMyGroupApi(context,index),
                          //               shape: RoundedRectangleBorder(
                          //                   borderRadius: BorderRadius.circular(20),
                          //                   side: BorderSide(color: MyColor.mainColor,width: 0.8)
                          //               ),
                          //               color: Colors.white,
                          //               child: Row(
                          //                 children: [
                          //                   Icon(Icons.logout,size: 16,
                          //                     color: MyColor.mainColor,
                          //                   ),
                          //                   10.widthBox,
                          //                   EkuaboString.leave_group.text.size(10).medium.color(MyColor.mainColor).make()
                          //                 ],
                          //               ),
                          //             ).pOnly(left: 20,top: 10)*/
                          //           ],
                          //         )
                          //       ],
                          //     )
                          // )
                          //     .elevation(7)
                          //     .color(MyColor.lightGrey)
                          //     .withRounded(value: 16)
                          //     .make().wh(double.infinity, 200).pOnly(top: 10,left: 10,right: 10);
                        }),
              ],
            ),
            Image.asset(
              EkuaboAsset.bottom_image,
              width: double.infinity,
            ).objectBottomLeft()
          ],
        ),
        initState: (_) {
          Get.parameters = {EkuaboRoute.groupJoinRequest: ""};
          _con.getGroupJoinRequestList();
        },
      ),
    );
  }
}
