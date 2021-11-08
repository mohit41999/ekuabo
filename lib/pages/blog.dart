import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/blog_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';

import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<BlogController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar().getAppBar(context),
        body: GetBuilder<BlogController>(
          builder: (_) => _con.mostRecentBlogs == null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EkuaboString.most_recent_blog.text.heightTight
                                .size(16)
                                .medium
                                .make(),
                            UnderlineWidget().getUnderlineWidget()
                          ],
                        ),
                        VxCircle(
                          backgroundColor: MyColor.mainColor,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ).onFeedBackTap(() {
                            _homeController.navigationQueue.addLast(3);
                            _homeController.bottomNavigatorKey.currentState
                                .pushNamed(EkuaboRoute.postBlog)
                                .then((value) {
                              setState(() {
                                _con.mostRecentBlogs;
                                _con.getMostRecent();
                              });
                            });
                          }),
                          shadows: const [
                            BoxShadow(
                                color: MyColor.inactiveColor, blurRadius: 10)
                          ],
                        ).wh(40, 40),
                      ],
                    ).pOnly(top: 10, left: 16, right: 16),
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    Image.asset(
                      EkuaboAsset.bottom_image,
                      width: double.infinity,
                    ).objectBottomLeft()
                  ],
                )
              : _con.mostRecentBlogs.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () {
                        setState(() {
                          _con.getMostRecent();
                        });
                        return _con.getMostRecent();
                      },
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              EkuaboAsset.bottom_image,
                              width: double.infinity,
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      EkuaboString
                                          .most_recent_blog.text.heightTight
                                          .size(16)
                                          .medium
                                          .make(),
                                      UnderlineWidget().getUnderlineWidget()
                                    ],
                                  ),
                                  VxCircle(
                                    backgroundColor: MyColor.mainColor,
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ).onFeedBackTap(() {
                                      _homeController.navigationQueue
                                          .addLast(3);
                                      _homeController
                                          .bottomNavigatorKey.currentState
                                          .pushNamed(EkuaboRoute.postBlog)
                                          .then((value) {
                                        setState(() {
                                          _con.mostRecentBlogs;
                                          _con.getMostRecent();
                                        });
                                      });
                                    }),
                                    shadows: const [
                                      BoxShadow(
                                          color: MyColor.inactiveColor,
                                          blurRadius: 10)
                                    ],
                                  ).wh(40, 40),
                                ],
                              ).pOnly(top: 10, left: 16, right: 16),
                              Expanded(
                                child: GridView.builder(
                                  itemBuilder: (ctx, index) {
                                    return VxCard(Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            VxBox(
                                                    child: Hero(
                                              tag: "Blog",
                                              child: CachedNetworkImage(
                                                imageUrl: _con
                                                    .mostRecentBlogs[index]
                                                    .blogImage,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget: (_, __, ___) {
                                                  return Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'asset/images/error_img.jpg'),
                                                            fit: BoxFit.cover)),
                                                  );
                                                },
                                              ),
                                            ))
                                                .width(100)
                                                .height(100)
                                                .bottomLeftRounded(value: 12)
                                                .makeCentered()
                                                .pOnly(left: 20),
                                            10.widthBox,
                                            const Icon(
                                              Icons.more_vert,
                                              color: Colors.black,
                                            ).onTap(() =>
                                                _showPopupMenu(context, index)),
                                          ],
                                        ),
                                        _con.mostRecentBlogs[index].blogTitle
                                            .text
                                            .maxLines(1)
                                            .ellipsis
                                            .color(MyColor.mainColor)
                                            .size(16)
                                            .medium
                                            .make()
                                            .pOnly(left: 10),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: Html(
                                            data: _con.mostRecentBlogs[index]
                                                .blogDesc,
                                            /*.text
                                .maxLines(4)
                                .color(MyColor.blackColor.withOpacity(0.6))
                                .size(12)
                                .medium
                                .align(TextAlign.justify)
                                .make()*/
                                          ).pOnly(left: 10, right: 10),
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: (_con
                                                          .mostRecentBlogs[
                                                              index]
                                                          .profileDetails
                                                          .profile
                                                          .toString() ==
                                                      null.toString())
                                                  ? AssetImage(
                                                      'asset/images/error_img.jpg')
                                                  : NetworkImage(_con
                                                      .mostRecentBlogs[index]
                                                      .profileDetails
                                                      .profile),
                                            ),
                                            10.widthBox,
                                            Flexible(
                                              child: (_con
                                                          .mostRecentBlogs[
                                                              index]
                                                          .profileDetails
                                                          .username
                                                          .toString() ==
                                                      null.toString())
                                                  ? 'Anonymous'
                                                      .text
                                                      .color(MyColor
                                                          .lightBlueColor)
                                                      .size(10)
                                                      .medium
                                                      .make()
                                                  : _con
                                                      .mostRecentBlogs[index]
                                                      .profileDetails
                                                      .username
                                                      .text
                                                      .color(MyColor
                                                          .lightBlueColor)
                                                      .size(10)
                                                      .medium
                                                      .make(),
                                            )
                                          ],
                                        ).pOnly(left: 16),
                                        Row(
                                          children: [
                                            4.widthBox,
                                            const Icon(
                                              Icons.access_time_rounded,
                                              color: MyColor.mainColor,
                                            ),
                                            3.widthBox,
                                            Flexible(
                                              child: _con.mostRecentBlogs[index]
                                                  .created.text
                                                  .size(10)
                                                  .medium
                                                  .make(),
                                            )
                                          ],
                                        ).pOnly(right: 16, bottom: 16)
                                      ],
                                    ))
                                        .elevation(5)
                                        .withRounded(value: 7)
                                        .white
                                        .make()
                                        .w(200)
                                        .onTap(() {
                                      _homeController
                                          .bottomNavigatorKey.currentState
                                          .pushNamed(EkuaboRoute.blog_detail,
                                              arguments:
                                                  _con.mostRecentBlogs[index]);
                                      _homeController.navigationQueue
                                          .addLast(3);
                                    }).pOnly(top: 10, left: 10, right: 10);
                                  },
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _con.mostRecentBlogs.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EkuaboString.most_recent_blog.text.heightTight
                                    .size(16)
                                    .medium
                                    .make(),
                                UnderlineWidget().getUnderlineWidget()
                              ],
                            ),
                            VxCircle(
                              backgroundColor: MyColor.mainColor,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ).onFeedBackTap(() {
                                _homeController.navigationQueue.addLast(3);
                                _homeController.bottomNavigatorKey.currentState
                                    .pushNamed(EkuaboRoute.postBlog);
                              }),
                              shadows: const [
                                BoxShadow(
                                    color: MyColor.inactiveColor,
                                    blurRadius: 10)
                              ],
                            ).wh(40, 40),
                          ],
                        ).pOnly(top: 10, left: 16, right: 16),
                        EkuaboString.no_results_found.text.medium
                            .color(Colors.grey)
                            .size(16)
                            .makeCentered(),
                        Image.asset(
                          EkuaboAsset.bottom_image,
                          width: double.infinity,
                        ).objectBottomLeft()
                      ],
                    ),
          initState: (_) {
            _con.mostRecentBlogs = null;
            _con.getMostRecent();
          },
        ));
  }

  void _showPopupMenu(BuildContext context, int index) async {
    List<PopupMenuEntry<Object>> list = [];
    list.add(PopupMenuItem(
        value: EkuaboString.delete,
        enabled: true,
        child: VxBox(
                child: EkuaboString.delete.text
                    .size(14)
                    .medium
                    .color(MyColor.lightBlueColor)
                    .make())
            .width(120)
            .make()
            .onTap(
          () {
            _con.callDeleteBlogApi(context, index);
            Get.back();
          },
        )));
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(50, 150, 50, 50),
        items: list,
        useRootNavigator: true);
  }
}
