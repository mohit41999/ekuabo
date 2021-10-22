// To parse this JSON data, do
//
//     final mostRecentBlog = mostRecentBlogFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MostRecentBlog mostRecentBlogFromJson(String str) =>
    MostRecentBlog.fromJson(json.decode(str));

String mostRecentBlogToJson(MostRecentBlog data) => json.encode(data.toJson());

class MostRecentBlog {
  MostRecentBlog({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<MostRecentBlogData> data;

  factory MostRecentBlog.fromJson(Map<String, dynamic> json) => MostRecentBlog(
        status: json["status"],
        message: json["message"],
        data: List<MostRecentBlogData>.from(
            json["data"].map((x) => MostRecentBlogData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MostRecentBlogData {
  MostRecentBlogData({
    @required this.blogId,
    @required this.blogTitle,
    @required this.blogImage,
    @required this.created,
    @required this.blogDesc,
    @required this.profileDetails,
  });

  String blogId;
  String blogTitle;
  String blogImage;
  String created;
  String blogDesc;
  ProfileDetails profileDetails;

  factory MostRecentBlogData.fromJson(Map<String, dynamic> json) =>
      MostRecentBlogData(
        blogId: json["blog_id"],
        blogTitle: json["blog_title"],
        blogImage: json["blog_image"],
        created: json["created"],
        blogDesc: json["blog_desc"],
        profileDetails: ProfileDetails.fromJson(json["profile_details"]),
      );

  Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "blog_title": blogTitle,
        "blog_image": blogImage,
        "created": created,
        "blog_desc": blogDesc,
        "profile_details": profileDetails.toJson(),
      };
}

class ProfileDetails {
  ProfileDetails({
    @required this.userId,
    @required this.username,
    @required this.profile,
    @required this.location,
  });

  String userId;
  String username;
  String profile;
  String location;

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
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
