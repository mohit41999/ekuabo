class BaseBean {
  bool status;
  String message;
  List datum;

  BaseBean({
    this.status,
    this.message,
    this.datum,
  });

  BaseBean.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool;
    message = json['message'] as String;
    datum = json['data'] as List;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.datum;
    return data;
  }
}
