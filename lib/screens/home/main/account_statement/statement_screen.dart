import 'package:flutter/material.dart';
import 'package:loginapp/screens/home/main/account_statement/statement.dart';

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
            body: const TabBarView(
              children: [
                //all statement
                Statement(
                  pageType: 1,
                  pageNum: null,
                ),

                //cash statement
                Statement(
                  pageType: 5,
                  pageNum: 1,
                ),

                //disposting statnebt
                Statement(
                  pageType: 1,
                  pageNum: 1,
                ),

                //request statement
                Statement(
                  pageType: 8,
                  pageNum: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
