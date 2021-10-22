import 'dart:convert';

import 'package:ekuabo/model/apimodel/groups/group_member_model.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroupMembers extends StatefulWidget {
  final String group_id;
  const GroupMembers({Key key, this.group_id}) : super(key: key);

  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
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
      appBar: EcuaboAppBar().getAppBar(),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: memberdetail.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(memberdetail.data[index].profile),
                  ),
                  title: Text(memberdetail.data[index].username),
                );
              }),
    );
  }
}
