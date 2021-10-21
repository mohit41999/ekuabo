class CategoryBean {
  bool status;
  String message;
  List<CategoryBeanData> data;

  CategoryBean({this.status, this.message, this.data});

  CategoryBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryBeanData>();
      json['data'].forEach((v) {
        data.add(new CategoryBeanData.fromJson(v));
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

class CategoryBeanData {
  String id;
  String cateName;

  CategoryBeanData({this.id, this.cateName});

  CategoryBeanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cateName = json['cateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cateName'] = this.cateName;
    return data;
  }
}