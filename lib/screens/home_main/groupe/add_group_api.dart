import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/groupe/groupe_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<AddGroupModel> apiAddGroup(
    {required GroupRequestModel groupRequestModel,
    required String token}) async {
  try {
    var url = Uri.parse("${Constants.url}/payment/api/add?token=$token");
    http.Response response = await http.post(
      url,
      body: groupRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      AddGroupModel addGroupModel = AddGroupModel.fromJson(body);

      return addGroupModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return AddGroupModel();
}
