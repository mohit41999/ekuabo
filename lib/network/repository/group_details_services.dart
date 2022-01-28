import 'dart:convert';

import 'package:ekuabo/model/apimodel/group/GroupdetailsModel.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:ekuabo/utils/utils.dart';
import 'package:ekuabo/widgets/progress_view.dart';
import 'package:flutter/cupertino.dart';
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

  Future likefeed(String feed_id) async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/group_feed_add_like.php'),
        body: {
          'token': token,
          'user_id': userBean.data.id,
          'feed_id': feed_id
        });

    var Response = jsonDecode(response.body);
    print(Response);
  }

  Future unlikefeed(String feed_id) async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/group_feed_unlike.php'),
        body: {
          'token': token,
          'user_id': userBean.data.id,
          'feed_id': feed_id
        });

    var Response = jsonDecode(response.body);
    print(Response);
  }

  Future commentgroupfeed(String feed_id, String comment) async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/add_comment_group_feed.php'),
        body: {
          'token': token,
          'user_id': userBean.data.id,
          'feed_id': feed_id,
          'comment': comment
        });

    var Response = jsonDecode(response.body);
    print(Response);
  }

  Future reportgroupfeed(BuildContext context, String feed_id) async {
    var loader = ProgressView(context);
    loader.show();
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/feed/feed_add_reported.php'),
        body: {
          'token': token,
          'user_id': userBean.data.id,
          'feed_id': feed_id,
        });
    loader.dismiss();
    var Response = jsonDecode(response.body);
    if (!Response['status']) {
      Utils().showSnackBar(context, Response['message']);
    } else {
      Utils().showSnackBar(context, Response['message']);
    }
    print(Response);
  }

  Future deletegroupfeed(String feed_id, String userID) async {
    UserBean userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/group/delete_group_feed.php'),
        body: {
          'token': token,
          'user_id': userID,
          'feed_id': feed_id,
        });

    var Response = jsonDecode(response.body);
    print(Response);
  }
}
