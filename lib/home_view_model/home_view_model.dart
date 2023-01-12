import 'package:flutter/material.dart';
import 'package:loginapp/screens/home_main/main/account_statement/statement_api.dart';
import 'package:loginapp/screens/home_main/main/account_statement/statement_model.dart';
import 'package:loginapp/screens/home_main/main/account_statement/statement_view_model.dart';
import 'package:loginapp/screens/home_main/main/main_api.dart';
import 'package:loginapp/screens/home_main/main/main_model.dart';
import 'package:loginapp/screens/home_main/main/main_view_model.dart';
import 'package:loginapp/screens/home_main/notification/notification_api.dart';
import 'package:loginapp/screens/home_main/notification/notification_model.dart';
import 'package:loginapp/screens/home_main/notification/notification_view_model.dart';
import 'package:loginapp/screens/home_main/payment/payment_api.dart';
import 'package:loginapp/screens/home_main/payment/payment_model.dart';
import 'package:loginapp/screens/home_main/payment/payment_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<PaymentViewModel>? listPayment;
  List<PaymentViewModel> newListPayment = [];
  MainViewModel? mainInfo;
  List<NotificationViewModel>? listNotification;
  List<StatementViewModel>? listStatement;

  //list payment
  Future<void> fetchPaymentList() async {
    List<PaymentModel> jsonMap = await PaymentApi().loadData();
    listPayment =
        jsonMap.map((e) => PaymentViewModel(paymentModel: e)).toList();

    newListPayment.addAll(listPayment!);

    notifyListeners();
  }

  //get main info
  Future<void> fetchMainInfo() async {
    MainModel json = await MainApi().loadData();

    mainInfo = MainViewModel(mainModel: json);
    notifyListeners();
  }

  // get list notification
  Future<void> fetchListNotification() async {
    List<NotificationModel> jsonNot = await loadNotificationList();

    listNotification = jsonNot
        .map((e) => NotificationViewModel(notificationModel: e))
        .toList();
    notifyListeners();
  }

  // get list Statement
  Future<void> fetchListStatement({required int typePage, int? pageNum}) async {
    List<StatementModel> jsonNot =
        await loadStatementList(typePage: typePage, pageNum: pageNum);

    listStatement =
        jsonNot.map((e) => StatementViewModel(statementModel: e)).toList();
    notifyListeners();
  }
}
