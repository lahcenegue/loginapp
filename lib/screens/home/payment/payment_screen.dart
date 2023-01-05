import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/home_view_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:share_plus/share_plus.dart';

class PaymentScreen extends StatefulWidget {
  final String token;
  const PaymentScreen({super.key, required this.token});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  HomeViewModel hvm = HomeViewModel();
  intl.DateFormat? dateFormat;

  @override
  void initState() {
    super.initState();
    hvm.fetchPaymentList(token: widget.token);
    dateFormat = intl.DateFormat('EEEE yyyy/MM/dd hh:mm a', "ar_DZ");
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('عمليات الدفع'),
        ),
        body: hvm.listPayment == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                physics: const ScrollPhysics(),
                itemCount: hvm.listPayment!.length,
                separatorBuilder: (buildContext, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (buildContext, index) {
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.payment),
                            const SizedBox(width: 20),
                            Text(hvm.listPayment![index].name),
                            const Expanded(child: SizedBox()),
                            Text(hvm.listPayment![index].amount),
                            const Text('د.ك'),
                            const SizedBox(width: 5),
                            Icon(hvm.listPayment![index].paymentdate != "0"
                                ? Icons.check_circle_outlined
                                : Icons.error_outline),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text('التعليق'),
                        Row(
                          children: [
                            const Text('الهاتف'),
                            const SizedBox(width: 20),
                            Text(hvm.listPayment![index].mobile),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('التاريخ'),
                            const SizedBox(width: 20),
                            Text(dateFormat!.format(
                                DateTime.fromMicrosecondsSinceEpoch(int.parse(
                                        hvm.listPayment![index].paymentdate) *
                                    1000000))),
                          ],
                        ),
                        Visibility(
                            visible: hvm.listPayment![index].show1 == '4'
                                ? true
                                : false,
                            child: IconButton(
                                onPressed: () {
                                  Share.share(
                                    """
مرحبا:${hvm.listPayment![index].name}
يمكنك دفع المبلغ :${hvm.listPayment![index].amount}
عبر:${Constants.url}/pay/${hvm.listPayment![index].md5id}
                """,
                                    subject:
                                        "${hvm.listPayment![index].name}مشاركه عنوان ",
                                  );
                                },
                                icon: const Icon(Icons.share)))
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
