import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/login_code/login_code_model.dart';
import 'package:loginapp/widgets/one_signal_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<LoginCodeModel> apiLoginCode(String phone, yourCode) async {
  try {
    var url = Uri.parse(
        "${Constants.url}/api/login/${OneSignalControler.osUserID}/$phone/$yourCode");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      LoginCodeModel loginCodeModel = LoginCodeModel.fromJson(body);

      return loginCodeModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return LoginCodeModel();
}
