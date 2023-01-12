import 'package:flutter/material.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
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
                ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.payment),
                        title: Text("name"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("40 dinar"),
                            Text("date"),
                          ],
                        ),
                      );
                    }),
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
