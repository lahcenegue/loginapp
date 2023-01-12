import 'package:http/http.dart' as http;
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'dart:convert' as convert;

import 'package:loginapp/screens/home_main/main/account_statement/add_statment/add_statement_model.dart';

Future<AddStatementResponse> apiStatmentAdd(
    {required AddStatementRequest addStatementRequest}) async {
  try {
    var url = Uri.parse("${Constants.url}/payment/api/billsadd?token=$token");
    http.Response response = await http.post(
      url,
      body: addStatementRequest.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      AddStatementResponse loginCodeModel = AddStatementResponse.fromJson(body);

      return loginCodeModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return AddStatementResponse();
}
