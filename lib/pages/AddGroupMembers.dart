import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddGroupMembers extends StatefulWidget {
  final String group_name;
  const AddGroupMembers({Key key, @required this.group_name}) : super(key: key);

  @override
  _AddGroupMembersState createState() => _AddGroupMembersState();
}

class _AddGroupMembersState extends State<AddGroupMembers> {
  String Token = '123456789';
  List Members = [];
  Future getMembers() async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/get_user_list_group_invation.php'),
        body: {
          'token': Token,
          'user_id': userBean.data.id,
        });
    var Response = jsonDecode(response.body);
    print(Response);
    return Response;
  }

  Future sendGroupInvitation(String email, String group_id) async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/send_group_invitation.php'),
        body: {
          'token': Token,
          'user_id': userBean.data.id,
          'invatatinon_user_email': email,
          'group_id': group_id
        });
    var Response = jsonDecode(response.body);
    print(Response);
    return Response;
  }

  @override
  void initState() {
    getMembers().then((value) {
      setState(() {
        Members = value['data'];
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcuaboAppBar().getAppBar(context),
      body: ListView.builder(
          itemCount: Members.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: CachedNetworkImage(
                imageUrl: Members[index]['profile_picture'],
                placeholder: (_, __) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (_, __, ___) =>
                    Image.asset('asset/images/error_img.jpg'),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              title: Text(Members[index]['name']),
              trailing: Icon(Icons.add_circle),
              children: [
                Text('My Groups'),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: Members[index]["group_info"].length,
                    itemBuilder: (context, ind) {
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: Members[index]["group_info"][ind]
                              ["group_img"],
                          placeholder: (_, __) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (_, __, ___) =>
                              Image.asset('asset/images/error_img.jpg'),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                            Members[index]["group_info"][ind]["group_name"]),
                        trailing: ElevatedButton(
                            onPressed: () {
                              sendGroupInvitation(
                                      Members[index]['email'],
                                      Members[index]["group_info"][ind]
                                          ["group_id"])
                                  .then((value) {
                                getMembers().then((value) {
                                  setState(() {
                                    Members = value['data'];
                                  });
                                });
                              });
                            },
                            child: (Members[index]["group_info"][ind]
                                            ["invite_status"]
                                        .toString() ==
                                    'n')
                                ? Text('Send Invitation')
                                : Text('Pending')),
                      );
                    })
              ],
            );
          }),
    );
  }
}
