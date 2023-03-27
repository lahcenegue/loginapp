import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/firebase_options.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/screens/login_mobile/login_mobile_screen.dart';
import 'package:loginapp/screens/splash/splash_screen.dart';
import 'package:loginapp/widgets/check_notification.dart';
import 'constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

String? phone;
String? token;
String? name;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  phone = prefs.getString("phone");
  token = prefs.getString("token");
  name = prefs.getString("name");

  checkNotification();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _auth = FirebaseAuth.instance;

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

      //home: const SplashScreen(),
      home: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? const LoginMobileScreen()
              : MainScreen(token: token!);
        },
      ),
    );
  }
}
