import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home/add/add_screen.dart';
import 'package:loginapp/screens/home/contact/contact_screen.dart';
import 'package:loginapp/screens/home/groupe/groupe_screen.dart';
import 'package:loginapp/screens/home/main/update/update_info/update_info_screen.dart';
import 'package:loginapp/screens/home/main/update/update_password/update_pass_screen.dart';
import 'package:loginapp/screens/home/notification/notification_screen.dart';
import 'package:loginapp/screens/home/payment/payment_screen.dart';
import 'package:loginapp/screens/login_mobile/login_mobile_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/costum_container.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomeViewModel hvm = HomeViewModel();
  int? notificationLength;
  int? oldNotificationLength;
  int? newNot;

  saveNot(int notification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('not', notification);
    print("notification succes");
  }

  getNot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    oldNotificationLength = prefs.getInt('not');
    print("get not succes");
  }

  deletePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');
  }

  @override
  void initState() {
    hvm.fetchMainInfo();
    hvm.fetchListNotification();
    getNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    hvm.addListener(() {
      setState(() {});
    });

    if (hvm.mainInfo == null || hvm.listNotification == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      notificationLength = hvm.listNotification!.length;
      newNot = notificationLength! - oldNotificationLength!;
      saveNot(notificationLength!);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Share.share(
                    """
                          مرحبا، يمكنك الدفع لـ: $name
                          عبر: ${Constants.url}/u/
                                """,
                    subject: "مشاركة الرابط",
                  );
                },
              ),
              Stack(
                children: [
                  Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen(
                                      notInfo: hvm.listNotification!,
                                    )));
                      },
                    ),
                  ),
                  Visibility(
                    visible: newNot == 0 ? false : true,
                    child: Positioned(
                      top: 5,
                      right: 0,
                      child: Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            newNot.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          //drawer
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  tileMode: TileMode.repeated,
                  colors: [
                    Constants.kMainColor,
                    Colors.white,
                  ],
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.only(top: 100),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name = hvm.mainInfo!.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${hvm.mainInfo!.balance} د.ك',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: customButton(
                      title: "الرئيسية",
                      icon: Icons.home,
                      topPadding: 10,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text(
                      "كشف الحساب",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_mail),
                    title: const Text(
                      "اتصل بنا",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_support_rounded),
                    title: const Text(
                      "الدعم الفني",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text(
                      "مشاركة التطبيق",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Share.share(
                        """
                    حمل تطبيق بوابة الدفع: 
                    ${Constants.downloadLinkApp}
                    """,
                        subject: "تحميل التطبيق",
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.update),
                    title: const Text(
                      "تحديث البيانات",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              actionsPadding: const EdgeInsets.only(
                                  bottom: 30.0, left: 10, right: 10),
                              title: const Text(
                                'تحديث البيانات',
                                textAlign: TextAlign.center,
                              ),
                              content: Text(
                                'مرحبا $name',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                customButton(
                                  icon: Icons.portrait_sharp,
                                  title: 'تعديل الملف الشخصي',
                                  topPadding: 1,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UpdateInfoScreen(),
                                      ),
                                    );
                                  },
                                ),
                                customButton(
                                  icon: Icons.password,
                                  title: 'تعديل كلمة المرور',
                                  topPadding: 20,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UpdatePassScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.black,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      "تسجيل الخروج",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginMobileScreen(),
                        ),
                      );
                      await deletePrefs();
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 60, top: 10),
                  height: screenHeight * 0.25,
                  width: screenWidth,
                  color: Constants.kMainColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'أهلا',
                        style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        hvm.mainInfo!.name,
                        style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.2,
                  child: SizedBox(
                    width: screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            customContainer(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddScreen(),
                                    ));
                              },
                              icon: Icons.add_circle_outline,
                              title: 'إظافة',
                            ),
                            customContainer(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PaymentScreen(),
                                    ));
                              },
                              icon: Icons.payment_outlined,
                              title: 'عمليات الدفع',
                            ),
                            customContainer(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GroupeScreen(),
                                    ));
                              },
                              icon: Icons.group,
                              title: 'المجموعات',
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.08),
                        Text(
                          "رصيد الحساب",
                          style: TextStyle(
                            color: Constants.kMainColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        FittedBox(
                          alignment: Alignment.center,
                          child: Text(
                            "${hvm.mainInfo!.balance} د.ك",
                            style: const TextStyle(
                              fontSize: 38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
