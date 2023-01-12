import 'package:flutter/material.dart';
import 'package:loginapp/screens/home/notification/notification_view_model.dart';
import 'package:intl/intl.dart' as intl;

class NotificationScreen extends StatelessWidget {
  final List<NotificationViewModel> notInfo;
  const NotificationScreen({
    super.key,
    required this.notInfo,
  });

  @override
  Widget build(BuildContext context) {
    intl.DateFormat? dateFormat;
    dateFormat = intl.DateFormat('yyyy-MM-dd hh:mm a', "ar_DZ");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("الاشعارات"),
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: notInfo.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: const Text("تم الدفع من قبل"),
                  subtitle: Text(
                      "${notInfo[index].text2} - مبلغ:  ${notInfo[index].text1}"),
                  leading: const Icon(Icons.notifications),
                  trailing: Text(
                    dateFormat!.format(DateTime.fromMicrosecondsSinceEpoch(
                        int.parse(notInfo[index].dateadd) * 1000000)),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
