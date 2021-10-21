class ChatBean {
  bool status;
  String message;
  List<ChatDataBean> data;

  ChatBean({this.status, this.message, this.data});

  ChatBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<ChatDataBean>();
      json['data'].forEach((v) {
        data.add(new ChatDataBean.fromJson(v));
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

class ChatDataBean {
  String chatId;
  String username;
  String userMsg;
  String postedTime;
  String userImg;

  ChatDataBean(
      {this.chatId,
        this.username,
        this.userMsg,
        this.postedTime,
        this.userImg});

  ChatDataBean.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    username = json['username'];
    userMsg = json['user_msg'];
    postedTime = json['posted_time'];
    userImg = json['user_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['username'] = this.username;
    data['user_msg'] = this.userMsg;
    data['posted_time'] = this.postedTime;
    data['user_img'] = this.userImg;
    return data;
  }
}