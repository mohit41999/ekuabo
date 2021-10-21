import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/home_view_controller.dart';

import 'package:ekuabo/model/uiModel/MostRecentFeedModel.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<HomeViewController>();

  var mostRecentFeeds = [
    MostRecentFeedModel(
        img: EkuaboAsset.demo_img2,
        title: "Fashion",
        subtitle: "Welcome to our group",
        days: "15 days ago"),
    MostRecentFeedModel(
        img: EkuaboAsset.demo_img,
        title: "Francis",
        subtitle: "Welcome to our group",
        days: "15 days ago"),
    MostRecentFeedModel(
        img: EkuaboAsset.demo_img2,
        title: "Fashion",
        subtitle: "Welcome to our group",
        days: "15 days ago"),
  ];

  @override
  Widget build(BuildContext context) {
    var fromSignup = false;
    if (Get.parameters.containsKey("fromSignup")) {
      fromSignup = true;
      Get.parameters = {};
    } else
      fromSignup = false;
    return GetBuilder<HomeViewController>(
      builder: (_) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              _con.getMostRecentNewsFeed();
            });
            return _con.getMostRecentNewsFeed();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                fromSignup ? 20.heightBox : SizedBox(),
                fromSignup
                    ? VxBox(
                            child: Column(
                        children: [
                          30.heightBox,
                          Image.asset(
                            EkuaboAsset.ic_app_logo,
                            width: 118,
                            height: 49,
                          ),
                          16.heightBox,
                          EkuaboString.welcome_to_your_neighbourhood.text.bold
                              .size(18)
                              .white
                              .make(),
                          16.heightBox,
                          EkuaboString.homeText2.text
                              .size(11)
                              .light
                              .white
                              .make()
                              .pOnly(left: 20, right: 16),
                          16.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              20.widthBox,
                              Image.asset(
                                EkuaboAsset.home_people_img,
                                height: 100,
                              ),
                              16.widthBox,
                              Flexible(
                                child: const ExpandableText(
                                  EkuaboString.homeText2,
                                  expandText: EkuaboString.read_more,
                                  collapseText: EkuaboString.read_less,
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w100,
                                      color: Colors.white),
                                  linkColor: Colors.white,
                                  linkStyle: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline),
                                  linkEllipsis: true,
                                ).pOnly(left: 20, right: 16),
                              ),
                            ],
                          ).p(10)
                        ],
                      ))
                        .color(MyColor.mainColor)
                        .bottomLeftRounded(value: 125)
                        .gradientFromTo(
                            from: MyColor.inactiveColor, to: MyColor.blueColor)
                        .width(double.infinity)
                        .make()
                    : SizedBox(),
                fromSignup ? 25.heightBox : SizedBox(),
                fromSignup
                    ? EkuaboString.join_your_neighbours_today.text.bold
                        .size(20)
                        .black
                        .make()
                    : 20.heightBox,
                // Most Recent News Feed
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EkuaboString.most_recent_postings.text
                            .size(16)
                            .bold
                            .black
                            .make(),
                        UnderlineWidget().getUnderlineWidget(),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () {
                        _homeController.bottomNavigatorKey.currentState
                            .pushNamed(EkuaboRoute.newsFeedsViewAll);
                        _homeController.navigationQueue.addLast(0);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: MyColor.inactiveColor,
                      child: EkuaboString.viewAll.text
                          .size(10)
                          .medium
                          .white
                          .makeCentered(),
                    )
                  ],
                ).pOnly(left: 16, right: 20),
                16.heightBox,
                // Most Recent
                _con.mostRecentNewsFeeds.isEmpty
                    ? EkuaboString.no_results_found.text
                        .size(14)
                        .medium
                        .color(Colors.grey)
                        .make()
                        .objectTopLeft()
                        .pOnly(left: 16)
                    : Container(
                        height: 200,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _con.mostRecentNewsFeeds.length,
                            itemBuilder: (ctx, index) {
                              return VxCard(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        _con.mostRecentNewsFeeds[index].image,
                                    placeholder: (_, __) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  10.heightBox,
                                  _con.mostRecentNewsFeeds[index].userName.text
                                      .size(12)
                                      .bold
                                      .black
                                      .make()
                                      .pOnly(left: 10),
                                  Container(
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: (_con.mostRecentNewsFeeds[index]
                                                  .feed_msg.length <=
                                              50)
                                          ? Text(
                                              _con.mostRecentNewsFeeds[index]
                                                  .feed_msg,
                                              style: TextStyle(fontSize: 13),
                                            )
                                          : Text(
                                              _con.mostRecentNewsFeeds[index]
                                                      .feed_msg
                                                      .substring(0, 51) +
                                                  '...',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                    ),

                                    // _con
                                    //         .mostRecentNewsFeeds[index].feed_msg
                                    //         .substring(0, 50) +
                                    //     '...'
                                    //         .toString()
                                    //         .text
                                    //         .light
                                    //         .size(10)
                                    //         .make()
                                    //         .pOnly(
                                    //           left: 10,
                                    //         ),
                                  ),
                                  5.heightBox,
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_rounded,
                                          color: MyColor.mainColor,
                                          size: 14,
                                        ),
                                        3.widthBox,
                                        _con.mostRecentNewsFeeds[index].created
                                            .text
                                            .maxLines(1)
                                            .size(10)
                                            .light
                                            .black
                                            .make()
                                      ],
                                    ).pOnly(left: 5),
                                  )
                                ],
                              ))
                                  .elevation(10)
                                  .bottomLeftRounded(value: 12)
                                  .make()
                                  .pOnly(left: 10)
                                  .onTap(() {
                                _homeController.bottomNavigatorKey.currentState
                                    .pushNamed(EkuaboRoute.newsFeedsViewAll);
                                _homeController.navigationQueue.addLast(0);
                              });
                            }),
                      ),
// Latest Blog
                20.heightBox,
                EkuaboString.latest_blog.text
                    .size(16)
                    .bold
                    .black
                    .make()
                    .objectCenterLeft()
                    .pOnly(left: 16),
                UnderlineWidget()
                    .getUnderlineWidget()
                    .objectCenterLeft()
                    .pOnly(left: 16),
                16.heightBox,
                // Latest Blog
                Container(
                  height: 290,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: mostRecentFeeds.length,
                      itemBuilder: (ctx, index) {
                        return VxCard(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              mostRecentFeeds[index].img,
                              height: 110,
                              fit: BoxFit.cover,
                              width: 220,
                            ),
                            10.heightBox,
                            "Lorem ipsum dolor sit amet"
                                .text
                                .size(12)
                                .bold
                                .black
                                .make()
                                .pOnly(left: 10),
                            "Lorem ipsum dolor sit amet,\n consetetur sadipscing elitr"
                                .text
                                .light
                                .size(10)
                                .make()
                                .pOnly(left: 10, top: 16),
                            10.heightBox,
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      EkuaboAsset.ic_user2,
                                      color: MyColor.mainColor,
                                      width: 14,
                                      height: 14,
                                    ),
                                    5.widthBox,
                                    "YUSUF ADETELA"
                                        .text
                                        .size(10)
                                        .light
                                        .black
                                        .make()
                                  ],
                                ),
                                10.widthBox,
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: MyColor.mainColor,
                                      size: 14,
                                    ),
                                    5.widthBox,
                                    mostRecentFeeds[index]
                                        .days
                                        .text
                                        .size(10)
                                        .light
                                        .black
                                        .make()
                                  ],
                                ),
                              ],
                            ).pOnly(left: 10, right: 10),
                            MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: MyColor.mainColor, width: 0.8)),
                              color: Colors.white,
                              child: EkuaboString.viewDetails.text
                                  .size(10)
                                  .medium
                                  .color(MyColor.mainColor)
                                  .make(),
                            ).pOnly(left: 50, top: 16)
                          ],
                        ))
                            .elevation(10)
                            .bottomLeftRounded(value: 12)
                            .make()
                            .pOnly(left: 10);
                      }),
                ),
// Market Place
                20.heightBox,
                EkuaboString.market_place.text
                    .size(16)
                    .bold
                    .black
                    .make()
                    .objectTopLeft()
                    .pOnly(left: 16),
                UnderlineWidget()
                    .getUnderlineWidget()
                    .objectTopLeft()
                    .pOnly(left: 16),
                16.heightBox,
                _con.homeMarketPlaces.isNotEmpty
                    ? Stack(
                        children: [
                          Image.asset(
                            EkuaboAsset.bottom_image,
                            width: double.infinity,
                          ).pOnly(top: 80),
                          Container(
                            height: 250,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _con.homeMarketPlaces.length,
                                itemBuilder: (ctx, index) {
                                  var homeMarketPlace =
                                      _con.homeMarketPlaces[index];
                                  return VxCard(Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: homeMarketPlace.image ?? '',
                                        placeholder: (ctx, _) => const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        height: 110,
                                        width: 220,
                                        fit: BoxFit.fill,
                                      ),
                                      /*Image.asset(mostRecentFeeds[index].img,
                                       height: 110,
                                       fit: BoxFit.cover,
                                       width: 220,
                                     ),*/
                                      10.heightBox,
                                      Flexible(
                                          child: homeMarketPlace
                                              .marketTitle.text
                                              .maxLines(1)
                                              .ellipsis
                                              .size(12)
                                              .bold
                                              .black
                                              .make()
                                              .pOnly(left: 10)),
                                      Flexible(
                                          child: homeMarketPlace
                                              .marketDescription.text
                                              .maxLines(3)
                                              .ellipsis
                                              .light
                                              .size(10)
                                              .make()
                                              .pOnly(left: 10, top: 16)),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: homeMarketPlace
                                                        .userDetail.profile ??
                                                    '',
                                                placeholder: (ctx, _) =>
                                                    const SizedBox(
                                                  width: 10,
                                                  height: 10,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                height: 14,
                                                width: 14,
                                              ),
                                              /*Image.asset(EkuaboAsset.ic_user2,color: MyColor.mainColor,width: 14,
                                               height: 14,
                                             ),*/

                                              5.widthBox,
                                              homeMarketPlace.userDetail
                                                          .username ==
                                                      null
                                                  ? ''
                                                      .text
                                                      .maxLines(1)
                                                      .ellipsis
                                                      .size(10)
                                                      .light
                                                      .black
                                                      .make()
                                                  : homeMarketPlace
                                                      .userDetail.username.text
                                                      .maxLines(1)
                                                      .ellipsis
                                                      .size(10)
                                                      .light
                                                      .black
                                                      .make()
                                            ],
                                          ),
                                          10.widthBox,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time_rounded,
                                                color: MyColor.mainColor,
                                                size: 14,
                                              ),
                                              5.widthBox,
                                              homeMarketPlace.created.text
                                                  .size(10)
                                                  .light
                                                  .black
                                                  .make()
                                            ],
                                          ),
                                        ],
                                      ).pOnly(left: 10, right: 10),
                                    ],
                                  ))
                                      .elevation(10)
                                      .bottomLeftRounded(value: 12)
                                      .make()
                                      .pOnly(left: 10);
                                }),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EkuaboString.no_results_found.text
                              .size(14)
                              .medium
                              .color(Colors.grey)
                              .make(),
                          Image.asset(
                            EkuaboAsset.bottom_image,
                            width: double.infinity,
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
      initState: (_) => _con.getMostRecentNewsFeed(),
    );
  }
}
