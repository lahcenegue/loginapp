import 'package:flutter/material.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:loginapp/screens/home/main/account_statement/all_statement.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
                title: const Text("كشف الحساب"),
                bottom: const TabBar(tabs: [
                  Tab(
                    text: 'الجميع',
                  ),
                  Tab(
                    text: 'السحب',
                  ),
                  Tab(
                    text: 'الايداع',
                  ),
                  Tab(
                    text: 'طلبات',
                  ),
                ]),
              ),
              body: TabBarView(children: [
                const AllStatement(),
                Container(
                  height: 50,
                  color: Colors.red,
                ),
                Container(
                  height: 50,
                  color: Colors.blue,
                ),
                Container(
                  height: 50,
                  color: Colors.green,
                ),
              ])),
        ),
      ),
    );
  }
}
