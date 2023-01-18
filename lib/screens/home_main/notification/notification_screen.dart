import 'package:flutter/material.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:loginapp/screens/home_main/notification/notification_view_model.dart';

class NotificationScreen extends StatefulWidget {
  final String token;
  const NotificationScreen({
    super.key,
    required this.token,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  HomeViewModel hvm = HomeViewModel();
  final controller = ScrollController();

  List<NotificationViewModel> posts = [];
  bool isLoadingMore = false;
  int page = 1;

  @override
  void initState() {
    controller.addListener(_scrollListener);
    hvm.fetchListNotification(token: widget.token, page: page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });

    if (hvm.listNotification == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      posts = hvm.listNotification!;
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("الاشعارات"),
            ),
            body: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(10),
                itemCount: isLoadingMore ? posts.length + 1 : posts.length,
                itemBuilder: (context, index) {
                  if (index < posts.length) {
                    return ListTile(
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].comment),
                      leading: const Icon(Icons.notifications),
                      trailing: Text(posts[index].time),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
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
      await hvm.fetchListNotification(token: widget.token, page: page).then(
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
