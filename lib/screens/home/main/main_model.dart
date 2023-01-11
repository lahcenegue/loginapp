class MainModel {
  String? msg;
  String? name;
  String? group;
  int? not;
  String? id;
  String? balance;
  MainModel({
    this.msg,
    this.name,
    this.group,
    this.not,
    this.id,
    this.balance,
  });

  MainModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    name = json['name'];
    group = json['gruop'];
    not = json['not'];
    id = json['id'];
    balance = json['balance'];
  }
}
