class MarketPlaceBean {
  bool status;
  String message;
  List<MarketPlaceData> data;

  MarketPlaceBean({this.status, this.message, this.data});

  MarketPlaceBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<MarketPlaceData>();
      json['data'].forEach((v) {
        data.add(new MarketPlaceData.fromJson(v));
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

class MarketPlaceData {
  String marketplaceId;
  String currency_code;
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

  MarketPlaceData(
      {this.marketplaceId,
      this.currency_code,
      this.categoryId,
      this.subCategoryId,
      this.categoryName,
      this.subCategoryName,
      this.title,
      this.listingDescription,
      this.location,
      this.email,
      this.contactNumber,
      this.price,
      this.neigborhood,
      this.image});

  MarketPlaceData.fromJson(Map<String, dynamic> json) {
    marketplaceId = json['marketplace_id'];
    currency_code = json['currency_code'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    title = json['title'];
    listingDescription = json['listing_description'];
    location = json['location'];
    email = json['email'];
    contactNumber = json['contact_number'];
    price = json['price'];
    neigborhood = json['neigborhood'];
    if (json['image'] != null) {
      image = new List<Image>();
      json['image'].forEach((v) {
        image.add(new Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marketplace_id'] = this.marketplaceId;
    data['currency_code'] = this.currency_code;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['title'] = this.title;
    data['listing_description'] = this.listingDescription;
    data['location'] = this.location;
    data['email'] = this.email;
    data['contact_number'] = this.contactNumber;
    data['price'] = this.price;
    data['neigborhood'] = this.neigborhood;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  dynamic imageId;
  String image;

  Image({this.imageId, this.image});

  Image.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['image'] = this.image;
    return data;
  }
}
