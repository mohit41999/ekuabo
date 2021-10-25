class MyGroupBean {
  bool status;
  String message;
  List<MyGroupDataBean> data;

  MyGroupBean({this.status, this.message, this.data});

  MyGroupBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<MyGroupDataBean>();
      json['data'].forEach((v) {
        data.add(new MyGroupDataBean.fromJson(v));
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

class MyGroupDataBean {
  String groupId;
  String invite_id;
  String group_invite_status;
  String group_join_id;
  String group_join_status;
  String groupName;
  String groupDesc;
  String image;
  String totalMember;
  String totalFeed;
  String createdDate;
  String requested_username;
  String requested_user_id;

  MyGroupDataBean(
      {this.groupId,
      this.group_join_id,
      this.invite_id,
      this.group_invite_status,
      this.group_join_status,
      this.groupName,
      this.groupDesc,
      this.image,
      this.totalMember,
      this.totalFeed,
      this.createdDate,
      this.requested_username,
      this.requested_user_id});

  MyGroupDataBean.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    invite_id = json['invite_id'];
    group_invite_status = json['group_invite_status'];
    group_join_status = json['group_join_status'];
    group_join_id = json['group_join_id'];
    groupName = json['group_name'];
    groupDesc = json['group_desc'];
    image = json['image'];
    totalMember = json['total_member'];
    totalFeed = json['total_feed'];
    createdDate = json['createdDate'];
    requested_username = json['requested_username'];
    requested_user_id = json['requested_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['invite_id'] = this.invite_id;
    data['group_invite_status'] = this.group_invite_status;
    data['group_join_id'] = this.group_join_id;
    data['group_join_status'] = this.group_join_status;
    data['group_name'] = this.groupName;
    data['group_desc'] = this.groupDesc;
    data['image'] = this.image;
    data['total_member'] = this.totalMember;
    data['total_feed'] = this.totalFeed;
    data['createdDate'] = this.createdDate;
    data['requested_username'] = this.requested_username;
    data['requested_user_id'] = this.requested_user_id;
    return data;
  }
}
