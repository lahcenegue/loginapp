import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<StatementModel>> loadStatementList(
    {required int typePage, int? pageNum, required String token}) async {
  try {
    var url = Uri.parse(pageNum == null
        ? "${Constants.url}/payment/api/bills/$typePage?token=$token"
        : "${Constants.url}/payment/api/bills/$pageNum/$typePage?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      Iterable list = data;

      List<StatementModel> statementModel =
          list.map((e) => StatementModel.fromJson(e)).toList();

      return statementModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
