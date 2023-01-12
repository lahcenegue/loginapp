class AddStatementRequest {
  String? amout;
  String? banq;
  String? name;
  String? iban;
  String? comment;
  AddStatementRequest({
    this.amout,
    this.banq,
    this.name,
    this.iban,
    this.comment,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'text1': amout!.trim(),
      'text3': banq!.trim(),
      'text4': name!.trim(),
      'text5': iban!.trim(),
      'text2': comment!.trim(),
    };

    return map;
  }
}

class AddStatementResponse {
  String? msg;
  String? add;

  AddStatementResponse({
    this.msg,
    this.add,
  });

  factory AddStatementResponse.fromJson(Map<String, dynamic> json) {
    return AddStatementResponse(
      msg: json['msg'],
      add: json['add'],
    );
  }
}
