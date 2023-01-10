class AddRequestModel {
  String? token;
  String? name;
  String? comment;
  double? amount;
  int? phone;
  AddRequestModel(
      {this.token, this.name, this.comment, this.amount, this.phone});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'token': token!.trim(),
      'name': name!.trim(),
      'comment': comment!.trim(),
      'amount': amount!,
      'phone': phone!,
    };

    return map;
  }
}

class AddResponseModel {
  String? msg;
  String? md5id;
  String? add;

  AddResponseModel({
    this.msg,
    this.md5id,
    this.add,
  });

  factory AddResponseModel.fromJson(Map<String, dynamic> json) {
    return AddResponseModel(
      msg: json['msg'],
      md5id: json['md5id'],
      add: json['add'],
    );
  }
}
