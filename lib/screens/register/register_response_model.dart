class RegisterRequestModel {
  String? name;
  String? email;
  String? password;
  String? civilNumer;
  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
    this.civilNumer,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
      'civilNumer': civilNumer!.trim(),
    };

    return map;
  }
}

class RegisterResponseModel {
  String? msg;
  String? user;
  String? name;
  String? token;

  RegisterResponseModel({
    this.msg,
    this.user,
    this.name,
    this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      msg: json['msg'],
      user: json['user'],
      name: json['name'],
      token: json['token'],
    );
  }
}
