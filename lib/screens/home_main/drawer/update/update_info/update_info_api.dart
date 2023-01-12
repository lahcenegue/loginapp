import 'package:http/http.dart' as http;
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'dart:convert' as convert;

import 'package:loginapp/screens/home_main/drawer/update/update_info/update_info_model.dart';

Future<UpdateInfoResponseModel> apiUpdateInfo(
    {required UpdateInfoRequestModel updateInfoRequestModel}) async {
  try {
    var url = Uri.parse("${Constants.url}/api/profile?token=$token");
    http.Response response = await http.post(
      url,
      body: updateInfoRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      UpdateInfoResponseModel updateInfoResponseModel =
          UpdateInfoResponseModel.fromJson(body);

      return updateInfoResponseModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return UpdateInfoResponseModel();
}
