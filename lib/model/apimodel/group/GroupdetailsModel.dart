// To parse this JSON data, do
//
//     final groupDetailsModel = groupDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GroupDetailsModel groupDetailsModelFromJson(String str) =>
    GroupDetailsModel.fromJson(json.decode(str));

String groupDetailsModelToJson(GroupDetailsModel data) =>
    json.encode(data.toJson());

class GroupDetailsModel {
  GroupDetailsModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  Data data;

  factory GroupDetailsModel.fromJson(Map<String, dynamic> json) =>
      GroupDetailsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    @required this.groupDetails,
    @required this.groupFeed,
  });

  GroupDetails groupDetails;
  List<GroupFeed> groupFeed;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        groupDetails: GroupDetails.fromJson(json["group_details"]),
        groupFeed: List<GroupFeed>.from(
            json["group_feed"].map((x) => GroupFeed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group_details": groupDetails.toJson(),
        "group_feed": List<dynamic>.from(groupFeed.map((x) => x.toJson())),
      };
}

class GroupDetails {
  GroupDetails({
    @required this.groupId,
    @required this.groupName,
    @required this.groupDesc,
    @required this.image,
    @required this.totalMember,
    @required this.totalFeed,
    @required this.createdDate,
    @required this.groupOnwerName,
    @required this.onwerProfile,
  });

  String groupId;
  String groupName;
  String groupDesc;
  dynamic image;
  String totalMember;
  String totalFeed;
  String createdDate;
  String groupOnwerName;
  String onwerProfile;

  factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
        groupId: json["group_id"],
        groupName: json["group_name"],
        groupDesc: json["group_desc"],
        image: json["image"],
        totalMember: json["total_member"],
        totalFeed: json["total_feed"],
        createdDate: json["createdDate"],
        groupOnwerName: json["group_onwer_name"],
        onwerProfile: json["onwer_profile"],
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
        "onwer_profile": onwerProfile,
      };
}

class GroupFeed {
  GroupFeed({
    @required this.feedId,
    @required this.groupId,
    @required this.userId,
    @required this.feedType,
    @required this.message,
    @required this.isUpload,
    @required this.mediaType,
    @required this.uploadPath,
    @required this.isShared,
    @required this.createdDate,
    @required this.isUserLike,
    @required this.isUserReported,
    @required this.userFeedDetails,
    @required this.comment,
    this.isCommentExpand = false,
  });

  String feedId;
  String groupId;
  String userId;
  String feedType;
  String message;
  String isUpload;
  String mediaType;
  String uploadPath;
  String isShared;
  String createdDate;
  String isUserLike;
  String isUserReported;
  UserFeedDetails userFeedDetails;
  List<dynamic> comment;
  bool isCommentExpand;

  factory GroupFeed.fromJson(Map<String, dynamic> json) => GroupFeed(
        feedId: json["feed_id"],
        groupId: json["group_id"],
        userId: json["user_id"],
        feedType: json["feed_type"],
        message: json["message"],
        isUpload: json["is_upload"],
        mediaType: json["media_type"],
        uploadPath: json["upload_path"],
        isShared: json["isShared"],
        createdDate: json["createdDate"],
        isUserLike: json["is_user_like"],
        isUserReported: json["is_user_reported"],
        userFeedDetails: UserFeedDetails.fromJson(json["user_feed_details"]),
        comment: List<dynamic>.from(json["comment"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "feed_id": feedId,
        "group_id": groupId,
        "user_id": userId,
        "feed_type": feedType,
        "message": message,
        "is_upload": isUpload,
        "media_type": mediaType,
        "upload_path": uploadPath,
        "isShared": isShared,
        "createdDate": createdDate,
        "is_user_like": isUserLike,
        "is_user_reported": isUserReported,
        "user_feed_details": userFeedDetails.toJson(),
        "comment": List<dynamic>.from(comment.map((x) => x)),
      };
}

class UserFeedDetails {
  UserFeedDetails({
    @required this.userId,
    @required this.username,
    @required this.profile,
    @required this.location,
  });

  String userId;
  String username;
  String profile;
  String location;

  factory UserFeedDetails.fromJson(Map<String, dynamic> json) =>
      UserFeedDetails(
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
