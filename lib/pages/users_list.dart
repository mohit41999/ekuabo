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
  final _con = Get.find<PrivateMessageBoardController>();

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

  @override
  void initState() {
    getusers().then((value) {
      setState(() {
        UsersList = value['data'];
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
          itemCount: UsersList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: UsersList[index]['profile_picture'],
                placeholder: (_, __) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (_, __, ___) =>
                    Image.asset('asset/images/error_img.jpg'),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              title: Text(UsersList[index]['name']),
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
                                username: UsersList[index]['name'],
                                chatId: UsersList[index]['user_id'],
                              ))).then((value) {
                    _con.getChatList();
                  });
                },
              ),
            );
          }),
    );
  }
}
