class UserChatBean {
  bool status;
  String message;
  List<UserChatDataBean> data;

  UserChatBean({this.status, this.message, this.data});

  UserChatBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<UserChatDataBean>();
      json['data'].forEach((v) {
        data.add(new UserChatDataBean.fromJson(v));
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

class UserChatDataBean {
  String toUserId;
  String fromUserId;
  String profileImg;
  String messageType;
  String mediaType;
  String message;
  String time;

  UserChatDataBean(
      {this.toUserId,
        this.fromUserId,
        this.profileImg,
        this.messageType,
        this.mediaType,
        this.message,
        this.time});

  UserChatDataBean.fromJson(Map<String, dynamic> json) {
    toUserId = json['to_user_id'];
    fromUserId = json['from_user_id'];
    profileImg = json['profile_img'];
    messageType = json['message_type'];
    mediaType = json['media_type'];
    message = json['message'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to_user_id'] = this.toUserId;
    data['from_user_id'] = this.fromUserId;
    data['profile_img'] = this.profileImg;
    data['message_type'] = this.messageType;
    data['media_type'] = this.mediaType;
    data['message'] = this.message;
    data['time'] = this.time;
    return data;
  }
}