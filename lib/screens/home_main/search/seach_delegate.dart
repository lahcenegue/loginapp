import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home_main/payment/payment_model.dart';
import 'package:loginapp/screens/home_main/search/search_api.dart';
import 'package:loginapp/widgets/text_row.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart' as intl;

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    intl.DateFormat? dateFormat =
        intl.DateFormat('EEEE yyyy/MM/dd hh:mm a', "ar_DZ");
    return FutureBuilder(
      future: apiSearch(token: token!, query: query),
      builder:
          (BuildContext context, AsyncSnapshot<List<PaymentModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (buildContext, index) {
              return const SizedBox(height: 20);
            },
            itemBuilder: (buildContext, index) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Constants.boxColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: _colorPiker(
                            snapshot.data![index].show1.toString())),
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
                          const Icon(Icons.payment),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * .05),
                          Text(
                            snapshot.data![index].name!,
                            style: TextStyle(
                              fontSize: 18,
                              color: Constants.kMainColor,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            '${snapshot.data![index].amount}د.ك',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _colorPiker(snapshot.data![index].show1!),
                            ),
                          ),
                          const SizedBox(width: 5),
                          _iconPiker(snapshot.data![index].show1!),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextRow(
                        text1: 'التعليق',
                        text2: snapshot.data![index].comment!,
                      ),
                      TextRow(
                        text1: 'الهاتف',
                        text2: snapshot.data![index].mobile!,
                      ),
                      TextRow(
                        text1: 'بتاريخ',
                        text2: dateFormat.format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(snapshot.data![index].date1!) *
                                    1000000)),
                      ),
                      Visibility(
                          visible: snapshot.data![index].sharebutton == 1
                              ? false
                              : true,
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
                                      مرحبا:${snapshot.data![index].name}
                                      يمكنك دفع المبلغ :${snapshot.data![index].amount}
                                      عبر:${Constants.url}/pay/${snapshot.data![index].md5id}
                                           """,
                                      subject:
                                          "${snapshot.data![index].name}مشاركه عنوان ",
                                    );
                                  },
                                  icon: const Icon(Icons.share)),
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
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

Icon _iconPiker(String show1) {
  Color pickedColor;
  IconData iconData;
  if (show1 == "0") {
    pickedColor = Colors.blue;
    iconData = Icons.new_releases;
  } else if (show1 == "2") {
    pickedColor = Colors.red;
    iconData = Icons.sms_failed_outlined;
  } else if (show1 == "3") {
    pickedColor = Colors.orange;
    iconData = Icons.timelapse;
  } else if (show1 == "4") {
    pickedColor = Colors.green;
    iconData = Icons.check_circle_sharp;
  } else {
    throw {"err"};
  }
  return Icon(iconData, color: pickedColor, size: 20);
}
