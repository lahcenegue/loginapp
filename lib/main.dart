import 'package:flutter/material.dart';
import 'package:loginapp/widgets/one_signal_controller.dart';
import 'constants/constants.dart';
import 'screens/login_mobile/login_mobile_screen.dart';

void main() {
  runApp(const MyApp());
  OneSignalControler();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
