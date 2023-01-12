import 'package:loginapp/screens/home_main/payment/payment_model.dart';

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

  int get sharebutton {
    return _paymentModel.sharebutton!;
  }
}
