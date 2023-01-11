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
