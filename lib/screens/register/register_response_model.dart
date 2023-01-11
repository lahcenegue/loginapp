class RegisterRequestModel {
  String? name;
  String? email;
  String? password;
  String? civilNumber;
  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
    this.civilNumber,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
      'civilNumer': civilNumber!.trim(),
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
