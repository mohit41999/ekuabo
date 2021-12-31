import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/blog_detail_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/blog/blog_detail_model.dart';

import 'package:ekuabo/model/apimodel/blog/most_recent_blog.dart';
import 'package:ekuabo/network/service/http_service_impl.dart';
import 'package:ekuabo/pages/blog.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class BlogDetail extends StatefulWidget {
  String blogId;

  BlogDetail({this.blogId});

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  final _homeController = Get.find<HomeController>();

  final _con = Get.find<BlogDetailController>();
  bool loading = true;
  BlogDetailsModel BlogDetails;

  Future<BlogDetailsModel> getblogDetails() async {
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/blog/single_blog_details.php'),
        body: {'token': HttpServiceImpl().TOKEN, 'blog_id': widget.blogId});
    return BlogDetailsModel.fromJson(jsonDecode(response.body));
  }

  void initialize() async {
    await getblogDetails().then((value) {
      setState(() {
        BlogDetails = value;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcuaboAppBar(),
      drawer: CommonNavigationDrawer(),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _homeController.bottomNavigatorKey.currentState
                                .pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: MyColor.mainColor,
                            size: 24,
                          )),
                      10.widthBox,
                      Flexible(
                        child: BlogDetails.data[0].blogTitle.text
                            .maxLines(1)
                            .ellipsis
                            .size(18)
                            .medium
                            .make(),
                      )
                    ],
                  ),
                  VxCard(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        fit: StackFit.loose,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VxBox(
                                      child: Hero(
                                          tag: "Blog",
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                BlogDetails.data[0].blogImage,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                          )))
                                  .width(
                                      MediaQuery.of(context).size.width * 0.75)
                                  .height(134)
                                  .bottomLeftRounded(value: 12)
                                  .make()
                                  .pOnly(top: 10, left: 20),
                              10.widthBox,
                              // Icon(Icons.more_vert_outlined)
                            ],
                          ),
                          SizedBox(
                              width: 60,
                              height: 60,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    BlogDetails.data[0].userProfile),
                              )).pOnly(top: 120).objectTopCenter()
                        ],
                      ),
                      16.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            EkuaboAsset.ic_calender,
                            width: 16,
                            height: 16,
                          ),
                          10.widthBox,
                          BlogDetails.data[0].created.text
                              .size(12)
                              .medium
                              .make()
                        ],
                      ),
                      10.heightBox,
                      Html(
                        data: BlogDetails.data[0].blogDesc,
                        /*.text
                   .align(TextAlign.justify)
                   .size(12)
                   .medium
                   .make()*/
                      ).pOnly(left: 10, right: 10),
                      10.heightBox,
                      VxBox(
                              child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(minHeight: 10, maxHeight: 40),
                              child: TextFormField(
                                controller: _con.commentCtl,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    // constraints: BoxConstraints(minHeight:10,maxHeight: 40),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: MyColor.mainColor))),
                              ),
                            ),
                          ),
                          10.widthBox,
                          Image.asset(
                            EkuaboAsset.ic_send2,
                            width: 16,
                            height: 16,
                          ).onTap(() => _con
                                  .callAddCommentApi(context, widget.blogId)
                                  .then((value) {
                                initialize();
                              }))
                        ],
                      ).p(10))
                          .color(MyColor.lightGrey)
                          .bottomLeftRounded(value: 12)
                          .height(60)
                          .make()
                          .pOnly(left: 10, right: 10, top: 16),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              EkuaboString.comments.text
                                  .size(16)
                                  .medium
                                  .make()
                                  .pOnly(left: 10),
                              Icon((_con.isExpand)
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down)
                            ],
                          ).onTap(() {
                            setState(() {
                              _con.isExpand = !_con.isExpand;
                            });
                          }),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    onPressed: () {
                                      _con.ReportBlog(context, widget.blogId)
                                          .then((value) =>
                                              Navigator.pop(context));
                                    },
                                    child: const Text('Report')),
                              ))
                        ],
                      ),
                      10.heightBox,
                      (_con.isExpand)
                          ? (BlogDetails.data[0].totalComment == 0)
                              ? EkuaboString.no_comment_found.text
                                  .size(11)
                                  .medium
                                  .color(MyColor.blackColor.withOpacity(0.6))
                                  .make()
                                  .pOnly(left: 10)
                              : Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            BlogDetails.data[0].comment.length,
                                        itemBuilder: (context, int index) {
                                          var comment = BlogDetails
                                              .data[0].comment[index];
                                          return VxBox(
                                                  child: Row(
                                            children: [
                                              CircleAvatar(
                                                child: CachedNetworkImage(
                                                  imageUrl: comment.userDetails
                                                          .profile ??
                                                      '',
                                                  placeholder: (_, __) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (_, __, ___) =>
                                                      Icon(Icons.person),
                                                  width: 24,
                                                  height: 24,
                                                ),
                                              ),
                                              10.widthBox,
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  comment.userDetails.username
                                                      .text.medium
                                                      .size(10)
                                                      .color(MyColor.mainColor)
                                                      .make(),
                                                  5.heightBox,
                                                  comment.comment.text.medium
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
                                                  left: 10, right: 10, top: 10);
                                        }),
                                  ],
                                )
                          : Container(),
                    ],
                  ).p(5).pOnly(bottom: 20))
                      .withRounded(value: 7)
                      .elevation(5)
                      .make(),
                  Image.asset(
                    EkuaboAsset.bottom_image,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            ),
    );
  }
}
