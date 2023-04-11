import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:loginapp/screens/home_main/groupe/add_groupe.dart';
import 'package:loginapp/screens/home_main/groupe/group_view_model.dart';
import 'package:loginapp/widgets/icon_piker.dart';
import 'package:loginapp/widgets/text_row.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart' as intl;

class GroupeScreen extends StatefulWidget {
  final String token;
  const GroupeScreen({
    super.key,
    required this.token,
  });

  @override
  State<GroupeScreen> createState() => _GroupeScreenState();
}

class _GroupeScreenState extends State<GroupeScreen> {
  final controller = ScrollController();
  HomeViewModel hvm = HomeViewModel();
  intl.DateFormat? dateFormat;

  List<GroupViewModel> posts = [];
  bool isLoadingMore = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    dateFormat = intl.DateFormat('EEEE yyyy/MM/dd hh:mm a', "ar_DZ");
    controller.addListener(_scrollListener);

    hvm.fetchGroupsList(token: widget.token, page: page);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });
    if (hvm.listGroups == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      posts = hvm.listGroups!;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('المجموعات'),
          ),
          body: ListView.separated(
            controller: controller,
            itemCount: isLoadingMore ? posts.length + 1 : posts.length,
            separatorBuilder: (buildContext, index) {
              return const SizedBox(height: 5);
            },
            itemBuilder: (buildContext, index) {
              if (index < posts.length) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Constants.boxColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _colorPiker(posts[index].show1)),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.boxShadow,
                        offset: const Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .035),
                          const Icon(Icons.group),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .05),
                          Text(
                            posts[index].name,
                            style: TextStyle(
                              fontSize: 18,
                              color: Constants.kMainColor,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          iconPiker(posts[index].show1),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextRow(
                        text1: 'المبلع الكلي',
                        text2: posts[index].amountall,
                      ),
                      TextRow(
                        text1: 'أقل مبلغ',
                        text2: posts[index].amount.toString(),
                      ),
                      TextRow(
                        text1: 'التعليق',
                        text2: posts[index].comment,
                      ),
                      TextRow(
                        text1: 'بتاريخ',
                        text2: dateFormat!.format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(posts[index].date1) * 1000000)),
                      ),
                      Visibility(
                          visible: posts[index].sharebutton == 0 ? false : true,
                          child: Column(
                            children: [
                              const Divider(
                                endIndent: 40,
                                indent: 40,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Share.share(
                                      """
                                  مرحبا:${posts[index].name}
                                  يمكنك دفع المبلغ :${posts[index].amount}
                                  عبر:${Constants.url}/g/${posts[index].md5id}
                                       """,
                                      subject:
                                          "${posts[index].name}مشاركه المجموعة ",
                                    );
                                  },
                                  icon: const Icon(Icons.share)),
                            ],
                          ))
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

          // body: const Center(
          //   child: Text(
          //     'لم تقم بإضافة مجموعات خاصة بك بعد.',
          //     textAlign: TextAlign.center,
          //     maxLines: 2,
          //     style: TextStyle(fontSize: 24),
          //   ),
          // ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Constants.kMainColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddGroupeScreen(
                    token: widget.token,
                  ),
                ),
              );
            },
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
      await hvm.fetchGroupsList(token: widget.token, page: page).then(
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

Color _colorPiker(String show1) {
  Color pickedColor;

  if (show1 == "0") {
    pickedColor = Colors.blue;
  } else if (show1 == "2") {
    pickedColor = Colors.red;
  } else if (show1 == "3") {
    pickedColor = Colors.orange;
  } else if (show1 == "4") {
    pickedColor = Colors.green;
  } else {
    throw {"err"};
  }
  return pickedColor;
}
