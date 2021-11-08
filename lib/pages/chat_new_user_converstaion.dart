import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/chat_conversation_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatNewUserConversation extends StatefulWidget {
  final String chatId;
  final String username;

  const ChatNewUserConversation({Key key, this.chatId, this.username})
      : super(key: key);
  @override
  _ChatNewUserConversationState createState() =>
      _ChatNewUserConversationState();
}

class _ChatNewUserConversationState extends State<ChatNewUserConversation> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<ChatConversationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatConversationController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(context),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              10.heightBox,
              Row(
                children: [
                  IconButton(
                      onPressed: () => _homeController.bottomNavPop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: MyColor.mainColor,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "${EkuaboString.conversation_with} ${widget.username}"
                          .text
                          .medium
                          .heightTight
                          .size(18)
                          .make(),
                      UnderlineWidget().getUnderlineWidget(),
                    ],
                  )
                ],
              ),
              16.heightBox,
              VxCard(Column(
                children: [
                  VxBox(
                          child: SingleChildScrollView(
                    reverse: true,
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return _con.chatList[index].toUserId != widget.chatId
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      VxBox(
                                              child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: CachedNetworkImage(
                                                imageUrl: _con.chatList[index]
                                                        .profileImg ??
                                                    '',
                                                placeholder: (_, __) =>
                                                    CircularProgressIndicator(),
                                                fit: BoxFit.fill,
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          10.widthBox,
                                          _con.chatList[index].message.text
                                              .maxLines(1)
                                              .ellipsis
                                              .size(14)
                                              .medium
                                              .makeCentered()
                                              .pOnly(right: 10),
                                        ],
                                      ))
                                          .border(
                                              color: MyColor.mainColor,
                                              width: 0.6)
                                          .withRounded(value: 7)
                                          .height(30)
                                          .make()
                                          .pOnly(left: 10),
                                      10.widthBox,
                                      _con.chatList[index].time.text
                                          .size(10)
                                          .medium
                                          .color(MyColor.blackColor
                                              .withOpacity(0.5))
                                          .make()
                                          .pOnly(top: 16)
                                    ],
                                  )
                                ],
                              ).pOnly(top: 10, left: 10, right: 10)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _con.chatList[index].time.text
                                      .size(10)
                                      .medium
                                      .color(
                                          MyColor.blackColor.withOpacity(0.5))
                                      .make()
                                      .pOnly(top: 10, right: 16),
                                  Row(
                                    children: [
                                      VxBox(
                                              child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _con.chatList[index].message.text
                                              .maxLines(1)
                                              .ellipsis
                                              .size(14)
                                              .medium
                                              .makeCentered()
                                              .pOnly(left: 10),
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: CachedNetworkImage(
                                                imageUrl: _con.chatList[index]
                                                        .profileImg ??
                                                    '',
                                                placeholder: (_, __) =>
                                                    CircularProgressIndicator(),
                                                fit: BoxFit.cover,
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ).pOnly(left: 20),
                                        ],
                                      ))
                                          .border(
                                              color: MyColor.mainColor,
                                              width: 0.6)
                                          .withRounded(value: 7)
                                          .height(30)
                                          .make()
                                          .pOnly(left: 10),
                                    ],
                                  )
                                ],
                              ).pOnly(top: 10, left: 10, right: 10);
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _con.chatList.length,
                    ),
                  ))
                      .border(color: MyColor.lightGrey, width: 0.6)
                      .height(MediaQuery.of(context).size.height / 2)
                      .white
                      .withRounded(value: 10)
                      .width(double.infinity)
                      .make()
                      .p(16),
                  16.heightBox,
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 24,
                            color: Colors.grey,
                          )),
                      Expanded(
                          flex: 3,
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: 10, maxHeight: 40),
                            child: TextFormField(
                              controller: _con.msgCtl,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  filled: true,
                                  labelText: EkuaboString.comment,
                                  labelStyle: TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: MyColor.secondColor),
                                  hintText: EkuaboString.enter_new_comment,
                                  hintStyle: TextStyle(
                                      fontFamily: EkuaboAsset.CERA_PRO_FONT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(
                                          width: 1, color: MyColor.mainColor))),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Image.asset(
                            EkuaboAsset.ic_send2,
                            width: 16,
                            height: 16,
                          ).onTap(() => _con.sendMsg(widget.chatId)))
                    ],
                  ).pOnly(left: 10, right: 10, bottom: 20)
                ],
              ))
                  .elevation(7)
                  .withRounded(value: 10)
                  .color(MyColor.lightGrey)
                  .make()
                  .w(double.infinity)
                  .pOnly(left: 16, right: 16),
              Image.asset(
                EkuaboAsset.bottom_image,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
      initState: (_) => _con.getUserChatList(widget.chatId),
    );
  }
}
