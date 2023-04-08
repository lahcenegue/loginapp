import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/register/register_response_model.dart';
import 'package:loginapp/widgets/one_signal_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<RegisterResponseModel> apiRegister({
  required String phone,
  required String yourCode,
  required RegisterRequestModel registerRequestModel,
}) async {
  RegisterResponseModel responseModel = RegisterResponseModel();

  try {
    var url = Uri.parse(
        "${Constants.loginLink}/${OneSignalControler.osUserID}/$phone/$yourCode/reg?");
    http.Response response = await http.post(
      url,
      body: registerRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.json.decode(response.body);

      responseModel = RegisterResponseModel.fromJson(body);

      return responseModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return responseModel;
}
