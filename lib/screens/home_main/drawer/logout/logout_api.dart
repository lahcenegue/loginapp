import 'package:loginapp/constants/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:loginapp/screens/home_main/drawer/logout/logout_model.dart';

Future<LogoutModel> logoutApi({required String token}) async {
  try {
    var url = Uri.parse("${Constants.logoutLink}?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      LogoutModel logoutModel = LogoutModel.fromJson(body);

      return logoutModel;
    }
  } catch (e) {
    throw Exception(e);
  }

  return LogoutModel();
}
