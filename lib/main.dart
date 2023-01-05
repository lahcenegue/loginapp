import 'package:flutter/material.dart';
import 'constants/constants.dart';
import 'screens/login_mobile/login_mobile_screen.dart';
import 'widgets/one_signal_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
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
      home: const LoginMobileScreen(),
    );
  }
}
