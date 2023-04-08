import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:loginapp/screens/home_main/payment/payment_view_model.dart';
import 'package:loginapp/widgets/color_piker.dart';
import 'package:loginapp/widgets/icon_piker.dart';
import 'package:loginapp/widgets/text_row.dart';
import 'package:share_plus/share_plus.dart';

class PaymentChildren extends StatefulWidget {
  final String token;
  final String type;
  const PaymentChildren({
    super.key,
    required this.token,
    required this.type,
  });

  @override
  State<PaymentChildren> createState() => _PaymentChildrenState();
}

class _PaymentChildrenState extends State<PaymentChildren> {
  final controller = ScrollController();

  HomeViewModel hvm = HomeViewModel();
  intl.DateFormat? dateFormat;

  //
  List<PaymentViewModel> posts = [];
  bool isLoadingMore = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    dateFormat = intl.DateFormat('EEEE yyyy/MM/dd hh:mm a', "ar_DZ");

    controller.addListener(_scrollListener);

    hvm.fetchPaymentList(token: widget.token, type: widget.type, page: page);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      hvm.addListener(() {
        setState(() {});
      });
    }

    if (hvm.listPayment == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      posts = hvm.listPayment!;
      return Scaffold(
        body: ListView.separated(
          controller: controller,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(15),
          itemCount: isLoadingMore ? posts.length + 1 : posts.length,
          separatorBuilder: (buildContext, index) {
            return Column(
              children: const [
                SizedBox(height: 08),
                Divider(
                  endIndent: 50,
                  indent: 50,
                ),
                SizedBox(height: 08),
              ],
            );
          },
          itemBuilder: (buildContext, index) {
            if (index < hvm.listPayment!.length) {
              var paymentList = posts[index];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
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
                            color: colorPiker(paymentList.show1),
                          ),
                        ),
                        const SizedBox(width: 5),
                        iconPiker(paymentList.show1),
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
                                    subject: "${paymentList.name}مشاركه عنوان ",
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
      );
    }
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      page = page + 1;
      await hvm
          .fetchPaymentList(token: widget.token, type: widget.type, page: page)
          .then(
        (value) {
          setState(
            () {
              isLoadingMore = false;
            },
          );
        },
      );
    }
  }
}

//


