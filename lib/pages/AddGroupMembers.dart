import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddGroupMembers extends StatefulWidget {
  final String group_name;
  const AddGroupMembers({Key key, @required this.group_name}) : super(key: key);

  @override
  _AddGroupMembersState createState() => _AddGroupMembersState();
}

class _AddGroupMembersState extends State<AddGroupMembers> {
  final _homeController = Get.find<HomeController>();
  String Token = '123456789';
  List Members = [];
  List _foundUsers = [];
  TextEditingController _username = TextEditingController();
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

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      //results = Members;
      results = [];
    } else {
      results = Members.where((user) =>
              user['name'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcuaboAppBar(),
      drawer: CommonNavigationDrawer(),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: 40, width: 290),
            child: TextField(
              controller: _username,
              onChanged: (value) {
                setState(() {
                  _runFilter(_username.text);
                });
              },
              decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  hintText: 'Search username',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0x70707061), width: 10),
                      borderRadius: BorderRadius.circular(40)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40))),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: CachedNetworkImage(
                      imageUrl: _foundUsers[index]['profile_picture'],
                      placeholder: (_, __) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (_, __, ___) =>
                          Image.asset('asset/images/error_img.jpg'),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(_foundUsers[index]['name']),
                    trailing: Icon(Icons.add_circle),
                    children: [
                      Text('My Groups'),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _foundUsers[index]["group_info"].length,
                          itemBuilder: (context, ind) {
                            return ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: _foundUsers[index]["group_info"][ind]
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
                              title: Text(_foundUsers[index]["group_info"][ind]
                                  ["group_name"]),
                              trailing: ElevatedButton(
                                  onPressed: () {
                                    sendGroupInvitation(
                                            _foundUsers[index]['email'],
                                            _foundUsers[index]["group_info"]
                                                [ind]["group_id"])
                                        .then((value) {
                                      getMembers().then((value) {
                                        setState(() {
                                          _foundUsers = value['data'];
                                        });
                                      });
                                    });
                                  },
                                  child: (_foundUsers[index]["group_info"][ind]
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
          ),
        ],
      ),
    );
  }
}
