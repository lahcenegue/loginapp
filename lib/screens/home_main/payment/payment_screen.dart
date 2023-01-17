import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:loginapp/screens/home_main/payment/payment_view_model.dart';
import 'package:loginapp/widgets/text_row.dart';
import 'package:share_plus/share_plus.dart';

class PaymentScreen extends StatefulWidget {
  final String token;
  const PaymentScreen({
    super.key,
    required this.token,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final controller = ScrollController();

  HomeViewModel hvm = HomeViewModel();
  intl.DateFormat? dateFormat;

  //
  List<PaymentViewModel> posts = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    dateFormat = intl.DateFormat('EEEE yyyy/MM/dd hh:mm a', "ar_DZ");

    controller.addListener(_scrollListener);

    hvm.fetchPaymentList(token: widget.token, page: page);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });

    if (hvm.listPayment == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      posts = hvm.listPayment!;
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('عمليات الدفع'),
          ),
          body: ListView.separated(
            controller: controller,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
            itemCount: posts.length,
            separatorBuilder: (buildContext, index) {
              return const SizedBox(height: 20);
            },
            itemBuilder: (buildContext, index) {
              if (index < hvm.listPayment!.length) {
                var paymentList = posts[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Constants.boxColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _colorPiker(paymentList.show1)),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.boxShadow,
                        offset: const Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(index.toString()),
                      Text(paymentList.id),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .035),
                          const Icon(Icons.payment),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .05),
                          Text(
                            paymentList.name,
                            style: TextStyle(
                              fontSize: 18,
                              color: Constants.kMainColor,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            '${paymentList.amount}د.ك',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _colorPiker(paymentList.show1),
                            ),
                          ),
                          const SizedBox(width: 5),
                          _iconPiker(paymentList.show1),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextRow(
                        text1: 'التعليق',
                        text2: paymentList.comment,
                      ),
                      TextRow(
                        text1: 'الهاتف',
                        text2: paymentList.mobile,
                      ),
                      TextRow(
                        text1: 'بتاريخ',
                        text2: dateFormat!.format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(paymentList.date1) * 1000000)),
                      ),
                      Visibility(
                          visible: paymentList.sharebutton == 1 ? false : true,
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
        مرحبا:${paymentList.name}
        يمكنك دفع المبلغ :${paymentList.amount}
        عبر:${Constants.url}/pay/${paymentList.md5id}
            """,
                                      subject:
                                          "${paymentList.name}مشاركه عنوان ",
                                    );
                                  },
                                  icon: const Icon(Icons.share)),
                            ],
                          ))
                    ],
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      );
    }
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      page = page + 1;
      hvm.fetchPaymentList(token: widget.token, page: page);
    } else {
      print("dont call");
    }
  }
}

//

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
