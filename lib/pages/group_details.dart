import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/model/apimodel/group/GroupdetailsModel.dart';
import 'package:ekuabo/network/repository/group_details_services.dart';
import 'package:ekuabo/pages/group_members.dart';
import 'package:ekuabo/pages/post_new_groupFeed.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/ekuabo_string.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:velocity_x/velocity_x.dart';

class GroupDetails extends StatefulWidget {
  final String group_id;
  final String created_date;
  final String image_url;
  final String grp_name;
  final String members;

  const GroupDetails(
      {Key key,
      @required this.group_id,
      @required this.created_date,
      @required this.image_url,
      @required this.grp_name,
      this.members})
      : super(key: key);

  @override
  _GroupDetailsState createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  Future<GroupDetailsModel> groupmodel;
  GroupDetailsModel _groupModel;
  bool loading = true;
  bool isgroupfeed = false;
  void inititalize() {
    groupmodel =
        GroupDetailsServices().getgroupdetails(widget.group_id).then((value) {
      setState(() {
        _groupModel = value;
        print(value);
        loading = false;
      });
      return value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      inititalize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostNewGroupFeed(
                        group_id: widget.group_id,
                      ))).then((value) {
            inititalize();
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: MyColor.mainColor,
      ),
      appBar: EcuaboAppBar().getAppBar(context),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : (_groupModel == null)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.grp_name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          VxCircle(
                            backgroundColor: MyColor.mainColor,
                            child: const Icon(
                              Icons.people,
                              color: Colors.white,
                            ).onFeedBackTap(() async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GroupMembers(
                                            group_id: widget.group_id,
                                            group_name: widget.grp_name,
                                          )));
                            }),
                            shadows: const [
                              BoxShadow(
                                  color: MyColor.inactiveColor, blurRadius: 10)
                            ],
                          ).wh(40, 40)
                        ],
                      ),
                      UnderlineWidget().getUnderlineWidget(),
                      Container(
                        color: Color(0xffF5F5F5),
                        height: 280,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(widget.image_url),
                                        fit: BoxFit.cover)),
                                height: 200,
                                width: double.infinity,
                              ),
                            ),
                            commonRow(
                              iconColor: MyColor.mainColor,
                              iconData: Icons.calendar_today,
                              data: widget.created_date,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonRow(
                                    data: '${widget.members} Members',
                                    iconData: Icons.people,
                                    iconColor: Colors.grey),
                                SizedBox(
                                  width: 15,
                                ),
                                commonRow(
                                    data: '0 Posts',
                                    iconData: Icons.bookmark,
                                    iconColor: Colors.grey),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _groupModel.data.groupDetails.groupName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            VxCircle(
                              backgroundColor: MyColor.mainColor,
                              child: const Icon(
                                Icons.people,
                                color: Colors.white,
                              ).onFeedBackTap(() async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupMembers(
                                              group_id: widget.group_id,
                                              group_name: widget.grp_name,
                                            )));
                              }),
                              shadows: const [
                                BoxShadow(
                                    color: MyColor.inactiveColor,
                                    blurRadius: 10)
                              ],
                            ).wh(40, 40)
                          ],
                        ),
                        UnderlineWidget().getUnderlineWidget(),
                        Container(
                          color: Color(0xffF5F5F5),
                          height: 280,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(_groupModel
                                              .data.groupDetails.image),
                                          fit: BoxFit.cover)),
                                  height: 200,
                                  width: double.infinity,
                                ),
                              ),
                              commonRow(
                                iconColor: MyColor.mainColor,
                                iconData: Icons.calendar_today,
                                data: _groupModel.data.groupDetails.createdDate,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  commonRow(
                                      data: _groupModel
                                              .data.groupDetails.totalMember +
                                          ' Members',
                                      iconData: Icons.people,
                                      iconColor: Colors.grey),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  commonRow(
                                      data: _groupModel
                                              .data.groupDetails.totalFeed +
                                          ' Posts',
                                      iconData: Icons.bookmark,
                                      iconColor: Colors.grey),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _groupModel.data.groupFeed.length,
                            itemBuilder: (context, index) {
                              return VxCard(Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          _groupModel.data.groupFeed[index]
                                              .createdDate.text
                                              .size(10)
                                              .make()
                                        ],
                                      )
                                    ],
                                  ).p(5),
                                  VxBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                child: CachedNetworkImage(
                                                  imageUrl: _groupModel
                                                      .data
                                                      .groupFeed[index]
                                                      .userFeedDetails
                                                      .profile,
                                                  width: 24,
                                                  height: 24,
                                                  fit: BoxFit.cover,
                                                  placeholder: (_, __) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (_, __, ___) =>
                                                      Icon(Icons.person),
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  (_groupModel
                                                              .data
                                                              .groupFeed[index]
                                                              .userFeedDetails
                                                              .username ==
                                                          null)
                                                      ? Text('anonymous')
                                                      : _groupModel
                                                          .data
                                                          .groupFeed[index]
                                                          .userFeedDetails
                                                          .username
                                                          .text
                                                          .bold
                                                          .size(12)
                                                          .make(),
                                                  5.heightBox,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        EkuaboAsset.ic_location,
                                                        width: 12,
                                                        height: 12,
                                                        color: MyColor
                                                            .inactiveColor,
                                                      ),
                                                      5.widthBox,
                                                      (_groupModel
                                                                  .data
                                                                  .groupFeed[
                                                                      index]
                                                                  .userFeedDetails
                                                                  .location ==
                                                              null)
                                                          ? Text('anonymous')
                                                          : _groupModel
                                                              .data
                                                              .groupFeed[index]
                                                              .userFeedDetails
                                                              .location
                                                              .text
                                                              .light
                                                              .size(10)
                                                              .make()
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Html(
                                        data: _groupModel
                                            .data.groupFeed[index].message,
                                      )
                                          /*newsFeed.message.text
                                  .size(12)
                                  .bold
                                  .make()*/
                                          .pOnly(left: 10),
                                      16.heightBox,
                                      CachedNetworkImage(
                                        imageUrl: _groupModel.data
                                                .groupFeed[index].uploadPath ??
                                            '',
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (_, __, ___) =>
                                            Image.asset(
                                          EkuaboAsset.no_image,
                                          width: double.infinity,
                                          height: 192,
                                          fit: BoxFit.cover,
                                        ),
                                      ).pOnly(left: 10, right: 10),
                                      16.heightBox,
                                      ""
                                          .text
                                          .size(10)
                                          .light
                                          .align(TextAlign.justify)
                                          .color(MyColor.blackColor
                                              .withOpacity(0.6))
                                          .make()
                                          .pOnly(left: 10, right: 10),
                                      10.heightBox,
                                      Row(
                                        children: [
                                          Image.asset(
                                            _groupModel.data.groupFeed[index]
                                                        .isUserLike ==
                                                    "n"
                                                ? EkuaboAsset.ic_like
                                                : EkuaboAsset.ic_liked,
                                            width: 16,
                                            height: 16,
                                          ).onTap(() {
                                            // if (_groupModel.data.groupFeed[index].isUserLike == "n")
                                            //   _con.like(context, newsFeed.feedId);
                                            // else
                                            //   _con.unlike(context, newsFeed.feedId);
                                          }),
                                          30.widthBox,
                                          Image.asset(
                                            EkuaboAsset.ic_comment,
                                            width: 16,
                                            height: 16,
                                          ).onTap(() {
                                            _groupModel.data.groupFeed[index]
                                                    .isCommentExpand =
                                                !_groupModel
                                                    .data
                                                    .groupFeed[index]
                                                    .isCommentExpand;
                                            // _con.update();
                                          }),
                                          30.widthBox,
                                          Image.asset(
                                            EkuaboAsset.ic_share,
                                            width: 16,
                                            height: 16,
                                          ).onTap(() {}),
                                          _groupModel.data.groupFeed[index]
                                                      .isUserReported ==
                                                  "n"
                                              ? EkuaboString.report.text
                                                  .color(MyColor.mainColor
                                                      .withOpacity(0.6))
                                                  .size(10)
                                                  .light
                                                  .underline
                                                  .make()
                                                  .onTap(() {})
                                                  .pOnly(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44)
                                              : SizedBox(),
                                        ],
                                      ).pOnly(left: 10, right: 10),
                                      _groupModel.data.groupFeed[index]
                                              .isCommentExpand
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                16.heightBox,
                                                EkuaboString.comments.text.bold
                                                    .size(14)
                                                    .make(),
                                                10.heightBox,
                                                _groupModel
                                                        .data
                                                        .groupFeed[index]
                                                        .comment
                                                        .isEmpty
                                                    ? EkuaboString
                                                        .no_comments_yet
                                                        .text
                                                        .medium
                                                        .size(12)
                                                        .make()
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: _groupModel
                                                            .data
                                                            .groupFeed[index]
                                                            .comment
                                                            .length,
                                                        itemBuilder:
                                                            (ctx, ind) {
                                                          var comment =
                                                              _groupModel
                                                                  .data
                                                                  .groupFeed[
                                                                      index]
                                                                  .comment[ind];
                                                          return VxBox(
                                                                  child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: comment
                                                                          .userDetails
                                                                          .profile ??
                                                                      '',
                                                                  placeholder: (_,
                                                                          __) =>
                                                                      CircularProgressIndicator(),
                                                                  errorWidget: (_,
                                                                          __,
                                                                          ___) =>
                                                                      Icon(Icons
                                                                          .person),
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
                                                                      .comment
                                                                      .text
                                                                      .medium
                                                                      .size(10)
                                                                      .make(),
                                                                ],
                                                              )
                                                            ],
                                                          ).p(10))
                                                              .width(double
                                                                  .infinity)
                                                              .withRounded(
                                                                  value: 7)
                                                              .color(MyColor
                                                                  .lightGrey)
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
                                                imageUrl: '',
                                                width: 24,
                                                height: 24,
                                                placeholder: (_, __) =>
                                                    CircularProgressIndicator(),
                                                errorWidget: (_, __, ___) =>
                                                    Icon(Icons.account_circle),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: EkuaboString
                                                    .insert_comments_here,
                                                hintStyle: TextStyle(
                                                    color: MyColor.blackColor
                                                        .withOpacity(0.4),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Image.asset(
                                              EkuaboAsset.ic_send,
                                              width: 16,
                                              height: 16,
                                            ).onTap(() {}),
                                          )
                                        ],
                                      )
                                          .backgroundColor(
                                              Colors.blueGrey.shade50)
                                          .pOnly(top: 20)
                                    ],
                                  )).white.make().p2()
                                ],
                              ))
                                  .color(Colors.blueGrey.shade50)
                                  .withRounded(value: 7)
                                  .make()
                                  .pOnly(top: 16);
                            }),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class commonRow extends StatelessWidget {
  final String data;
  final IconData iconData;
  final Color iconColor;

  const commonRow(
      {Key key,
      @required this.data,
      @required this.iconData,
      @required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        Text(data)
      ],
    );
  }
}
