import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiServices {
  //creat account
  Future<LoginMobileModel> login(String phone) async {
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
}
