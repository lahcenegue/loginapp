import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

List<StatementModel> listStatement = [];
String newType = 'all';

Future<List<StatementModel>> loadStatementList({
  required int typePage,
  int? pageNum,
  required String token,
  required String type,
}) async {
  try {
    if (newType != type) {
      newType = type;
      listStatement = [];
      var url = Uri.parse(type == "all"
          ? "${Constants.url}/payment/api/bills/$pageNum?token=$token"
          : "${Constants.url}/payment/api/bills/$pageNum/$typePage?token=$token");

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);

        Iterable list = data;

        List<StatementModel> statementModel =
            list.map((e) => StatementModel.fromJson(e)).toList();

        listStatement = listStatement + statementModel;

        return listStatement;
      }
    } else {
      newType = type;
      var url = Uri.parse(type == "all"
          ? "${Constants.url}/payment/api/bills/$pageNum?token=$token"
          : "${Constants.url}/payment/api/bills/$pageNum/$typePage?token=$token");

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);

        Iterable list = data;

        List<StatementModel> statementModel =
            list.map((e) => StatementModel.fromJson(e)).toList();

        listStatement = listStatement + statementModel;

        return listStatement;
      }
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
