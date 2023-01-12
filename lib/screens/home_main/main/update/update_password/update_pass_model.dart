class UpdatePassRequestModel {
  String? pass;

  UpdatePassRequestModel({
    this.pass,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'pass': pass!.trim(),
    };
    return map;
  }
}

class UpdatePassResponseModel {
  String? edit;
  String? msg;
  String? email;
  String? info;

  UpdatePassResponseModel({
    this.edit,
    this.email,
    this.info,
    this.msg,
  });

  factory UpdatePassResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdatePassResponseModel(
      edit: json['edit'],
      msg: json['msg'],
      email: json['email'],
      info: json['info'],
    );
  }
}
