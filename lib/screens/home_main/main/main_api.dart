import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/main/main_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<MainModel> getMainInfo({required String token}) async {
  try {
    var url = Uri.parse("${Constants.url}/payment/api/index?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      MainModel mainModel = MainModel.fromJson(body);

      return mainModel;
    }
  } catch (e) {
    throw Exception(e);
  }

  return MainModel();
}
