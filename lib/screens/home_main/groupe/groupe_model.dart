class GroupRequestModel {
  String? name;
  String? amountall;
  String? amount;
  String? comment;

  GroupRequestModel({
    this.name,
    this.amountall,
    this.amount,
    this.comment,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'comment': comment!.trim(),
      'amountall': amountall!.trim(),
      'amout': amount!.trim(),
    };

    return map;
  }
}

class GroupeResponseModel {
  int? amount;
  String? name;
  String? amountall;
  String? md5id;
  String? comment;
  String? show1;
  String? date1;
  int? sharebutton;

  GroupeResponseModel({
    this.amount,
    this.name,
    this.amountall,
    this.md5id,
    this.comment,
    this.show1,
    this.date1,
    this.sharebutton,
  });

  factory GroupeResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupeResponseModel(
      amount: json['amount'],
      name: json['name'],
      amountall: json['amountall'],
      md5id: json['md5id'],
      comment: json['comment'],
      show1: json['show1'],
      date1: json['date1'],
      sharebutton: json['sharebutton'],
    );
  }
}

class AddGroupModel {
  String? msg;
  String? md5id;
  String? add;
  AddGroupModel({
    this.add,
    this.md5id,
    this.msg,
  });

  factory AddGroupModel.fromJson(Map<String, dynamic> json) {
    return AddGroupModel(
      add: json['add'],
      md5id: json['md5id'],
      msg: json['msg'],
    );
  }
}
