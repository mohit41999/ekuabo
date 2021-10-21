class BannerSlotBean {
  bool status;
  String message;
  List<BannerSlotBeanData> data;

  BannerSlotBean({this.status, this.message, this.data});

  BannerSlotBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<BannerSlotBeanData>();
      json['data'].forEach((v) {
        data.add(new BannerSlotBeanData.fromJson(v));
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

class BannerSlotBeanData {
  String slotId;
  String pageName;
  String slotName;
  String price;
  bool isChecked=false;

  BannerSlotBeanData({this.slotId, this.pageName, this.slotName, this.price,this.isChecked});

  BannerSlotBeanData.fromJson(Map<String, dynamic> json) {
    slotId = json['slot_id'];
    pageName = json['page_name'];
    slotName = json['slot_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot_id'] = this.slotId;
    data['page_name'] = this.pageName;
    data['slot_name'] = this.slotName;
    data['price'] = this.price;
    return data;
  }
}