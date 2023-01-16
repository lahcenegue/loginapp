import 'package:http/http.dart' as http;
import 'package:loginapp/constants/constants.dart';
import 'dart:convert' as convert;
import 'package:loginapp/screens/home_main/drawer/update/update_password/update_pass_model.dart';

Future<UpdatePassResponseModel> apiUpdatePass(
    {required UpdatePassRequestModel updatePassRequestModel,
    required String token}) async {
  try {
    var url = Uri.parse("${Constants.url}/api/profile?token=$token");
    http.Response response = await http.post(
      url,
      body: updatePassRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      UpdatePassResponseModel updatePassResponseModel =
          UpdatePassResponseModel.fromJson(body);

      return updatePassResponseModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return UpdatePassResponseModel();
}
