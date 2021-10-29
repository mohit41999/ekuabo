// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<BannerModelData> data;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        status: json["status"],
        message: json["message"],
        data: List<BannerModelData>.from(
            json["data"].map((x) => BannerModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BannerModelData {
  BannerModelData({
    @required this.bannerId,
    @required this.slotName,
    @required this.title,
    @required this.url,
    @required this.description,
    @required this.noOfDays,
    @required this.defaultCurrency,
    @required this.price,
    @required this.startDate,
    @required this.endDate,
    @required this.isApproved,
    @required this.isActive,
    @required this.createdDate,
    @required this.image,
  });

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
  DateTime createdDate;
  String image;

  factory BannerModelData.fromJson(Map<String, dynamic> json) =>
      BannerModelData(
        bannerId: json["banner_id"],
        slotName: json["slot_name"],
        title: json["title"],
        url: json["url"],
        description: json["description"],
        noOfDays: json["no_of_days"],
        defaultCurrency: json["default_currency"],
        price: json["price"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        isApproved: json["is_approved"],
        isActive: json["isActive"],
        createdDate: DateTime.parse(json["createdDate"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "slot_name": slotName,
        "title": title,
        "url": url,
        "description": description,
        "no_of_days": noOfDays,
        "default_currency": defaultCurrency,
        "price": price,
        "start_date": startDate,
        "end_date": endDate,
        "is_approved": isApproved,
        "isActive": isActive,
        "createdDate": createdDate.toIso8601String(),
        "image": image,
      };
}
