import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/home_view_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:loginapp/widgets/text_row.dart';
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
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Constants.boxColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: _colorPiker(hvm.listPayment![index].show1)),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.boxShadow,
                          offset: const Offset(4, 5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * .035),
                            const Icon(Icons.payment),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .05),
                            Text(
                              hvm.listPayment![index].name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Constants.kMainColor,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              '${hvm.listPayment![index].amount}د.ك',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color:
                                    _colorPiker(hvm.listPayment![index].show1),
                              ),
                            ),
                            const SizedBox(width: 5),
                            _iconPiker(hvm.listPayment![index].show1),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextRow(
                          text1: 'التعليق',
                          text2: hvm.listPayment![index].comment,
                        ),
                        TextRow(
                          text1: 'الهاتف',
                          text2: hvm.listPayment![index].mobile,
                        ),
                        TextRow(
                          text1: 'بتاريخ',
                          text2: dateFormat!.format(
                              DateTime.fromMicrosecondsSinceEpoch(int.parse(
                                      hvm.listPayment![index].paymentdate) *
                                  1000000)),
                        ),
                        Visibility(
                            visible: hvm.listPayment![index].show1 == '4'
                                ? true
                                : false,
                            child: Column(
                              children: [
                                const Divider(
                                  endIndent: 40,
                                  indent: 40,
                                ),
                                IconButton(
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
                                    icon: const Icon(Icons.share)),
                              ],
                            ))
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

Color _colorPiker(String show1) {
  Color pickedColor;

  if (show1 == "0") {
    pickedColor = Colors.blue;
  } else if (show1 == "2") {
    pickedColor = Colors.red;
  } else if (show1 == "3") {
    pickedColor = Colors.orange;
  } else if (show1 == "4") {
    pickedColor = Colors.green;
  } else {
    throw {"err"};
  }
  return pickedColor;
}

Icon _iconPiker(String show1) {
  Color pickedColor;
  IconData iconData;
  if (show1 == "0") {
    pickedColor = Colors.blue;
    iconData = Icons.new_releases;
  } else if (show1 == "2") {
    pickedColor = Colors.red;
    iconData = Icons.sms_failed_outlined;
  } else if (show1 == "3") {
    pickedColor = Colors.orange;
    iconData = Icons.timelapse;
  } else if (show1 == "4") {
    pickedColor = Colors.green;
    iconData = Icons.check_circle_sharp;
  } else {
    throw {"err"};
  }
  return Icon(iconData, color: pickedColor, size: 20);
}
