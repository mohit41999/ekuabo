import 'package:ekuabo/model/apimodel/base_bean.dart';

class CountryBean{
  bool status;
  String message;
  List<Data> data;
  CountryBean({this.status,this.message,this.data});
  CountryBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    status = json['status']as bool;
    message = json['message']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String countryId;
  String countryName;

  Data({String countryId, String countryName}) {
    this.countryId = countryId;
    this.countryName = countryName;
  }



  Data.fromJson(Map<String, dynamic> json) {
    countryId = json['CountryId'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CountryId'] = this.countryId;
    data['countryName'] = this.countryName;
    return data;
  }
}