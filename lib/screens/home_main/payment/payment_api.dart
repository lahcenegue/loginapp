import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/payment/payment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PaymentApi {
  Future<List<PaymentModel>> loadData(
      {required String token, required int page}) async {
    try {
      var url =
          Uri.parse("${Constants.url}/payment/api/all/$page?token=$token");
      print(url);
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
