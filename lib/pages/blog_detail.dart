import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/blog_detail_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';

import 'package:ekuabo/model/apimodel/blog/most_recent_blog.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogDetail extends StatelessWidget {
  MostRecentBlogData mostRecentBlogData;
  BlogDetail({this.mostRecentBlogData});
  final _homeController = Get.find<HomeController>();
  final _con = Get.find<BlogDetailController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcuaboAppBar().getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _homeController.bottomNavigatorKey.currentState.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyColor.mainColor,
                      size: 24,
                    )),
                10.widthBox,
                Flexible(
                  child: mostRecentBlogData.blogTitle.text
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
                                      imageUrl: mostRecentBlogData.blogImage,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                    )))
                            .width(MediaQuery.of(context).size.width * 0.75)
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
                          child: Image.asset(EkuaboAsset.avatar),
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
                    mostRecentBlogData.created.text.size(12).medium.make()
                  ],
                ),
                10.heightBox,
                Html(
                  data: mostRecentBlogData.blogDesc,
                  /*.text
                   .align(TextAlign.justify)
                   .size(12)
                   .medium
                   .make()*/
                ).pOnly(left: 10, right: 10),
                10.heightBox,
                EkuaboString.comments.text
                    .size(16)
                    .medium
                    .make()
                    .pOnly(left: 10),
                10.heightBox,
                EkuaboString.no_comment_found.text
                    .size(11)
                    .medium
                    .color(MyColor.blackColor.withOpacity(0.6))
                    .make()
                    .pOnly(left: 10),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide(
                                      width: 1, color: MyColor.mainColor))),
                        ),
                      ),
                    ),
                    10.widthBox,
                    Image.asset(
                      EkuaboAsset.ic_send2,
                      width: 16,
                      height: 16,
                    ).onTap(() => _con.callAddCommentApi(
                        context, mostRecentBlogData.blogId))
                  ],
                ).p(10))
                    .color(MyColor.lightGrey)
                    .bottomLeftRounded(value: 12)
                    .height(60)
                    .make()
                    .pOnly(left: 10, right: 10, top: 16)
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
