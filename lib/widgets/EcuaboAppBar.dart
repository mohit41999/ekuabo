import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EcuaboAppBar {
  final _con = Get.find<HomeController>();
  final listOfMoreMenu = [
    "Private Message",
    "My Profile",
    "My Posted Banner Ad",
    "My Groups",
    "Received Group\n Invitation",
    "Received Group\n Join Request",
    "Transaction History",
    "Settings"
  ];
  void _showPopupMenu(BuildContext context) async {
    List<PopupMenuEntry<Object>> list = [];
    for (var element in listOfMoreMenu) {
      list.add(PopupMenuItem(
          value: element,
          enabled: true,
          child: VxBox(
                  child: element.text
                      .size(14)
                      .medium
                      .color(MyColor.lightBlueColor)
                      .make())
              .width(150)
              .make()
              .onTap(
            () {
              _selectMoreOption(listOfMoreMenu.indexOf(element), context);
              Get.back();
            },
          )));
      list.add(const PopupMenuDivider(
        height: 1,
      ));
    }
    var sizeOfScreen = MediaQuery.of(context).size;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(sizeOfScreen.width - 100,
            sizeOfScreen.height - 100, sizeOfScreen.width - 100, 100),
        items: list,
        useRootNavigator: true);
  }

  void _selectMoreOption(int index, BuildContext context) {
    _con.navigationQueue.addLast(4);
    switch (index) {
      case 0:
        Navigator.pushNamed(context, EkuaboRoute.privateMessageBoard);

        break;
      case 1:
        Navigator.pushNamed(context, EkuaboRoute.more);
        break;
      case 2:
        Navigator.pushNamed(context, EkuaboRoute.myPostBannerAd);

        break;
      case 3:
        Navigator.pushNamed(context, EkuaboRoute.myGroup);

        break;
      case 4:
        Navigator.pushNamed(context, EkuaboRoute.groupInvitation);

        break;
      case 5:
        Navigator.pushNamed(context, EkuaboRoute.groupJoinRequest);

        break;
      case 6:
        Navigator.pushNamed(context, EkuaboRoute.transactionHistory);

        break;
      case 7:
        Navigator.pushNamed(context, EkuaboRoute.setting);

        break;
    }
  }

  Widget getAppBar(BuildContext context,
      {Widget action = null, Widget leading = null}) {
    return AppBar(
      leading: (leading == null) ? Container() : leading,
      elevation: 0,
      actions: [
        (action == null) ? Container() : action,
        IconButton(
            onPressed: () {
              _showPopupMenu(context);
            },
            icon: Icon(
              Icons.person,
              color: MyColor.mainColor,
            ))
      ],
      backgroundColor: Colors.white,
      title: Image.asset(
        EkuaboAsset.ic_app_logo,
        width: 118,
        height: 49,
      ),
      centerTitle: true,
    );
  }
}
