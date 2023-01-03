import 'package:loginapp/screens/home/payment/payment_model.dart';

class PaymentViewModel {
  final PaymentModel _paymentModel;

  PaymentViewModel({required PaymentModel paymentModel})
      : _paymentModel = paymentModel;

  String get id {
    return _paymentModel.id!;
  }

  String get name {
    return _paymentModel.name!;
  }

  String get mobile {
    return _paymentModel.mobile!;
  }

  String get amount {
    return _paymentModel.amount!;
  }

  String get md5id {
    return _paymentModel.md5id!;
  }

  String get comment {
    return _paymentModel.comment!;
  }

  String get show1 {
    return _paymentModel.show1!;
  }

  String get date1 {
    return _paymentModel.date1!;
  }

  String get paymentdate {
    return _paymentModel.paymentdate!;
  }

  String get userid {
    return _paymentModel.userid!;
  }

  String get groupid {
    return _paymentModel.groupid!;
  }

  String get paymenttext {
    return _paymentModel.paymenttext!;
  }

  String get urlopen {
    return _paymentModel.urlopen!;
  }

  String get token {
    return _paymentModel.token!;
  }

  String get url {
    return _paymentModel.url!;
  }

  String get dateend {
    return _paymentModel.dateend!;
  }

  String get checkerror {
    return _paymentModel.checkerror!;
  }
}
