class StatementModel {
  String? id;
  String? counter;
  String? catid;
  String? catid2;
  String? md5id;
  String? dateadd;
  String? text1;
  String? text2;
  String? text3;
  String? text4;
  String? text5;
  String? userid;
  String? token;

  StatementModel({
    this.id,
    this.counter,
    this.catid,
    this.catid2,
    this.md5id,
    this.dateadd,
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.text5,
    this.userid,
    this.token,
  });

  StatementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counter = json['counter'];
    catid = json['catid'];
    catid2 = json['catid2'];
    md5id = json['md5id'];
    dateadd = json['dateadd'];
    text1 = json['text1'];
    text2 = json['text2'];
    text3 = json['text3'];
    text4 = json['text4'];
    text5 = json['text5'];
    userid = json['userid'];
    token = json['token'];
  }
}
