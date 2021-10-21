import 'package:ekuabo/utils/log.dart';
import 'package:flutter/cupertino.dart';

class UserBean {
  bool status;
  String message;
  UserDataBean data;

  UserBean({this.status, this.message, this.data});

  UserBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null && (json['data'] is List)) {
      data = null;
    } else {
      if (json['data'] != null) {
        data = UserDataBean.fromJson(json['data']);
      }
    }
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

class UserDataBean {
  String id;
  String userName;
  String email;
  String publicEmailId;
  String password;
  String defaultCurrency;
  dynamic profileImg;
  String contactNo;
  String homeContactNo;
  String mobileContactNo;
  String address;
  String homeTown;
  String occupation;
  String interests;
  String funFacts;
  String lgaId;
  String neighborhoodId;
  String neighborSince;
  String website;
  String landmark;
  dynamic status;
  String verifiedEmail;
  String verifiedNumber;
  String otp;
  dynamic pageShow;
  dynamic hash;
  dynamic isActive;
  dynamic createdDate;
  dynamic lga_name;

  UserDataBean(
      {@required this.id,
      @required this.userName,
      @required this.email,
      @required this.publicEmailId,
      @required this.password,
      @required this.defaultCurrency,
      @required this.profileImg,
      @required this.contactNo,
      @required this.homeContactNo,
      @required this.mobileContactNo,
      @required this.address,
      @required this.homeTown,
      @required this.occupation,
      @required this.interests,
      @required this.funFacts,
      @required this.lgaId,
      @required this.neighborhoodId,
      @required this.neighborSince,
      @required this.website,
      @required this.landmark,
      @required this.status,
      @required this.verifiedEmail,
      @required this.verifiedNumber,
      @required this.otp,
      @required this.pageShow,
      @required this.hash,
      @required this.isActive,
      @required this.lga_name,
      @required this.createdDate});

  UserDataBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    publicEmailId = json['public_email_id'];
    password = json['password'];
    defaultCurrency = json['default_currency'];
    profileImg = json['profile_img'];
    contactNo = json['contact_no'];
    homeContactNo = json['home_contact_no'];
    mobileContactNo = json['mobile_contact_no'];
    address = json['address'];
    homeTown = json['home_town'];
    occupation = json['occupation'];
    interests = json['interests'];
    funFacts = json['fun_facts'];
    lgaId = json['lga_id'];
    neighborhoodId = json['neighborhood_id'];
    neighborSince = json['neighbor_since'];
    website = json['website'];
    landmark = json['landmark'];
    status = json['status'];
    verifiedEmail = json['verified_email'];
    verifiedNumber = json['verified_number'];
    otp = json['otp'];
    pageShow = json['pageShow'];
    hash = json['hash'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    lga_name = json['lga_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['public_email_id'] = this.publicEmailId;
    data['password'] = this.password;
    data['default_currency'] = this.defaultCurrency;
    data['profile_img'] = this.profileImg;
    data['contact_no'] = this.contactNo;
    data['home_contact_no'] = this.homeContactNo;
    data['mobile_contact_no'] = this.mobileContactNo;
    data['address'] = this.address;
    data['home_town'] = this.homeTown;
    data['occupation'] = this.occupation;
    data['interests'] = this.interests;
    data['fun_facts'] = this.funFacts;
    data['lga_id'] = this.lgaId;
    data['neighborhood_id'] = this.neighborhoodId;
    data['neighbor_since'] = this.neighborSince;
    data['website'] = this.website;
    data['landmark'] = this.landmark;
    data['status'] = this.status;
    data['verified_email'] = this.verifiedEmail;
    data['verified_number'] = this.verifiedNumber;
    data['otp'] = this.otp;
    data['pageShow'] = this.pageShow;
    data['hash'] = this.hash;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['lga_name'] = this.lga_name;
    return data;
  }
}
