import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home/payment/payment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PaymentApi {
  Future<List<PaymentModel>> loadData() async {
    try {
      var url = Uri.parse("${Constants.url}/payment/api/all?token=$token");
      http.Response response = await http.get(url);

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
}
