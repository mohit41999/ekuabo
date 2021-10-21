class SubCategoryBean {
  bool status;
  String message;
  List<SubCategoryBeanData> data;

  SubCategoryBean({this.status, this.message, this.data});

  SubCategoryBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<SubCategoryBeanData>();
      json['data'].forEach((v) {
        data.add(new SubCategoryBeanData.fromJson(v));
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

class SubCategoryBeanData {
  String id;
  String subCateName;

  SubCategoryBeanData({this.id, this.subCateName});

  SubCategoryBeanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCateName = json['sub_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_name'] = this.subCateName;
    return data;
  }
}