// To parse this JSON data, do
//
//     final searchGroupModel = searchGroupModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchGroupModel searchGroupModelFromJson(String str) => SearchGroupModel.fromJson(json.decode(str));

String searchGroupModelToJson(SearchGroupModel data) => json.encode(data.toJson());

class SearchGroupModel {
  SearchGroupModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory SearchGroupModel.fromJson(Map<String, dynamic> json) => SearchGroupModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    @required this.groupId,
    @required this.groupName,
    @required this.groupDesc,
    @required this.image,
    @required this.totalMember,
    @required this.totalFeed,
    @required this.createdDate,
    @required this.groupOnwerName,
    @required this.groupStatus,
  });

  String groupId;
  String groupName;
  String groupDesc;
  String image;
  String totalMember;
  String totalFeed;
  String createdDate;
  String groupOnwerName;
  String groupStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    groupId: json["group_id"],
    groupName: json["group_name"],
    groupDesc: json["group_desc"],
    image: json["image"],
    totalMember: json["total_member"],
    totalFeed: json["total_feed"],
    createdDate: json["createdDate"],
    groupOnwerName: json["group_onwer_name"],
    groupStatus: json["group_status"],
  );

  Map<String, dynamic> toJson() => {
    "group_id": groupId,
    "group_name": groupName,
    "group_desc": groupDesc,
    "image": image,
    "total_member": totalMember,
    "total_feed": totalFeed,
    "createdDate": createdDate,
    "group_onwer_name": groupOnwerName,
    "group_status": groupStatus,
  };
}
