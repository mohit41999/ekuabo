class LgaBean {
  bool status;
  String message;
  List<Data> data;

  LgaBean({this.status, this.message, this.data});

  LgaBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  String id;
  String lgaName;

  Data({this.id, this.lgaName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lgaName = json['lga_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lga_name'] = this.lgaName;
    return data;
  }
}