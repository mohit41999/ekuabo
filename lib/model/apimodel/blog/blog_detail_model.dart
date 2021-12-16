// To parse this JSON data, do
//
//     final blogDetailsModel = blogDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BlogDetailsModel blogDetailsModelFromJson(String str) =>
    BlogDetailsModel.fromJson(json.decode(str));

String blogDetailsModelToJson(BlogDetailsModel data) =>
    json.encode(data.toJson());

class BlogDetailsModel {
  BlogDetailsModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory BlogDetailsModel.fromJson(Map<String, dynamic> json) =>
      BlogDetailsModel(
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
    @required this.blogId,
    @required this.blogTitle,
    @required this.blogImage,
    @required this.created,
    @required this.blogDesc,
    @required this.totalComment,
    @required this.comment,
    @required this.userProfile,
  });

  String blogId;
  String blogTitle;
  String blogImage;
  String created;
  String blogDesc;
  String userProfile;
  int totalComment;
  List<Comment> comment;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        blogId: json["blog_id"],
        blogTitle: json["blog_title"],
        blogImage: json["blog_image"],
        created: json["created"],
        blogDesc: json["blog_desc"],
        totalComment: json["total_comment"],
        userProfile: json["user_profile"],
        comment:
            List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "blog_title": blogTitle,
        "blog_image": blogImage,
        "created": created,
        "blog_desc": blogDesc,
        "total_comment": totalComment,
        "user_profile": userProfile,
        "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    @required this.commentId,
    @required this.blogId,
    @required this.comment,
    @required this.userDetails,
  });

  String commentId;
  String blogId;
  String comment;
  UserDetails userDetails;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["comment_id"],
        blogId: json["blog_id"],
        comment: json["comment"],
        userDetails: UserDetails.fromJson(json["user_details"]),
      );

  Map<String, dynamic> toJson() => {
        "comment_id": commentId,
        "blog_id": blogId,
        "comment": comment,
        "user_details": userDetails.toJson(),
      };
}

class UserDetails {
  UserDetails({
    @required this.userId,
    @required this.username,
    @required this.profile,
  });

  String userId;
  String username;
  String profile;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        userId: json["user_id"],
        username: json["username"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "profile": profile,
      };
}
