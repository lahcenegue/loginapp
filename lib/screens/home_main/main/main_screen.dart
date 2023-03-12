import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home_main/add/add_screen.dart';
import 'package:loginapp/screens/home_main/drawer/contact/contact_screen.dart';
import 'package:loginapp/screens/home_main/drawer/logout/logout_api.dart';
import 'package:loginapp/screens/home_main/groupe/groupe_screen.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/statement_screen.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_info/update_info_screen.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_password/update_pass_screen.dart';
import 'package:loginapp/screens/home_main/notification/notification_screen.dart';
import 'package:loginapp/screens/home_main/payment/payment_screen.dart';
import 'package:loginapp/screens/login_mobile/login_mobile_screen.dart';
import 'package:loginapp/widgets/costum_container.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

class MainScreen extends StatefulWidget {
  final String token;

  const MainScreen({
    super.key,
    required this.token,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomeViewModel hvm = HomeViewModel();

  int? notificationLength;
  int? oldNotificationLength;
  int? newNot;

  intl.DateFormat? dateFormat;

  bool isPermi = true;
  bool isApiCallProcess = false;

  deletePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');
  }

  @override
  void initState() {
    hvm.fetchMainInfo(token: widget.token);

    hvm.fetchListStatement(
      token: widget.token,
      typePage: 1,
      pageNum: 1,
      type: 'all',
    );
    dateFormat = intl.DateFormat('yyyy-MM-dd hh:mm a', "ar_DZ");

    checkStatuse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (mounted) {
      hvm.addListener(() {
        setState(() {});
      });
    }

    if (hvm.mainInfo == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share(
                  """
                        مرحبا، يمكنك الدفع لـ: $name
                        عبر: ${Constants.url}/u/${hvm.mainInfo!.id}
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
                                    token: widget.token,
                                  )));
                    },
                  ),
                ),
                Visibility(
                  visible: hvm.mainInfo!.not == 0 ? false : true,
                  child: Positioned(
                    top: 5,
                    right: 0,
                    child: Container(
                      height: 23,
                      width: 23,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            hvm.mainInfo!.not.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
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
          child: Stack(
            children: [
              ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        color: Constants.kMainColor,
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                  image: AssetImage(Constants.icon),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      name = hvm.mainInfo!.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    leading: const Icon(Icons.monetization_on_rounded),
                    title: Text(
                      '${hvm.mainInfo!.balance} د.ك',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text(
                      "كشف الحساب",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StatementScreen(
                            tokn: widget.token,
                            balance: hvm.mainInfo!.balance,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
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
                  ExpansionTile(
                    leading: const Icon(Icons.settings),
                    title: const Text(
                      'الإعدادات',
                      style: TextStyle(fontSize: 20),
                    ),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_pin),
                        title: const Text('تعديل الملف الشخصي'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateInfoScreen(
                                token: widget.token,
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.key),
                        title: const Text('تغيير كلمة المرور'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePassScreen(
                                token: widget.token,
                              ),
                            ),
                          );
                        },
                      ),
                      SwitchListTile(
                        title: const Text('تفعيل الاشعارات'),
                        secondary: const Icon(Icons.notifications_active),
                        value: isPermi,
                        onChanged: (value) async {
                          await openAppSettings();
                          if (await Permission.notification.isGranted) {
                            setState(() {
                              isPermi = true;
                            });
                          } else {
                            setState(() {
                              isPermi = false;
                            });
                          }
                        },
                      ),
                    ],
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
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      "تسجيل الخروج",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      logoutApi(token: widget.token).then((value) async {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.logout == 'ok') {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginMobileScreen(),
                            ),
                            (route) => false,
                          );
                          await deletePrefs();
                        }
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: isApiCallProcess ? true : false,
                child: Stack(
                  children: [
                    ModalBarrier(
                      color: Colors.white.withOpacity(0.6),
                      dismissible: true,
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 50,
                ),
                height: screenHeight * 0.23,
                width: screenWidth,
                color: Constants.kMainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.18,
                child: SizedBox(
                  width: screenWidth,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customContainer(
                            onTap: () {
                              if (hvm.mainInfo!.group == '2') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddScreen(
                                        token: widget.token,
                                      ),
                                    ));
                              }
                            },
                            icon: Icons.add_circle_outline,
                            title: 'إضافة',
                          ),
                          customContainer(
                            onTap: () {
                              if (hvm.mainInfo!.group == '2') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                        token: widget.token,
                                      ),
                                    ));
                              }
                            },
                            icon: Icons.payment_outlined,
                            title: 'عمليات الدفع',
                          ),
                          customContainer(
                            onTap: () {
                              if (hvm.mainInfo!.group == '3') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GroupeScreen(
                                        token: widget.token,
                                      ),
                                    ));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('عضويتك غير مفعلة'),
                                    content: Image.asset(
                                      'assets/images/user.png',
                                      height: 100,
                                      color: Colors.red,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('حسنا'),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                            icon: Icons.group,
                            title: 'المجموعات',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "رصيدك:",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          FittedBox(
                            alignment: Alignment.center,
                            child: Text(
                              "${hvm.mainInfo!.balance} د.ك",
                              style: const TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.40,
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  //width: screenWidth,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hvm.listStatement == null
                        ? 1
                        : hvm.listStatement!.length < 10
                            ? hvm.listStatement!.length
                            : 10,
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
                    itemBuilder: (BuildContext context, int index) {
                      return hvm.listStatement == null
                          ? const CircularProgressIndicator()
                          : ListTile(
                              leading: const Icon(
                                Icons.payment,
                                color: Colors.green,
                              ),
                              title: Text(hvm.listStatement![index].text2),
                              trailing: Text(
                                  "${hvm.listStatement![index].text1} د.ك"),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void checkStatuse() async {
    if (await Permission.notification.isDenied ||
        await Permission.notification.isPermanentlyDenied) {
      setState(() {
        isPermi = false;
      });
    } else {
      setState(() {
        isPermi = true;
      });
    }
  }
}
