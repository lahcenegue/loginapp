import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiServices {
  //login with phone number
  Future<LoginMobileModel> loginMobile(String phone) async {
    try {
      var url = Uri.parse("${Constants.url}/api/login/kdjvuig11221/$phone");
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

  //enter the code
  Future<LoginCodeModel> loginCode(String phone, yourCode) async {
    try {
      var url =
          Uri.parse("${Constants.url}/api/login/kdjvuig11221/$phone/$yourCode");
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
}
