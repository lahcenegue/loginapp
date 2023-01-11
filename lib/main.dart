import 'package:flutter/material.dart';
import 'package:loginapp/screens/home/home_screen.dart';
import 'constants/constants.dart';
import 'screens/login_mobile/login_mobile_screen.dart';
import 'widgets/one_signal_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? phone;
String? token;
String? name;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  phone = prefs.getString("phone");
  token = prefs.getString("token");
  name = prefs.getString("name");

  runApp(const MyApp());

  OneSignalControler.inite();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ar_DZ');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', ''),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Constants.kMainColor,
          )),
      home: phone == null || token == null
          ? const LoginMobileScreen()
          : const HomeScreen(),
    );
  }
}
