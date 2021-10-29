import 'dart:convert';

import 'package:ekuabo/controller/add_banner_controller.dart';
import 'package:ekuabo/model/apimodel/banner/display_banner_ads.dart';
import 'package:ekuabo/model/apimodel/searchgroup/searchgroupmodel.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/network/repository/searchgroupservices.dart';
import 'package:ekuabo/pages/home_view.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/ekuabo_asset.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/UnderlineWidget.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SearchGroup extends StatefulWidget {
  const SearchGroup({Key key}) : super(key: key);

  @override
  _SearchGroupState createState() => _SearchGroupState();
}

class _SearchGroupState extends State<SearchGroup> {
  var token = '123456789';
  final _adcon = Get.find<AddBannerController>();

  List<BannerModelData> SearchGroupHorizontalAd = [];
  List<BannerModelData> SearchGroupVerticalAd = [];
  void callads() {
    _adcon.getslotads(context, '3').then((value) {
      setState(() {
        SearchGroupHorizontalAd = value.data;
      });
    });
    _adcon.getslotads(context, '4').then((value) {
      setState(() {
        SearchGroupVerticalAd = value.data;
      });
    });
  }

  Future joinGrouprequest(String group_id) async {
    var loader = ProgressView(context);
    UserBean userBean = await PrefManager.getUser();
    loader.show();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/group_join_request.php'),
        body: {
          'token': token,
          'user_id': userBean.data.id,
          'group_id': group_id
        });
    var Response = jsonDecode(response.body);
    print(Response);
    loader.dismiss();
    return Response;
  }

  Future leaveGrouprequest(String group_id) async {
    var loader = ProgressView(context);
    UserBean userBean = await PrefManager.getUser();
    loader.show();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/leave_group.php'),
        body: {
          'token': token,
          'user_id': userBean.data.id,
          'group_id': group_id
        });
    var Response = jsonDecode(response.body);
    print(Response);
    loader.dismiss();
    return Response;
  }

  Future<SearchGroupModel> searchmodel;

  UserBean userBean;
  TextEditingController _username = TextEditingController();

  @override
  void initState() {
    searchmodel = SearchGroupServices().SearchGroupService('');
    callads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Group Panel',
                style: TextStyle(
                    color: MyColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              UnderlineWidget().getUnderlineWidget(),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 150,
                color: Color(0xffF5F5F5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(height: 40, width: 290),
                      child: TextField(
                        controller: _username,
                        onChanged: (value) {
                          setState(() {
                            value = _username.toString();
                            searchmodel = SearchGroupServices()
                                .SearchGroupService(_username.text);
                          });
                        },
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            hintText: 'Search by group name keyword',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0x70707061), width: 10),
                                borderRadius: BorderRadius.circular(40)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: Color(0xff531EE4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            setState(() {
                              searchmodel = SearchGroupServices()
                                  .SearchGroupService(_username.text);
                            });
                          },
                          child: Text(
                            'Search',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Color(0xff531EE4),
                          onPressed: () {
                            _username.clear();
                          },
                          child: Text(
                            'Clear',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<SearchGroupModel>(
                    future: searchmodel,
                    builder: (context, snapshot) {
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return null;
                      // } else {
                      //   if (snapshot.hasError)
                      //     return Center(child: Text('Network Error'));
                      //   else

                      return (snapshot.hasData)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                return (index % 5 == 0)
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 1,
                                                        spreadRadius: 2,
                                                        offset: Offset(1, 1))
                                                  ]),
                                              height: 200,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .image),
                                                                fit: BoxFit
                                                                    .contain)),
                                                      )),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(snapshot
                                                                .data
                                                                .data[index]
                                                                .groupName),
                                                            Text(snapshot
                                                                .data
                                                                .data[index]
                                                                .groupDesc),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .calendar_today,
                                                                  color: MyColor
                                                                      .mainColor
                                                                      .withOpacity(
                                                                          0.6),
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .createdDate),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                IconRow(
                                                                  icon: Icons
                                                                      .people,
                                                                  data: snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .totalMember,
                                                                  text:
                                                                      'Members',
                                                                ),
                                                                IconRow(
                                                                    data: snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .totalFeed,
                                                                    icon: Icons
                                                                        .feed,
                                                                    text:
                                                                        'Posts')
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          30),
                                                              child:
                                                                  MaterialButton(
                                                                onPressed: () {
                                                                  (snapshot.data.data[index].groupStatus ==
                                                                          'n')
                                                                      ? joinGrouprequest(snapshot
                                                                              .data
                                                                              .data[
                                                                                  index]
                                                                              .groupId)
                                                                          .then(
                                                                              (value) {
                                                                          setState(
                                                                              () {
                                                                            searchmodel =
                                                                                SearchGroupServices().SearchGroupService(_username.text);
                                                                          });
                                                                        })
                                                                      : leaveGrouprequest(snapshot
                                                                              .data
                                                                              .data[index]
                                                                              .groupId)
                                                                          .then((value) {
                                                                          setState(
                                                                              () {
                                                                            searchmodel =
                                                                                SearchGroupServices().SearchGroupService(_username.text);
                                                                          });
                                                                        });
                                                                },
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      color: MyColor
                                                                          .mainColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .logout,
                                                                      color: MyColor
                                                                          .mainColor,
                                                                    ),
                                                                    Text(
                                                                      (snapshot.data.data[index].groupStatus ==
                                                                              'n')
                                                                          ? 'Join Group'
                                                                          : (snapshot.data.data[index].groupStatus == 'p')
                                                                              ? 'Pending'
                                                                              : 'Leave Group',
                                                                      style: TextStyle(
                                                                          color:
                                                                              MyColor.mainColor),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          (SearchGroupHorizontalAd.length == 0)
                                              ? Container()
                                              : HorizontalAd(
                                                  data: SearchGroupHorizontalAd)
                                        ],
                                      )
                                    : (index % 9 == 0)
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10)),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            blurRadius: 1,
                                                            spreadRadius: 2,
                                                            offset:
                                                                Offset(1, 1))
                                                      ]),
                                                  height: 200,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10)),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .image),
                                                                    fit: BoxFit
                                                                        .contain)),
                                                          )),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .groupName),
                                                                Text(snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .groupDesc),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      color: MyColor
                                                                          .mainColor
                                                                          .withOpacity(
                                                                              0.6),
                                                                      size: 20,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .createdDate),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    IconRow(
                                                                      icon: Icons
                                                                          .people,
                                                                      data: snapshot
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .totalMember,
                                                                      text:
                                                                          'Members',
                                                                    ),
                                                                    IconRow(
                                                                        data: snapshot
                                                                            .data
                                                                            .data[
                                                                                index]
                                                                            .totalFeed,
                                                                        icon: Icons
                                                                            .feed,
                                                                        text:
                                                                            'Posts')
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          30),
                                                                  child:
                                                                      MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      (snapshot.data.data[index].groupStatus ==
                                                                              'n')
                                                                          ? joinGrouprequest(snapshot.data.data[index].groupId).then(
                                                                              (value) {
                                                                              setState(() {
                                                                                searchmodel = SearchGroupServices().SearchGroupService(_username.text);
                                                                              });
                                                                            })
                                                                          : leaveGrouprequest(snapshot.data.data[index].groupId)
                                                                              .then((value) {
                                                                              setState(() {
                                                                                searchmodel = SearchGroupServices().SearchGroupService(_username.text);
                                                                              });
                                                                            });
                                                                    },
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                          color:
                                                                              MyColor.mainColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .logout,
                                                                          color:
                                                                              MyColor.mainColor,
                                                                        ),
                                                                        Text(
                                                                          (snapshot.data.data[index].groupStatus == 'n')
                                                                              ? 'Join Group'
                                                                              : (snapshot.data.data[index].groupStatus == 'p')
                                                                                  ? 'Pending'
                                                                                  : 'Leave Group',
                                                                          style:
                                                                              TextStyle(color: MyColor.mainColor),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              (SearchGroupVerticalAd.length ==
                                                      0)
                                                  ? Container()
                                                  : VerticalAd(
                                                      data:
                                                          SearchGroupVerticalAd)
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 1,
                                                        spreadRadius: 2,
                                                        offset: Offset(1, 1))
                                                  ]),
                                              height: 200,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .image),
                                                                fit: BoxFit
                                                                    .contain)),
                                                      )),
                                                  Expanded(
                                                      flex: 3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(snapshot
                                                                .data
                                                                .data[index]
                                                                .groupName),
                                                            Text(snapshot
                                                                .data
                                                                .data[index]
                                                                .groupDesc),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .calendar_today,
                                                                  color: MyColor
                                                                      .mainColor
                                                                      .withOpacity(
                                                                          0.6),
                                                                  size: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .createdDate),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                IconRow(
                                                                  icon: Icons
                                                                      .people,
                                                                  data: snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .totalMember,
                                                                  text:
                                                                      'Members',
                                                                ),
                                                                IconRow(
                                                                    data: snapshot
                                                                        .data
                                                                        .data[
                                                                            index]
                                                                        .totalFeed,
                                                                    icon: Icons
                                                                        .feed,
                                                                    text:
                                                                        'Posts')
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right:
                                                                          30),
                                                              child:
                                                                  MaterialButton(
                                                                onPressed: () {
                                                                  (snapshot.data.data[index].groupStatus ==
                                                                          'n')
                                                                      ? joinGrouprequest(snapshot
                                                                              .data
                                                                              .data[
                                                                                  index]
                                                                              .groupId)
                                                                          .then(
                                                                              (value) {
                                                                          setState(
                                                                              () {
                                                                            searchmodel =
                                                                                SearchGroupServices().SearchGroupService(_username.text);
                                                                          });
                                                                        })
                                                                      : leaveGrouprequest(snapshot
                                                                              .data
                                                                              .data[index]
                                                                              .groupId)
                                                                          .then((value) {
                                                                          setState(
                                                                              () {
                                                                            searchmodel =
                                                                                SearchGroupServices().SearchGroupService(_username.text);
                                                                          });
                                                                        });
                                                                },
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  side: BorderSide(
                                                                      color: MyColor
                                                                          .mainColor),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .logout,
                                                                      color: MyColor
                                                                          .mainColor,
                                                                    ),
                                                                    Text(
                                                                      (snapshot.data.data[index].groupStatus ==
                                                                              'n')
                                                                          ? 'Join Group'
                                                                          : (snapshot.data.data[index].groupStatus == 'p')
                                                                              ? 'Pending'
                                                                              : 'Leave Group',
                                                                      style: TextStyle(
                                                                          color:
                                                                              MyColor.mainColor),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                              })
                          : Container();
                      // }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  final String data;
  final IconData icon;
  final String text;
  const IconRow({
    Key key,
    @required this.data,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey,
        ),
        Text('  ${data}' + '  ${text}'),
      ],
    );
  }
}
