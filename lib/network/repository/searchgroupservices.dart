import 'dart:convert';

import 'package:ekuabo/model/apimodel/market_place/searchMarketplaceModel.dart';
import 'package:ekuabo/model/apimodel/searchgroup/searchgroupmodel.dart';
import 'package:ekuabo/model/apimodel/user_bean.dart';
import 'package:ekuabo/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const URL = 'https://eku-abo.com/api/group/search_group_list.php';

class SearchGroupServices {
  UserBean userBean;
  Future<SearchGroupModel> SearchGroupService(String keyword) async {
    userBean = await PrefManager.getUser();
    var response = await http.post(Uri.parse(URL), body: {
      'token': '123456789',
      'user_id': userBean.data.id,
      'search_keyword': keyword
    });
    print(jsonDecode(response.body));

    return SearchGroupModel.fromJson(jsonDecode(response.body));
  }

  Future<SearchMarketplaceModel> searchMarketplace(
      {String search_keyword,
      String category_id,
      String sub_category_id,
      String filter}) async {
    userBean = await PrefManager.getUser();
    var response = await http.post(
        Uri.parse('https://eku-abo.com/api/marketplace/search_marketplace.php'),
        body: {
          'token': '123456789',
          'user_id': userBean.data.id,
          'search_keyword': search_keyword,
          'category_id': category_id,
          'sub_category_id': sub_category_id,
          'filter': filter
        });
    var Response = jsonDecode(response.body);
    print(Response.toString() + 'lllllllllll');
    return SearchMarketplaceModel.fromJson(Response);
  }
}
