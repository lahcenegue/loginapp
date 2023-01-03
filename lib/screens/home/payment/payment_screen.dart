import 'package:flutter/material.dart';
import 'package:loginapp/screens/home/home_view_model.dart';

class PaymentScreen extends StatefulWidget {
  final String token;
  const PaymentScreen({super.key, required this.token});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  HomeViewModel hvm = HomeViewModel();

  @override
  void initState() {
    super.initState();
    hvm.fetchPaymentList(token: widget.token);
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });
    return Scaffold(
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
              itemBuilder: (buildContext, index) {
                return Card();
              },
              separatorBuilder: (buildContext, index) {
                return const SizedBox(height: 10);
              },
            ),
    );
  }
}
