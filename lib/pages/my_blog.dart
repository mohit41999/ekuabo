import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/blog_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';

import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_route.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyBlog extends StatefulWidget {
  @override
  _MyBlogState createState() => _MyBlogState();
}

class _MyBlogState extends State<MyBlog> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<BlogController>();
  var user_id = '';
  initialize() async {
    await PrefManager.getUser().then((value) {
      setState(() {
        user_id = value.data.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: EcuaboAppBar(),
        drawer: CommonNavigationDrawer(),
        body: GetBuilder<BlogController>(
          builder: (_) => _con.mostRecentBlogs == null
              ? Stack(
                  //fit: StackFit.expand,
                  children: [
                    Image.asset(
                      EkuaboAsset.bottom_image,
                      width: double.infinity,
                    ).objectBottomLeft(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () =>
                                        _homeController.bottomNavPop(context),
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: MyColor.mainColor,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'My blogs'
                                        .text
                                        .heightTight
                                        .size(16)
                                        .medium
                                        .make(),
                                    UnderlineWidget().getUnderlineWidget()
                                  ],
                                ),
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
                                    color: MyColor.inactiveColor,
                                    blurRadius: 10)
                              ],
                            ).wh(40, 40),
                          ],
                        ).pOnly(top: 10, left: 16, right: 16),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
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
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () => _homeController
                                              .bottomNavPop(context),
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: MyColor.mainColor,
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          'My blogs'
                                              .text
                                              .heightTight
                                              .size(16)
                                              .medium
                                              .make(),
                                          UnderlineWidget().getUnderlineWidget()
                                        ],
                                      ),
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
                                child: ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    return (_con.mostRecentBlogs[index]
                                                .profileDetails.userId
                                                .toString() ==
                                            user_id.toString())
                                        ? VxCard(Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: VxBox(
                                                            child:
                                                                CachedNetworkImage(
                                                      imageUrl: _con
                                                          .mostRecentBlogs[
                                                              index]
                                                          .blogImage,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(),
                                                      errorWidget:
                                                          (_, __, ___) {
                                                        return Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'asset/images/error_img.jpg'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        );
                                                      },
                                                    ))
                                                        .width(100)
                                                        .height(100)
                                                        .bottomLeftRounded(
                                                            value: 12)
                                                        .makeCentered()
                                                        .pOnly(left: 20),
                                                  ),
                                                  (_con
                                                              .mostRecentBlogs[
                                                                  index]
                                                              .profileDetails
                                                              .userId
                                                              .toString() ==
                                                          user_id.toString())
                                                      ? const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ).onTap(() =>
                                                          showmenu(index)
                                                              .then((value) {
                                                            setState(() {
                                                              _con.getMostRecent();
                                                            });
                                                          }))
                                                      : Container(),
                                                ],
                                              ),
                                              _con.mostRecentBlogs[index]
                                                  .blogTitle.text
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
                                                  data: _con
                                                      .mostRecentBlogs[index]
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
                                                            .mostRecentBlogs[
                                                                index]
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
                                                            .mostRecentBlogs[
                                                                index]
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
                                                    child: _con
                                                        .mostRecentBlogs[index]
                                                        .created
                                                        .text
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
                                                .pushNamed(
                                                    EkuaboRoute.blog_detail,
                                                    arguments: _con
                                                        .mostRecentBlogs[index]
                                                        .blogId);
                                            _homeController.navigationQueue
                                                .addLast(3);
                                          }).pOnly(top: 10, left: 10, right: 10)
                                        : Container();
                                  },
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: _con.mostRecentBlogs.length,
                                  // gridDelegate:
                                  //     SliverGridDelegateWithFixedCrossAxisCount(
                                  //   crossAxisCount: 2,
                                  //   childAspectRatio: 2 / 4,
                                  // ),
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
            initialize();
          },
        ));
  }

  Future showmenu(int index) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are you Sure you Want to delete ?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          _con.callDeleteBlogApi(context, index);
                          Navigator.pop(context);
                        },
                        child: Text('Ok')),
                  ],
                )
              ],
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
            Get.back();
          },
        )));
    await showMenu(
        context: context,
        position: RelativeRect.fill,
        items: list,
        useRootNavigator: true);
  }
}
