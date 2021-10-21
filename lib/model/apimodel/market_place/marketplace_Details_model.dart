// To parse this JSON data, do
//
//     final marketplaceDetails = marketplaceDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MarketplaceDetails marketplaceDetailsFromJson(String str) =>
    MarketplaceDetails.fromJson(json.decode(str));

String marketplaceDetailsToJson(MarketplaceDetails data) =>
    json.encode(data.toJson());

class MarketplaceDetails {
  MarketplaceDetails({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory MarketplaceDetails.fromJson(Map<String, dynamic> json) =>
      MarketplaceDetails(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    @required this.marketplaceId,
    @required this.categoryId,
    @required this.subCategoryId,
    @required this.categoryName,
    @required this.subCategoryName,
    @required this.title,
    @required this.listingDescription,
    @required this.location,
    @required this.email,
    @required this.contactNumber,
    @required this.price,
    @required this.neigborhood,
    @required this.created,
    @required this.userDetails,
    @required this.image,
  });

  String marketplaceId;
  String categoryId;
  String subCategoryId;
  String categoryName;
  String subCategoryName;
  String title;
  String listingDescription;
  String location;
  String email;
  String contactNumber;
  String price;
  String neigborhood;
  DateTime created;
  UserDetails userDetails;
  List<DetailsImage> image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        marketplaceId: json["marketplace_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        categoryName: json["category_name"],
        subCategoryName: json["sub_category_name"],
        title: json["title"],
        listingDescription: json["listing_description"],
        location: json["location"],
        email: json["email"],
        contactNumber: json["contact_number"],
        price: json["price"],
        neigborhood: json["neigborhood"],
        created: DateTime.parse(json["created"]),
        userDetails: UserDetails.fromJson(json["user_details"]),
        image: List<DetailsImage>.from(
            json["image"].map((x) => DetailsImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marketplace_id": marketplaceId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "category_name": categoryName,
        "sub_category_name": subCategoryName,
        "title": title,
        "listing_description": listingDescription,
        "location": location,
        "email": email,
        "contact_number": contactNumber,
        "price": price,
        "neigborhood": neigborhood,
        "created": created.toIso8601String(),
        "user_details": userDetails.toJson(),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
}

class DetailsImage {
  DetailsImage({
    @required this.imageId,
    @required this.image,
  });

  dynamic imageId;
  String image;

  factory DetailsImage.fromJson(Map<String, dynamic> json) => DetailsImage(
        imageId: json["image_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image": image,
      };
}

class UserDetails {
  UserDetails({
    @required this.userId,
    @required this.username,
    @required this.profile,
  });

  String userId;
  String username;
  String profile;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        userId: json["user_id"],
        username: json["username"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "profile": profile,
      };
}
