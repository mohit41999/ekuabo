// To parse this JSON data, do
//
//     final searchMarketplace = searchMarketplaceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchMarketplaceModel searchMarketplaceFromJson(String str) =>
    SearchMarketplaceModel.fromJson(json.decode(str));

String searchMarketplaceToJson(SearchMarketplaceModel data) =>
    json.encode(data.toJson());

class SearchMarketplaceModel {
  SearchMarketplaceModel({
    @required this.status,
    @required this.message,
    @required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory SearchMarketplaceModel.fromJson(Map<String, dynamic> json) =>
      SearchMarketplaceModel(
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
  List<Image> image;

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
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
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
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    @required this.imageId,
    @required this.image,
  });

  dynamic imageId;
  String image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageId: json["image_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image": image,
      };
}
