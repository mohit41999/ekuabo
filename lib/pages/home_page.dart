import 'package:ekuabo/controller/home_controller.dart';

import 'package:ekuabo/pages/blog.dart';
import 'package:ekuabo/pages/chat_conversation.dart';
import 'package:ekuabo/pages/create_my_ad.dart';
import 'package:ekuabo/pages/edit_market_place_info.dart';
import 'package:ekuabo/pages/edit_profile.dart';
import 'package:ekuabo/pages/group_invitation.dart';
import 'package:ekuabo/pages/group_join_request.dart';
import 'package:ekuabo/pages/home_view.dart';
import 'package:ekuabo/pages/market_place.dart';
import 'package:ekuabo/pages/marketplace_listing.dart';
import 'package:ekuabo/pages/more.dart';
import 'package:ekuabo/pages/my_group.dart';
import 'package:ekuabo/pages/my_posted_banner_ad.dart';
import 'package:ekuabo/pages/new_feed.dart';
import 'package:ekuabo/pages/payment_webview.dart';
import 'package:ekuabo/pages/post_blog.dart';
import 'package:ekuabo/pages/post_new_group.dart';
import 'package:ekuabo/pages/post_new_listing.dart';
import 'package:ekuabo/pages/private_message_board.dart';
import 'package:ekuabo/pages/setting.dart';
import 'package:ekuabo/pages/transaction_history.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'blog_detail.dart';
import 'news_feeds_view_all.dart';

class HomePage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => WillPopScope(
              onWillPop: () async {
                if (_con.bottomNavigatorKey.currentState.canPop()) {
                  if (_con.navigationQueue.isNotEmpty) {
                    _con.navigationQueue.removeLast();
                    int position = _con.navigationQueue.isEmpty
                        ? 0
                        : _con.navigationQueue.last;
                    _con.bottomNavigatorKey.currentState.pop();
                    _con.changeBottomNavIndex(position);
                    return false;
                  }
                  _con.bottomNavigatorKey.currentState.pop();
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  selectedItemColor: MyColor.mainColor,
                  unselectedItemColor: MyColor.inactiveColor,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  // selectedIconTheme:const IconThemeData(color: MyColor.mainColor),
                  // unselectedIconTheme:const IconThemeData(color: MyColor.lightBlueColor),
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 10,
                  ),
                  // iconSize: 24,
                  elevation: 10,
                  backgroundColor: Colors.white,
                  currentIndex: _con.selectedIndex,
                  onTap: (index) {
                    // if (index == 4) {
                    //   _showPopupMenu(context);
                    // }

                    if (index != _con.selectedIndex) {
                      /*_con.navigationQueue
                  .removeWhere((element) => element == index);*/
                      _con.navigationQueue.addLast(index);

                      switch (index) {
                        case 0:
                          _con.bottomNavigatorKey.currentState
                              .pushNamed(EkuaboRoute.homeView);
                          break;
                        case 1:
                          _con.bottomNavigatorKey.currentState
                              .pushNamed(EkuaboRoute.marketPlace);
                          break;
                        case 2:
                          _con.bottomNavigatorKey.currentState
                              .pushNamed(EkuaboRoute.newsFeedsViewAll);
                          break;
                        case 3:
                          _con.bottomNavigatorKey.currentState
                              .pushNamed(EkuaboRoute.blog);
                          break;
                        case 4:
                          _con.bottomNavigatorKey.currentState
                              .pushNamed(EkuaboRoute.more);

                          break;
                      }
                      _con.changeBottomNavIndex(index);
                    }
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          EkuaboAsset.ic_home,
                          color: _con.selectedIndex == 0
                              ? MyColor.mainColor
                              : MyColor.inactiveColor.withOpacity(0.6),
                          width: 24,
                          height: 24,
                        ).p(10),
                        label: EkuaboString.home),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          _con.selectedIndex != 1
                              ? EkuaboAsset.ic_marketplace
                              : EkuaboAsset.ic_active_market_place,
                          width: 24,
                          height: 24,
                        ).p(10),
                        label: EkuaboString.marketPlace),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          EkuaboAsset.ic_feed,
                          color: _con.selectedIndex == 2
                              ? MyColor.mainColor
                              : MyColor.inactiveColor.withOpacity(0.6),
                          width: 24,
                          height: 24,
                        ).p(10),
                        label: EkuaboString.most_recent_postings),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          _con.selectedIndex == 3
                              ? EkuaboAsset.ic_active_blog
                              : EkuaboAsset.ic_blog,
                          width: 24,
                          height: 24,
                        ).p(10),
                        label: EkuaboString.blog),
                    // BottomNavigationBarItem(
                    //     icon: Icon(
                    //       Icons.person_outline_rounded,
                    //       color: _con.selectedIndex == 4
                    //           ? MyColor.mainColor
                    //           : MyColor.inactiveColor,
                    //     ),
                    //     // Image.asset(
                    //
                    //     //   width: 24,
                    //     //   height: 24,
                    //     // ),
                    //     label: 'Profile'),
                  ],
                ),
                body: Navigator(
                    key: _con.bottomNavigatorKey,
                    initialRoute: EkuaboRoute.homeView,
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute(
                          builder: (context) => makeRoute(
                              context: context,
                              routeName: settings.name,
                              argument: settings.arguments),
                          maintainState: true);
                    }),
              ),
            ));
  }

  Widget makeRoute({BuildContext context, String routeName, Object argument}) {
    switch (routeName) {
      /* case EkuaboRoute.splashScreen:
        return  SplashScreen(key: Key(argument.toString()),);*/
      case EkuaboRoute.homeView:
        return HomeView();
      case EkuaboRoute.marketPlace:
        return MarketPlace();
      case EkuaboRoute.blog:
        return Blog();
      case EkuaboRoute.newsFeed:
        return NewFeed();
      case EkuaboRoute.more:
        return More();
      case EkuaboRoute.newsFeedsViewAll:
        return NewsFeedsViewAll();
      case EkuaboRoute.marketPlaceListing:
        return MarketPlaceListing();
      case EkuaboRoute.blog_detail:
        return BlogDetail(mostRecentBlogData: argument);
      case EkuaboRoute.postBlog:
        return PostBlog();
      case EkuaboRoute.postNewListing:
        return PostNewListing();
      case EkuaboRoute.myPostBannerAd:
        return MyPostedBannerAd();
      case EkuaboRoute.myGroup:
        return MyGroups();
      case EkuaboRoute.postNewGroup:
        return PostNewGroup();
      case EkuaboRoute.groupInvitation:
        return GroupInvitation();
      case EkuaboRoute.groupJoinRequest:
        return GroupJoinRequest();
      case EkuaboRoute.transactionHistory:
        return TransactionHistory();
      case EkuaboRoute.setting:
        return Setting();
      case EkuaboRoute.editProfile:
        return EditProfile();
      case EkuaboRoute.createMyAd:
        return CreateMyAd();
      case EkuaboRoute.privateMessageBoard:
        return PrivateMessageBoard();
      case EkuaboRoute.chatConversation:
        return ChatConversation(
          chatBean: argument,
        );
      case EkuaboRoute.editMarketPlaceInfo:
        return EditMarketPlaceInfo();

      default:
        return const Text("Loading...");
    }
  }
}
