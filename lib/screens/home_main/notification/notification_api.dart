import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/notification/notification_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

List<NotificationModel> notificationList = [];

Future<List<NotificationModel>> loadNotificationList(
    {required String token, required int page}) async {
  try {
    var url =
        Uri.parse("${Constants.paymentLink}/notification/$page?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      Iterable list = data;

      List<NotificationModel> notificationModel =
          list.map((e) => NotificationModel.fromJson(e)).toList();

      notificationList = notificationList + notificationModel;

      return notificationList;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
