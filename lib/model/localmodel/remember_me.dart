class RememberMeBean
{
  String email,password;
  RememberMeBean({this.email,this.password});

  RememberMeBean.fromJson(Map<String, dynamic> json) {

    email = json['email']as String;
    password = json['password']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['email'] = email;
    data['password'] = password;
    return data;
  }
}