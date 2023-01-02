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

  //Register
  Future<RegisterResponseModel> register({
    required String phone,
    required String yourCode,
    required String name,
    required String civilNumber,
    required String email,
    required String password,
  }) async {
    RegisterResponseModel responseModel = RegisterResponseModel();

    try {
      var url = Uri.parse(
          "${Constants.url}/api/login/kdjvuig11221/$phone/$yourCode/reg?name=$name&psot=$civilNumber&email=$email&password=$password");
      http.Response response = await http.get(url);

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
}
