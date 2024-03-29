import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ekuabo/controller/private_msg_controller.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/pages/chat_new_user_converstaion.dart';
import 'package:ekuabo/utils/color.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/widgets/EcuaboAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  String Token = '123456789';
  List UsersList = [];
  List results = [];
  final _con = Get.find<PrivateMessageBoardController>();
  TextEditingController _username = TextEditingController();

  Future getusers() async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http
        .post(Uri.parse('https://eku-abo.com/api/get_chat_user.php'), body: {
      'token': Token,
      'user_id': userBean.data.id,
    });

    var Response = jsonDecode(response.body);
    return Response;
  }

  List _foundUsers = [];
  @override
  void initState() {
    getusers().then((value) {
      setState(() {
        UsersList = value['data'];
        _foundUsers = UsersList;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = UsersList;
      // results = [];
    } else {
      results = UsersList.where((user) =>
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
                  return ListTile(
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
                    trailing: IconButton(
                      icon: Icon(
                        Icons.chat,
                        color: MyColor.mainColor,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatNewUserConversation(
                                      username: _foundUsers[index]['name'],
                                      chatId: _foundUsers[index]['user_id'],
                                    ))).then((value) {
                          _con.getChatList();
                        });
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
