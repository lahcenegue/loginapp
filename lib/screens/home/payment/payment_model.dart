class PaymentApi {
  String? id;
  String? name;
  String? mobile;
  String? amount;
  String? md5id;
  String? comment;
  String? show1;
  String? date1;
  String? paymentdate;
  String? userid;
  String? groupid;
  String? paymenttext;
  String? urlopen;
  String? token;
  String? url;
  String? dateend;
  String? checkerror;

  PaymentApi(
      {this.id,
      this.name,
      this.mobile,
      this.amount,
      this.md5id,
      this.comment,
      this.show1,
      this.date1,
      this.paymentdate,
      this.userid,
      this.groupid,
      this.paymenttext,
      this.urlopen,
      this.token,
      this.url,
      this.dateend,
      this.checkerror});

  PaymentApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    amount = json['amount'];
    md5id = json['md5id'];
    comment = json['comment'];
    show1 = json['show1'];
    date1 = json['date1'];
    paymentdate = json['paymentdate'];
    userid = json['userid'];
    groupid = json['groupid'];
    paymenttext = json['paymenttext'];
    urlopen = json['urlopen'];
    token = json['token'];
    url = json['url'];
    dateend = json['dateend'];
    checkerror = json['checkerror'];
  }
}
