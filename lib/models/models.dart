class LoginMobileModel {
  String? msg;
  String? code;

  LoginMobileModel({
    this.msg,
    this.code,
  });

  factory LoginMobileModel.fromJson(Map<String, dynamic> json) {
    return LoginMobileModel(
      msg: json['msg'],
      code: json['code'],
    );
  }
}

class LoginCodeModel {
  String? msg;
  String? user;

  LoginCodeModel({
    this.msg,
    this.user,
  });

  factory LoginCodeModel.fromJson(Map<String, dynamic> json) {
    return LoginCodeModel(
      msg: json['msg'],
      user: json['user'],
    );
  }
}
