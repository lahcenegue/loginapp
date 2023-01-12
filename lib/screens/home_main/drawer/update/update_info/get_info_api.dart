import 'package:http/http.dart' as http;
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'dart:convert' as convert;

import 'package:loginapp/screens/home_main/drawer/update/update_info/update_info_model.dart';

Future<GetInfoModel> getInfoApi() async {
  try {
    var url = Uri.parse("${Constants.url}/api/profile?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      GetInfoModel getInfoModel = GetInfoModel.fromJson(body);

      return getInfoModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return GetInfoModel();
}
