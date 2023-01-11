import 'package:flutter/material.dart';
import 'package:loginapp/screens/home/payment/payment_api.dart';
import 'package:loginapp/screens/home/payment/payment_model.dart';
import 'package:loginapp/screens/home/payment/payment_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<PaymentViewModel>? listPayment;
  List<PaymentViewModel> newListPayment = [];

  //list payment
  Future<void> fetchPaymentList({required String token}) async {
    List<PaymentModel> jsonMap = await PaymentApi().loadData(token: token);
    listPayment =
        jsonMap.map((e) => PaymentViewModel(paymentModel: e)).toList();

    newListPayment.addAll(listPayment!);

    notifyListeners();
  }
}
