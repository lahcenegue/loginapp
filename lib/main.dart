import 'package:flutter/material.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/screens/login_mobile/login_mobile_screen.dart';
import 'package:loginapp/widgets/check_notification.dart';
import 'constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String? phone;
String? token;
String? name;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  phone = prefs.getString("phone");
  token = prefs.getString("token");
  name = prefs.getString("name");

  checkNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", 'DZ'),
      ],
      locale: const Locale('ar', 'DZ'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Constants.kMainColor,
        ),
      ),

      home: phone == null || token == null
          ? const LoginMobileScreen()
          : MainScreen(
              token: token!,
            ),
      //home: const SplashScreen(),
    );
  }
}
