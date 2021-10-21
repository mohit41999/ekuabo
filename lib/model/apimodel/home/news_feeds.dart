class NewsFeedBean {
  bool status;
  String message;
  List<NewsFeedData> data;

  NewsFeedBean({this.status, this.message, this.data});

  NewsFeedBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new NewsFeedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsFeedData {
  String feedId;
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
  List<Comment> comment;
  bool isCommentExpand=false;
  NewsFeedData(
      {this.feedId,
        this.userId,
        this.feedType,
        this.message,
        this.isUpload,
        this.mediaType,
        this.uploadPath,
        this.isShared,
        this.createdDate,
        this.isUserLike,
        this.isUserReported,
        this.userFeedDetails,
        this.comment,
      this.isCommentExpand
      });

  NewsFeedData.fromJson(Map<String, dynamic> json) {
    feedId = json['feed_id'];
    userId = json['user_id'];
    feedType = json['feed_type'];
    message = json['message'];
    isUpload = json['is_upload'];
    mediaType = json['media_type'];
    uploadPath = json['upload_path'];
    isShared = json['isShared'];
    createdDate = json['createdDate'];
    isUserLike = json['is_user_like'];
    isUserReported = json['is_user_reported'];
    userFeedDetails = json['user_feed_details'] != null
        ? new UserFeedDetails.fromJson(json['user_feed_details'])
        : null;
    if (json['comment'] != null) {
      comment = new List<Comment>();
      json['comment'].forEach((v) {
        comment.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed_id'] = this.feedId;
    data['user_id'] = this.userId;
    data['feed_type'] = this.feedType;
    data['message'] = this.message;
    data['is_upload'] = this.isUpload;
    data['media_type'] = this.mediaType;
    data['upload_path'] = this.uploadPath;
    data['isShared'] = this.isShared;
    data['createdDate'] = this.createdDate;
    data['is_user_like'] = this.isUserLike;
    data['is_user_reported'] = this.isUserReported;
    if (this.userFeedDetails != null) {
      data['user_feed_details'] = this.userFeedDetails.toJson();
    }
    if (this.comment != null) {
      data['comment'] = this.comment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserFeedDetails {
  String userId;
  String username;
  String profile;
  String location;

  UserFeedDetails({this.userId, this.username, this.profile, this.location});

  UserFeedDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    profile = json['profile'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['profile'] = this.profile;
    data['location'] = this.location;
    return data;
  }
}

class Comment {
  String commentId;
  String feedId;
  String comment;
  UserDetails userDetails;

  Comment({this.commentId, this.feedId, this.comment, this.userDetails});

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    feedId = json['feed_id'];
    comment = json['comment'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['feed_id'] = this.feedId;
    data['comment'] = this.comment;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails.toJson();
    }
    return data;
  }
}

class UserDetails {
  String userId;
  String username;
  String profile;

  UserDetails({this.userId, this.username, this.profile});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['profile'] = this.profile;
    return data;
  }
}