import 'package:http/http.dart' as http;
import 'package:loginapp/constants/constants.dart';
import 'dart:convert' as convert;

import 'package:loginapp/screens/home_main/groupe/groupe_model.dart';

List<GroupeResponseModel> listGroups = [];

Future<List<GroupeResponseModel>> loadGroups(
    {required String token, required int page}) async {
  try {
    var url =
        Uri.parse("${Constants.url}/payment/api/group/$page?token=$token");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      Iterable list = data;

      List<GroupeResponseModel> groupModel =
          list.map((e) => GroupeResponseModel.fromJson(e)).toList();

      listGroups = listGroups + groupModel;

      return listGroups;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
