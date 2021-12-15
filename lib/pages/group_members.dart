import 'dart:convert';

import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/groups/group_member_model.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/pages/add_group_members.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GroupMembers extends StatefulWidget {
  final String group_id;
  final String group_name;
  final bool notgrpmemeber;
  final bool admin;
  const GroupMembers(
      {Key key,
      this.group_id,
      this.group_name,
      this.notgrpmemeber = false,
      this.admin = false})
      : super(key: key);

  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  final _homeController = Get.find<HomeController>();
  String Token = '123456789';
  GroupMemberModel memberdetail;
  bool loading = true;

  Future<GroupMemberModel> initialize() async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http
        .post(Uri.parse('https://eku-abo.com/api/getGroupMember.php'), body: {
      'token': Token,
      'user_id': userBean.data.id,
      'group_id': widget.group_id
    });
    var Response = jsonDecode(response.body);
    print(Response);
    return GroupMemberModel.fromJson(Response);
  }

  @override
  void initState() {
    print(widget.group_id.toString() + 'qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
    initialize().then((value) {
      setState(() {
        memberdetail = value;
        loading = false;
      });
      return value;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (widget.notgrpmemeber)
          ? null
          : (widget.admin)
              ? FloatingActionButton.extended(
                  backgroundColor: MyColor.mainColor,
                  label: Text(
                    'Add Memebers +',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _homeController.navigationQueue.addLast(0);
                    _homeController.bottomNavigatorKey.currentState
                        .push(MaterialPageRoute(
                            builder: (context) => AddGroupMembers(
                                  group_name: widget.group_name,
                                )));
                  },
                  // tooltip: ,
                )
              : null,
      appBar: EcuaboAppBar(),
      drawer: CommonNavigationDrawer(),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Text(
                  widget.group_name,
                  style: TextStyle(
                      color: MyColor.mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: memberdetail.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(memberdetail.data[index].profile),
                          ),
                          title: Text('${memberdetail.data[index].username}'),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
