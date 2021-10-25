class UserProfileBean {
  bool status;
  String message;
  UserProfileDataBean data;

  UserProfileBean({this.status, this.message, this.data});

  UserProfileBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new UserProfileDataBean.fromJson(json['data'])
        : null;
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

class UserProfileDataBean {
  Profile profile;
  About about;
  MarketplaceInfo marketplaceInfo;

  UserProfileDataBean({this.profile, this.about, this.marketplaceInfo});

  UserProfileDataBean.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    about = json['about'] != null ? new About.fromJson(json['about']) : null;
    marketplaceInfo = json['marketplace_info'] != null
        ? new MarketplaceInfo.fromJson(json['marketplace_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    if (this.about != null) {
      data['about'] = this.about.toJson();
    }
    if (this.marketplaceInfo != null) {
      data['marketplace_info'] = this.marketplaceInfo.toJson();
    }
    return data;
  }
}

class Profile {
  String id;
  String name;
  String mobileNo;
  String homeContactNo;
  String mobileContactNo;
  String address;
  String publicEmailId;
  String website;
  String profilePicture;
  String createdDate;

  Profile(
      {this.id,
      this.name,
      this.mobileNo,
      this.homeContactNo,
      this.mobileContactNo,
      this.address,
      this.publicEmailId,
      this.website,
      this.profilePicture,
      this.createdDate});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    homeContactNo = json['home_contact_no'];
    mobileContactNo = json['mobile_contact_no'];
    address = json['address'];
    publicEmailId = json['public_email_id'];
    website = json['website'];
    profilePicture = json['profile_picture'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['home_contact_no'] = this.homeContactNo;
    data['mobile_contact_no'] = this.mobileContactNo;
    data['address'] = this.address;
    data['public_email_id'] = this.publicEmailId;
    data['website'] = this.website;
    data['profile_picture'] = this.profilePicture;
    data['createdDate'] = this.createdDate;
    return data;
  }
}

class About {
  String homeTown;
  String occupation;
  String funFacts;
  String interests;

  About({this.homeTown, this.occupation, this.funFacts, this.interests});

  About.fromJson(Map<String, dynamic> json) {
    homeTown = json['home_town'];
    occupation = json['occupation'];
    funFacts = json['fun_facts'];
    interests = json['interests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['home_town'] = this.homeTown;
    data['occupation'] = this.occupation;
    data['fun_facts'] = this.funFacts;
    data['interests'] = this.interests;
    return data;
  }
}

class MarketplaceInfo {
  String marketTitle;
  String marketAddress;
  String marketId;
  String message;
  String marketImage;

  MarketplaceInfo({this.marketTitle, this.message, this.marketImage});

  MarketplaceInfo.fromJson(Map<String, dynamic> json) {
    marketTitle = json['market_title'];
    marketAddress = json['market_address'];
    marketId = json['market_id'];
    message = json['message'];
    marketImage = json['market_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['market_title'] = this.marketTitle;
    data['market_address'] = this.marketAddress;
    data['market_id'] = this.marketId;
    data['message'] = this.message;
    data['market_image'] = this.marketImage;
    return data;
  }
}
