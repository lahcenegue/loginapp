import 'package:http/http.dart' as http;
import 'package:loginapp/constants/constants.dart';
import 'dart:convert' as convert;

import 'package:loginapp/screens/home/add/add_model.dart';

Future<AddResponseModel> apiAdd(
    {required String token, required AddRequestModel addRequestModel}) async {
  try {
    var url = Uri.parse("${Constants.url}/payment/api/add?token=$token");
    http.Response response = await http.post(
      url,
      body: addRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      AddResponseModel loginCodeModel = AddResponseModel.fromJson(body);

      return loginCodeModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return AddResponseModel();
}
