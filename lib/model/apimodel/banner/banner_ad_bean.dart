class BannerAdBean {
  bool status;
  String message;
  BannerAdData data;

  BannerAdBean({this.status, this.message, this.data});

  BannerAdBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BannerAdData.fromJson(json['data']) : null;
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

class BannerAdData {
  String userId;
  String bannerId;
  String price;
  String paymentUrl;

  BannerAdData({this.userId, this.bannerId, this.price, this.paymentUrl});

  BannerAdData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    bannerId = json['banner_id'];
    price = json['price'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['banner_id'] = this.bannerId;
    data['price'] = this.price;
    data['payment_url'] = this.paymentUrl;
    return data;
  }
}