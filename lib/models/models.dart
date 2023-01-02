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
  String? name;
  String? token;

  LoginCodeModel({
    this.msg,
    this.user,
    this.name,
    this.token,
  });

  factory LoginCodeModel.fromJson(Map<String, dynamic> json) {
    return LoginCodeModel(
      msg: json['msg'],
      user: json['user'],
      name: json['name'],
      token: json['token'],
    );
  }
}

class RegisterRequestModel {
  String? email;
  String? password;
  String? name;
  String? civilNumber;

  RegisterRequestModel({
    this.email,
    this.password,
    this.civilNumber,
    this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email-register": email!.trim(),
      "password-register": password!.trim(),
      "name-register": name!.trim(),
      "account-type-register": civilNumber!.trim(),
    };

    return map;
  }
}
