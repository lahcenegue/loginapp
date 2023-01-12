import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/main/account_statement/statement_children.dart';

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
                StatementChildren(
                  pageType: 1,
                  pageNum: null,
                ),

                //cash statement
                StatementChildren(
                  pageType: 5,
                  pageNum: 1,
                ),

                //disposting statnebt
                StatementChildren(
                  pageType: 1,
                  pageNum: 1,
                ),

                //request statement
                StatementChildren(
                  pageType: 8,
                  pageNum: 1,
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Constants.kMainColor,
              child: const Icon(Icons.upload),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
