import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/add/add_screen.dart';
import 'package:loginapp/screens/home/contact/contact_screen.dart';
import 'package:loginapp/screens/home/groupe/groupe_screen.dart';
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
  String? name;

  getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
  }

  deletePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');
  }

  @override
  void initState() {
    getSharedValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
            ),
          ],
        ),
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
                          name == null ? "" : name!,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'المجوع 5 د.ك',
                          style: TextStyle(fontSize: 20),
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
                  onTap: () {},
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
        body: name == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
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
                            name!,
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
                        child: Row(
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
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
