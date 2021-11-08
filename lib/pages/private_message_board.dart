import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/private_msg_controller.dart';
import 'package:ekuabo/pages/users_list.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PrivateMessageBoard extends StatelessWidget {
  final _homeController = Get.find<HomeController>();
  final _con = Get.find<PrivateMessageBoardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EcuaboAppBar().getAppBar(context),
      body: GetBuilder<PrivateMessageBoardController>(
        builder: (_) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      EkuaboString.private_message_board.text.medium
                          .size(18)
                          .heightTight
                          .make()
                          .pOnly(left: 10),
                      UnderlineWidget().getUnderlineWidget().pOnly(left: 10),
                    ],
                  ),
                  VxCircle(
                    backgroundColor: MyColor.mainColor,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ).onFeedBackTap(() async {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UsersList()))
                          .then((value) => _con.getChatList());
                    }),
                    shadows: const [
                      BoxShadow(color: MyColor.inactiveColor, blurRadius: 10)
                    ],
                  ).wh(40, 40).pOnly(right: 10)
                ],
              ),
              16.heightBox,
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 400),
                child: VxCard(Column(
                  children: [
                    16.heightBox,
                    _con.chatList.isEmpty
                        ? EkuaboString.no_results_found.text
                            .color(MyColor.blackColor)
                            .size(10)
                            .makeCentered()
                            .pOnly(left: 10)
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) =>
                                    _con.deleteChat(index),
                                background: Icon(
                                  Icons.delete,
                                  color: MyColor.mainColor,
                                  size: 24,
                                ).pOnly(right: Get.width - 150),
                                secondaryBackground: VxBox().make(),
                                direction: DismissDirection.startToEnd,
                                child: VxBox(
                                        child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              _con.chatList[index].userImg ??
                                                  '',
                                          placeholder: (_, __) =>
                                              CircularProgressIndicator(),
                                        ),
                                      ),
                                    ).pOnly(left: 10),
                                    10.widthBox,
                                    Column(
                                      children: [
                                        10.heightBox,
                                        _con.chatList[index].username.text
                                            .size(12)
                                            .medium
                                            .color(MyColor.lightBlueColor)
                                            .make(),
                                        10.heightBox,
                                        _con.chatList[index].userMsg.text
                                            .size(10)
                                            .medium
                                            .make()
                                      ],
                                    )
                                  ],
                                ))
                                    .border(
                                        color: MyColor.lightGrey, width: 0.6)
                                    .withRounded(value: 10)
                                    .white
                                    .width(double.infinity)
                                    .height(70)
                                    .make()
                                    .pOnly(top: 16)
                                    .onTap(() {
                                  _homeController.navigationQueue.addLast(4);
                                  _homeController
                                      .bottomNavigatorKey.currentState
                                      .pushNamed(EkuaboRoute.chatConversation,
                                          arguments: _con.chatList[index]);
                                }),
                              );
                            },
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: _con.chatList.length,
                          ),
                    16.heightBox,
                    _con.chatList.isNotEmpty
                        ? Column(
                            children: [
                              Image.asset(
                                EkuaboAsset.ic_swipe_to_delete,
                                height: 16,
                              ),
                              10.heightBox,
                              EkuaboString.swipe_to_delete_conversation.text
                                  .size(10)
                                  .medium
                                  .color(MyColor.blackColor.withOpacity(0.5))
                                  .make()
                            ],
                          )
                        : SizedBox()
                  ],
                ).pOnly(left: 16, right: 16, bottom: 16))
                    .elevation(7)
                    .withRounded(value: 10)
                    .color(MyColor.lightGrey)
                    .make()
                    .w(double.infinity)
                    .pOnly(left: 16, right: 16),
              ),
              Image.asset(
                EkuaboAsset.bottom_image,
                width: double.infinity,
              )
            ],
          ),
        ),
        initState: (_) {
          Get.parameters = {EkuaboRoute.privateMessageBoard: ""};
          _con.getChatList();
        },
      ),
    );
  }
}
