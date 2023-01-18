import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/payment/payment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

List<PaymentModel> payment = [];

class PaymentApi {
  Future<List<PaymentModel>> loadData(
      {required String token, required int page}) async {
    try {
      var url =
          Uri.parse("${Constants.url}/payment/api/all/$page?token=$token");

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var data = convert.jsonDecode(response.body);

        Iterable list = data;

        List<PaymentModel> paymentModel =
            list.map((e) => PaymentModel.fromJson(e)).toList();

        payment = payment + paymentModel;

        return payment;
      }
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }
}
