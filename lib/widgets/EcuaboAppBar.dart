import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/market_place_controller.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/navigationDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EcuaboAppBar extends StatefulWidget implements PreferredSizeWidget {
  const EcuaboAppBar({
    Key key,
    this.action = null,
  }) : super(key: key);
  final Widget action;

  @override
  _EcuaboAppBarState createState() => _EcuaboAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}

class _EcuaboAppBarState extends State<EcuaboAppBar> {
  @override
  Widget build(BuildContext context) {
    return getAppBar(context, action: widget.action);
  }

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
          child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: element.text
                      .size(14)
                      .medium
                      .color(MyColor.lightBlueColor)
                      .make())
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
        position: RelativeRect.fromLTRB(sizeOfScreen.width, 100, 0, 0),
        items: list,
        useRootNavigator: true);
  }

  void _selectMoreOption(int index, BuildContext context) {
    _con.navigationQueue.addLast(0);
    switch (index) {
      case 0:
        _con.bottomNavigatorKey.currentState
            .pushNamed(EkuaboRoute.privateMessageBoard);

        break;
      case 1:
        _con.bottomNavigatorKey.currentState.pushNamed(EkuaboRoute.more);
        break;
      case 2:
        _con.bottomNavigatorKey.currentState
            .pushNamed(EkuaboRoute.myPostBannerAd);

        break;
      case 3:
        _con.bottomNavigatorKey.currentState.pushNamed(EkuaboRoute.myGroup);

        break;
      case 4:
        _con.bottomNavigatorKey.currentState
            .pushNamed(EkuaboRoute.groupInvitation);

        break;
      case 5:
        _con.bottomNavigatorKey.currentState
            .pushNamed(EkuaboRoute.groupJoinRequest);

        break;
      case 6:
        _con.bottomNavigatorKey.currentState
            .pushNamed(EkuaboRoute.transactionHistory);

        break;
      case 7:
        _con.bottomNavigatorKey.currentState.pushNamed(EkuaboRoute.setting);

        break;
    }
  }

  Widget getAppBar(BuildContext context, {Widget action = null}) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu,
            color: MyColor.mainColor,
          ),
          onPressed: () {
            setState(() {
              Scaffold.of(context).openDrawer();
            });
          },
        ),
      ),
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

class CommonNavigationDrawer extends StatefulWidget {
  const CommonNavigationDrawer({Key key}) : super(key: key);

  @override
  _CommonNavigationDrawerState createState() => _CommonNavigationDrawerState();
}

class _CommonNavigationDrawerState extends State<CommonNavigationDrawer> {
  final _con = Get.find<MarketPlaceController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getMarketPlaceCategory;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(_con.getMarketPlaceCategory);
  }
}
