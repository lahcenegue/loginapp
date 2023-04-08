import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/login_mobile/login_mobile_model.dart';
import 'package:loginapp/widgets/one_signal_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<LoginMobileModel> apiLoginMobile(String phone) async {
  try {
    var url = Uri.parse(
        "${Constants.loginLink}/${OneSignalControler.osUserID}/$phone");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      LoginMobileModel loginMobileModel = LoginMobileModel.fromJson(body);

      return loginMobileModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return LoginMobileModel();
}
