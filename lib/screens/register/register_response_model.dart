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
