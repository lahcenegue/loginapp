import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/add_statment/add_statement_screen.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_children.dart';

class StatementScreen extends StatelessWidget {
  final int balance;
  final String tokn;
  const StatementScreen({
    super.key,
    required this.balance,
    required this.tokn,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          body: TabBarView(
            children: [
              //all statement
              StatementChildren(
                token: tokn,
                pageType: 1,
                type: "all",
                pageNum: 1,
              ),

              //cash statement
              StatementChildren(
                token: tokn,
                pageType: 5,
                type: "cach",
                pageNum: 1,
              ),

              //disposting statnebt
              StatementChildren(
                token: tokn,
                pageType: 1,
                type: "disposting",
                pageNum: 1,
              ),

              //request statement
              StatementChildren(
                token: tokn,
                pageType: 8,
                type: "request",
                pageNum: 1,
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Constants.kMainColor,
            child: const Icon(Icons.upload),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStatementScreen(
                    token: tokn,
                    balance: balance,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
