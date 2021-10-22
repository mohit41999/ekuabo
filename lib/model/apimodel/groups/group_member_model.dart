// To parse this JSON data, do
//
//     final groupMemberModel = groupMemberModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GroupMemberModel groupMemberModelFromJson(String str) =>
    GroupMemberModel.fromJson(json.decode(str));

String groupMemberModelToJson(GroupMemberModel data) =>
    json.encode(data.toJson());

class GroupMemberModel {
  GroupMemberModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      GroupMemberModel(
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
    @required this.userId,
    @required this.username,
    @required this.profile,
    @required this.location,
  });

  String userId;
  String username;
  String profile;
  String location;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        username: json["username"],
        profile: json["profile"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "profile": profile,
        "location": location,
      };
}
