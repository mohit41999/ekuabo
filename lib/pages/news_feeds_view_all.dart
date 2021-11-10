import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/home_view_controller.dart';
import 'package:ekuabo/controller/news_feeds_view_all_controller.dart';
import 'package:ekuabo/model/apimodel/home/news_feeds.dart';
import 'package:ekuabo/model/apimodel/market_place/category_bean.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/pages/search_group_page.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/navigationDrawer.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class NewsFeedsViewAll extends StatefulWidget {
  const NewsFeedsViewAll({
    Key key,
  }) : super(key: key);
  @override
  _NewsFeedsViewAllState createState() => _NewsFeedsViewAllState();
}

class _NewsFeedsViewAllState extends State<NewsFeedsViewAll> {
  void deletedialog(String feed_id, int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Are you Sure You Want to Delete?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                      color: Colors.red,
                    ),
                    MaterialButton(
                      onPressed: () {
                        deletefeed(feed_id, index);
                        Navigator.pop(context);
                      },
                      child: Text('Yes'),
                      color: Colors.green,
                    ),
                  ],
                )
              ],
            ));
  }

  Future deletefeed(String feed_id, int index) async {
    var userBean = await PrefManager.getUser();
    var response = await http
        .post(Uri.parse('https://eku-abo.com/api/feed/delete_feed.php'), body: {
      'token': '123456789',
      'user_id': userBean.data.id,
      'feed_id': feed_id,
    });
    var Response = jsonDecode(response.body);
    if (Response['status']) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Response['message']),
        backgroundColor: Colors.green,
      ));
      setState(() {
        _con.newsFeeds.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sorry you cannot delete this !!!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<CategoryBean> getMarketPlaceCategory;
  void initialize() {
    setState(() {
      getMarketPlaceCategory = MarketPlaceRepository().getCategory();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  final _con = Get.find<NewsFeedsViewAllController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsFeedsViewAllController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(
          context,
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
        ),
        // AppBar(
        //   foregroundColor: MyColor.mainColor,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   actions: [

        //   ],
        //   title: Image.asset(
        //     EkuaboAsset.ic_app_logo,
        //     width: 118,
        //     height: 49,
        //   ).centered(),
        // ),
        drawer: NavigationDrawer(getMarketPlaceCategory),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                16.heightBox,
                _con.isLoad
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _con.newsFeeds.isEmpty
                        ? Center(
                            child: EkuaboString.no_results_found.text
                                .color(MyColor.blackColor)
                                .size(10)
                                .make(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchGroup()));
                                  },
                                  child: VxCard(Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color:
                                            MyColor.mainColor.withOpacity(0.8),
                                        size: 24,
                                      ),
                                      16.widthBox,
                                      EkuaboString.searchGroup.text
                                          .color(MyColor.mainColor
                                              .withOpacity(0.8))
                                          .light
                                          .size(16)
                                          .make()
                                    ],
                                  ).p(5))
                                      .elevation(5)
                                      .withRounded(value: 7)
                                      .shadowColor(MyColor.mainColor)
                                      .make(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: VxCircle(
                                  backgroundColor: MyColor.mainColor,
                                  child: const Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  ).onFeedBackTap(() async {
                                    Navigator.pushNamed(
                                            context, EkuaboRoute.newsFeed)
                                        .then((value) {
                                      _con.getNewsFeeds();
                                    });
                                  }),
                                  shadows: const [
                                    BoxShadow(
                                        color: MyColor.inactiveColor,
                                        blurRadius: 10)
                                  ],
                                ).wh(30, 30),
                              )
                            ],
                          ),
                16.heightBox,
                _con.userBean == null
                    ? "".text.make()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Image.asset(
                              EkuaboAsset.ic_location,
                              width: 12,
                              height: 12,
                              color: MyColor.inactiveColor,
                            ),
                            5.widthBox,

                            Text(
                              '${_con.userBean.data.lga_name.toString()}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            // _con.userBean.data.lga_name.text.medium
                            //     .size(14)
                            //     .make()
                          ]),
                UnderlineWidget().getUnderlineWidget(),
                ListView.builder(
                  itemCount: _con.newsFeeds.length,
                  physics: NeverScrollableScrollPhysics(),
                  reverse: true,
                  itemBuilder: (ctx, index) {
                    var newsFeed = _con.newsFeeds[index];
                    return VxCard(Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              EkuaboAsset.ic_user,
                              width: 12,
                              height: 12,
                              color: MyColor.mainColor,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: MyColor.mainColor,
                                  size: 12,
                                ),
                                5.widthBox,
                                newsFeed.createdDate.text.light.size(10).make()
                              ],
                            )
                          ],
                        ).p(5),
                        VxBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            newsFeed.userFeedDetails.profile,
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (_, __, ___) =>
                                            Icon(Icons.person),
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        (newsFeed.userFeedDetails.username ==
                                                null)
                                            ? Text('anonymous')
                                            : newsFeed.userFeedDetails.username
                                                .text.bold
                                                .size(12)
                                                .make(),
                                        5.heightBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              EkuaboAsset.ic_location,
                                              width: 12,
                                              height: 12,
                                              color: MyColor.inactiveColor,
                                            ),
                                            5.widthBox,
                                            (newsFeed.userFeedDetails
                                                        .username ==
                                                    null)
                                                ? Text('anonymous')
                                                : newsFeed.userFeedDetails
                                                    .location.text.light
                                                    .size(10)
                                                    .make()
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                (_con.userBean.data.id == newsFeed.userId)
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            deletedialog(
                                                newsFeed.feedId, index);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                    : Container()
                              ],
                            ),
                            Html(
                              data: newsFeed.message,
                            )
                                /*newsFeed.message.text
                                .size(12)
                                .bold
                                .make()*/
                                .pOnly(left: 10),
                            16.heightBox,
                            CachedNetworkImage(
                              imageUrl: newsFeed.uploadPath ?? '',
                              fit: BoxFit.cover,
                              placeholder: (_, __) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (_, __, ___) => Container(),
                              //       Image.asset(
                              //     EkuaboAsset.no_image,
                              //     width: double.infinity,
                              //     height: 192,
                              //     fit: BoxFit.cover,
                              //   ),
                            ).pOnly(left: 10, right: 10),
                            16.heightBox,
                            ""
                                .text
                                .size(10)
                                .light
                                .align(TextAlign.justify)
                                .color(MyColor.blackColor.withOpacity(0.6))
                                .make()
                                .pOnly(left: 10, right: 10),
                            10.heightBox,
                            Row(
                              children: [
                                Image.asset(
                                  newsFeed.isUserLike == "n"
                                      ? EkuaboAsset.ic_like
                                      : EkuaboAsset.ic_liked,
                                  width: 16,
                                  height: 16,
                                ).onTap(() {
                                  if (newsFeed.isUserLike == "n")
                                    _con.like(context, newsFeed.feedId);
                                  else
                                    _con.unlike(context, newsFeed.feedId);
                                }),
                                30.widthBox,
                                Image.asset(
                                  EkuaboAsset.ic_comment,
                                  width: 16,
                                  height: 16,
                                ).onTap(() {
                                  newsFeed.isCommentExpand =
                                      !newsFeed.isCommentExpand;
                                  _con.update();
                                }),
                                30.widthBox,
                                Image.asset(
                                  EkuaboAsset.ic_share,
                                  width: 16,
                                  height: 16,
                                ).onTap(() async => _share(newsFeed)),
                                newsFeed.isUserReported == "n"
                                    ? EkuaboString.report.text
                                        .color(
                                            MyColor.mainColor.withOpacity(0.6))
                                        .size(10)
                                        .light
                                        .underline
                                        .make()
                                        .onTap(() => _con.report(
                                            context, newsFeed.feedId))
                                        .pOnly(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44)
                                    : SizedBox(),
                              ],
                            ).pOnly(left: 10, right: 10),
                            newsFeed.isCommentExpand
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      16.heightBox,
                                      EkuaboString.comments.text.bold
                                          .size(14)
                                          .make(),
                                      10.heightBox,
                                      newsFeed.comment.isEmpty
                                          ? EkuaboString
                                              .no_comments_yet.text.medium
                                              .size(12)
                                              .make()
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  newsFeed.comment.length,
                                              itemBuilder: (ctx, index) {
                                                var comment =
                                                    newsFeed.comment[index];
                                                return VxBox(
                                                        child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      child: CachedNetworkImage(
                                                        imageUrl: comment
                                                                .userDetails
                                                                .profile ??
                                                            '',
                                                        placeholder: (_, __) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (_, __,
                                                                ___) =>
                                                            Icon(Icons.person),
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                    ),
                                                    10.widthBox,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        comment
                                                            .userDetails
                                                            .username
                                                            .text
                                                            .medium
                                                            .size(10)
                                                            .color(MyColor
                                                                .mainColor)
                                                            .make(),
                                                        5.heightBox,
                                                        comment
                                                            .comment.text.medium
                                                            .size(10)
                                                            .make(),
                                                      ],
                                                    )
                                                  ],
                                                ).p(10))
                                                    .width(double.infinity)
                                                    .withRounded(value: 7)
                                                    .color(MyColor.lightGrey)
                                                    .make()
                                                    .pOnly(
                                                        left: 10,
                                                        right: 10,
                                                        top: 10);
                                              },
                                            )
                                    ],
                                  ).pOnly(left: 10)
                                : SizedBox(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          _con.userBean.data.profileImg ?? '',
                                      width: 24,
                                      height: 24,
                                      placeholder: (_, __) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (_, __, ___) =>
                                          Icon(Icons.account_circle),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    controller: _con.commentCtl,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          EkuaboString.insert_comments_here,
                                      hintStyle: TextStyle(
                                          color: MyColor.blackColor
                                              .withOpacity(0.4),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Image.asset(
                                    EkuaboAsset.ic_send,
                                    width: 16,
                                    height: 16,
                                  ).onTap(() =>
                                      _con.comment(context, newsFeed.feedId)),
                                )
                              ],
                            )
                                .backgroundColor(Colors.blueGrey.shade50)
                                .pOnly(top: 20)
                          ],
                        )).white.make().p2()
                      ],
                    ))
                        .color(Colors.blueGrey.shade50)
                        .withRounded(value: 7)
                        .make()
                        .pOnly(top: 16);
                  },
                  shrinkWrap: true,
                )
              ],
            ).pOnly(left: 16, right: 16),
          ),
        ),
      ),
      initState: (_) => _con.getNewsFeeds(),
    );
  }

  Future<void> _share(NewsFeedData newsFeedData) async {
    await FlutterShare.share(
        title: newsFeedData.userFeedDetails.username,
        text: newsFeedData.message,
        linkUrl: newsFeedData.uploadPath,
        chooserTitle: 'Choose App to share');
  }
}
