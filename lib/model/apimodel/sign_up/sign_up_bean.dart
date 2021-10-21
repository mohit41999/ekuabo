class SignupBean {
  bool status;
  String message;
  SignupDataBean data;

  SignupBean({this.status, this.message, this.data});

  SignupBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?!(json['data'] is List)? new SignupDataBean.fromJson(json['data']):null : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SignupDataBean {
  String userId;
  String mobileNo;

  SignupDataBean({this.userId, this.mobileNo});

  SignupDataBean.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}