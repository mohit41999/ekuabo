import 'dart:convert';

import 'package:ekuabo/model/apimodel/group/GroupdetailsModel.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroupDetailsServices {
  String token = '123456789';

  Future<GroupDetailsModel> getgroupdetails(String group_id) async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/group_details.php'),
        body: {
          'token': token,
          'user_id': userBean.data.id,
          'group_id': group_id
        });

    var Response = jsonDecode(response.body);
    print(Response['data']['group_feed']);
    if (Response['data']['group_feed'].toString() == [[]].toString()) {
      print('yessssssssssssssssssssss');
      return null;
    } else {
      return GroupDetailsModel.fromJson(jsonDecode(response.body));
    }
  }
}
