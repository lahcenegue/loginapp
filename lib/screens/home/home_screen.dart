import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/add/add_screen.dart';
import 'package:loginapp/screens/home/groupe/groupe_screen.dart';
import 'package:loginapp/screens/home/notification/notification_screen.dart';
import 'package:loginapp/screens/home/payment/payment_screen.dart';
import 'package:loginapp/widgets/costum_container.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
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
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Constants.kMainColor,
                ),
                child: Row(
                  children: const [
                    CircleAvatar(),
                    Text('name'),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Text("كشف الحساب"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Text("اتصل بنا"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.contact_support_rounded),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Text("الدعم الفني"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.share),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Text("مشاركة التطبيق"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.update),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Text("تحديث البيانات"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: const Text("تسجيل الخروج"),
                onTap: () {},
              ),
            ],
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
