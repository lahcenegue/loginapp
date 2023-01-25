import 'package:flutter/material.dart';
import 'package:loginapp/screens/home_main/payment/payment_children.dart';
import 'package:loginapp/screens/home_main/search/seach_delegate.dart';

class PaymentScreen extends StatelessWidget {
  final String token;
  const PaymentScreen({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('عمليات الدفع'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              text: 'جميع العمليات',
            ),
            Tab(
              text: 'سجل المدفوعات',
            ),
          ]),
        ),
        body: TabBarView(children: [
          PaymentChildren(
            token: token,
            type: '1',
          ),
          PaymentChildren(
            token: token,
            type: '4',
          ),
        ]),
      ),
    );
  }
}

//


