import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("الاشعارات"),
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text("عملية الدفع"),
                  subtitle: Text("دفع لحسن 20 دينار"),
                  leading: Icon(Icons.notifications),
                  trailing: Text("date"),
                );
              }),
        ),
      ),
    );
  }
}
