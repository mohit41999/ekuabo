class HomeMarketPlaceBean {
  bool status;
  String message;
  List<HomeMarketPlaceData> data;

  HomeMarketPlaceBean({this.status, this.message, this.data});

  HomeMarketPlaceBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(HomeMarketPlaceData.fromJson(v));
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

class HomeMarketPlaceData {
  String id;
  String marketTitle;
  String marketDescription;
  String image;
  String created;
  UserDetail userDetail;

  HomeMarketPlaceData(
      {this.id,
        this.marketTitle,
        this.marketDescription,
        this.image,
        this.created,
        this.userDetail});

  HomeMarketPlaceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marketTitle = json['market_title'];
    marketDescription = json['market_description'];
    image = json['image'];
    created = json['created'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['market_title'] = this.marketTitle;
    data['market_description'] = this.marketDescription;
    data['image'] = this.image;
    data['created'] = this.created;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail.toJson();
    }
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