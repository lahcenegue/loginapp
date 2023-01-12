class AddRequestModel {
  String? name;
  String? comment;
  String? amount;
  String? phone;
  AddRequestModel({
    this.name,
    this.comment,
    this.amount,
    this.phone,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'comment': comment!.trim(),
      'amount': amount!.trim(),
      'phone': phone!.trim(),
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
