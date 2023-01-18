import 'package:flutter/material.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_view_model.dart';

class StatementChildren extends StatefulWidget {
  final int pageType;
  final int? pageNum;
  final String token;
  final String type;
  const StatementChildren({
    super.key,
    required this.pageType,
    required this.token,
    required this.type,
    this.pageNum,
  });

  @override
  State<StatementChildren> createState() => _StatementChildrenState();
}

class _StatementChildrenState extends State<StatementChildren> {
  final controller = ScrollController();
  HomeViewModel hvm = HomeViewModel();
  intl.DateFormat? dateFormat;

  //
  List<StatementViewModel> items = [];
  bool isLoadingMore = false;
  int page = 1;

  @override
  void initState() {
    controller.addListener(_scrollListener);
    hvm.fetchListStatement(
      token: widget.token,
      typePage: widget.pageType,
      pageNum: widget.pageNum,
      type: widget.type,
    );
    dateFormat = intl.DateFormat('yyyy-MM-dd hh:mm a', "ar_DZ");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      hvm.addListener(() {
        setState(() {});
      });
    }

    if (hvm.listStatement == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (hvm.listStatement!.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('لا يوجد أي عناصر أخرى'),
        ),
      );
    } else {
      items = hvm.listStatement!;

      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            body: ListView.separated(
              controller: controller,
              itemCount: isLoadingMore ? items.length + 1 : items.length,
              separatorBuilder: (context, index) => Column(
                children: const [
                  SizedBox(height: 10),
                  Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
                  SizedBox(height: 10),
                ],
              ),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return ListTile(
                    leading: const Icon(Icons.payment),
                    title: Text(items[index].text2),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${items[index].text1} د.ك"),
                        Text(
                          dateFormat!.format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  int.parse(items[index].dateadd) * 1000000)),
                        ),
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
          .fetchListStatement(
        token: widget.token,
        typePage: widget.pageType,
        type: widget.type,
        pageNum: page,
      )
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
