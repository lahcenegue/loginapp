import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/payment/payment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<PaymentModel>> apiSearch(
    {required String token, required String query}) async {
  try {
    var url = Uri.parse("${Constants.url}/payment/api/search?token=$token");

    http.Response response = await http.post(
      url,
      body: {"search": query},
    );

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      Iterable list = data;

      List<PaymentModel> paymentModel =
          list.map((e) => PaymentModel.fromJson(e)).toList();

      return paymentModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
