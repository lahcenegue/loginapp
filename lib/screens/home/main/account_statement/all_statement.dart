import 'package:flutter/material.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:intl/intl.dart' as intl;

class AllStatement extends StatefulWidget {
  const AllStatement({super.key});

  @override
  State<AllStatement> createState() => _AllStatementState();
}

class _AllStatementState extends State<AllStatement> {
  HomeViewModel hvm = HomeViewModel();
  intl.DateFormat? dateFormat;

  @override
  void initState() {
    hvm.fetchListStatement(typePage: 1);
    dateFormat = intl.DateFormat('yyyy-MM-dd hh:mm a', "ar_DZ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });
    if (hvm.listStatement == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
            child: Scaffold(
          body: ListView.builder(
              itemCount: hvm.listStatement!.length,
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
