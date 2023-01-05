class PaymentModel {
  String? id;
  String? name;
  String? mobile;
  String? amount;
  String? md5id;
  String? comment;
  String? show1;
  String? date1;
  String? paymentdate;
  String? sharebutton;

  PaymentModel({
    this.id,
    this.name,
    this.mobile,
    this.amount,
    this.md5id,
    this.comment,
    this.show1,
    this.date1,
    this.paymentdate,
    this.sharebutton,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    amount = json['amount'];
    md5id = json['md5id'];
    comment = json['comment'];
    show1 = json['show1'];
    date1 = json['date1'];
    paymentdate = json['paymentdate'];
  }
}
