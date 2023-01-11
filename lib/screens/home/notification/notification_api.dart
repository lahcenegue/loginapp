import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/notification/notification_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<NotificationModel>> loadData({required String token}) async {
  try {
    var url = Uri.parse("${Constants.url}/payment/api/bills?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      Iterable list = data;

      List<NotificationModel> notificationModel =
          list.map((e) => NotificationModel.fromJson(e)).toList();

      return notificationModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
