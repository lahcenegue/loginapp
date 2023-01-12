import 'package:http/http.dart' as http;
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'dart:convert' as convert;

import 'package:loginapp/screens/home_main/main/main_model.dart';

class MainApi {
  Future<MainModel> loadData() async {
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
}