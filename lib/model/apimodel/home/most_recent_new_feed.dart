class MostRecentNewFeed {
  bool status;
  String message;
  List<MostRecentNewFeedData> data;

  MostRecentNewFeed({this.status, this.message, this.data});

  MostRecentNewFeed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(MostRecentNewFeedData.fromJson(v));
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

class MostRecentNewFeedData {
  String feed_id;
  String userName;
  String feed_msg;
  String image;
  String created;

  MostRecentNewFeedData(
      {this.feed_id,
        this.userName,
        this.feed_msg,
        this.image,
        this.created});

  MostRecentNewFeedData.fromJson(Map<String, dynamic> json) {
    feed_id = json['feed_id'];
    userName = json['userName'];
    feed_msg = json['feed_msg'];
    image = json['image'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed_id'] = this.feed_id;
    data['userName'] = this.userName;
    data['feed_msg'] = this.feed_msg;
    data['image'] = this.image;
    data['created'] = this.created;
    return data;
  }
}

class UserDetail {
  String userId;
  String username;
  String profile;

  UserDetail({this.userId, this.username, this.profile});

  UserDetail.fromJson(Map<String, dynamic> json) {
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