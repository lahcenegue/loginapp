import 'package:flutter/material.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_api.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_model.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_view_model.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_info/get_info_api.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_info/get_info_view_model.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_info/update_info_model.dart';
import 'package:loginapp/screens/home_main/groupe/group_view_model.dart';
import 'package:loginapp/screens/home_main/groupe/groupe_api.dart';
import 'package:loginapp/screens/home_main/groupe/groupe_model.dart';
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
  MainViewModel? mainInfo;
  GetInfoViewModel? getInfo;
  List<NotificationViewModel>? listNotification;
  List<StatementViewModel>? listStatement;
  List<GroupViewModel>? listGroups;

  //list payment
  Future<void> fetchPaymentList(
      {required String token, required int page}) async {
    List<PaymentModel> jsonMap =
        await PaymentApi().loadData(token: token, page: page);
    listPayment =
        jsonMap.map((e) => PaymentViewModel(paymentModel: e)).toList();

    notifyListeners();
  }

  //get main info
  Future<void> fetchMainInfo({required String token}) async {
    MainModel jsonInfo = await getMainInfo(token: token);

    mainInfo = MainViewModel(mainModel: jsonInfo);

    notifyListeners();
  }

  // get info update
  Future<void> fetchGetInfo({required String token}) async {
    GetInfoModel jsonInfo = await getInfoApi(token: token);

    getInfo = GetInfoViewModel(getInfoModel: jsonInfo);
    notifyListeners();
  }

  // get list notification
  Future<void> fetchListNotification(
      {required String token, required int page}) async {
    List<NotificationModel> jsonNot =
        await loadNotificationList(token: token, page: page);

    listNotification = jsonNot
        .map((e) => NotificationViewModel(notificationModel: e))
        .toList();
    notifyListeners();
  }

  // get list Statement
  Future<void> fetchListStatement({
    required int typePage,
    required String token,
    required String type,
    int? pageNum,
  }) async {
    List<StatementModel> jsonNot = await loadStatementList(
      typePage: typePage,
      pageNum: pageNum,
      token: token,
      type: type,
    );

    listStatement =
        jsonNot.map((e) => StatementViewModel(statementModel: e)).toList();
    notifyListeners();
  }

  // get list groups
  Future<void> fetchGroupsList(
      {required String token, required int page}) async {
    List<GroupeResponseModel> jsonMap =
        await loadGroups(token: token, page: page);
    listGroups =
        jsonMap.map((e) => GroupViewModel(groupeResponseModel: e)).toList();

    notifyListeners();
  }
}
