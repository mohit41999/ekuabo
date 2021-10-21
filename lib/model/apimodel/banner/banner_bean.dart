class BannerBean {
  bool status;
  String message;
  List<BannerBeanData> data;

  BannerBean({this.status, this.message, this.data});

  BannerBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new BannerBeanData.fromJson(v));
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

class BannerBeanData {
  String bannerId;
  String slotName;
  String title;
  String url;
  String description;
  String noOfDays;
  String defaultCurrency;
  String price;
  String startDate;
  String endDate;
  String isApproved;
  String isActive;
  String createdDate;
  String image;

  BannerBeanData(
      {this.bannerId,
        this.slotName,
        this.title,
        this.url,
        this.description,
        this.noOfDays,
        this.defaultCurrency,
        this.price,
        this.startDate,
        this.endDate,
        this.isApproved,
        this.isActive,
        this.createdDate,
        this.image});

  BannerBeanData.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    slotName = json['slot_name'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
    noOfDays = json['no_of_days'];
    defaultCurrency = json['default_currency'];
    price = json['price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isApproved = json['is_approved'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['slot_name'] = this.slotName;
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    data['no_of_days'] = this.noOfDays;
    data['default_currency'] = this.defaultCurrency;
    data['price'] = this.price;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_approved'] = this.isApproved;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['image'] = this.image;
    return data;
  }
}