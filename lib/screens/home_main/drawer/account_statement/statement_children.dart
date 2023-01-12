import 'package:flutter/material.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:intl/intl.dart' as intl;

class StatementChildren extends StatefulWidget {
  final int pageType;
  final int? pageNum;
  const StatementChildren({
    super.key,
    required this.pageType,
    this.pageNum,
  });

  @override
  State<StatementChildren> createState() => _StatementChildrenState();
}

class _StatementChildrenState extends State<StatementChildren> {
  HomeViewModel hvm = HomeViewModel();
  intl.DateFormat? dateFormat;

  @override
  void initState() {
    hvm.fetchListStatement(
      typePage: widget.pageType,
      pageNum: widget.pageNum,
    );
    dateFormat = intl.DateFormat('yyyy-MM-dd hh:mm a', "ar_DZ");
    super.initState();
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
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
            child: Scaffold(
          body: ListView.separated(
              itemCount: hvm.listStatement!.length,
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
                return ListTile(
                  leading: const Icon(Icons.payment),
                  title: Text(hvm.listStatement![index].text2),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${hvm.listStatement![index].text1} د.ك"),
                      Text(
                        dateFormat!.format(DateTime.fromMicrosecondsSinceEpoch(
                            int.parse(hvm.listStatement![index].dateadd) *
                                1000000)),
                      ),
                    ],
                  ),
                );
              }),
        )),
      );
    }
  }
}
