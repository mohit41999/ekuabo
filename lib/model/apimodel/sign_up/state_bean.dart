class StateBean {
  bool status;
  String message;
  List<Data> data;

  StateBean({this.status, this.message, this.data});

  StateBean.fromJson(Map<String, dynamic> json) {
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
  String stateID;
  String countryID;
  String stateName;

  Data({this.stateID, this.countryID, this.stateName});

  Data.fromJson(Map<String, dynamic> json) {
    stateID = json['StateID'];
    countryID = json['CountryID'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateID'] = this.stateID;
    data['CountryID'] = this.countryID;
    data['stateName'] = this.stateName;
    return data;
  }
}