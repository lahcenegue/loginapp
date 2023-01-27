import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/screens/login_mobile/login_mobile_screen.dart';
import 'package:loginapp/widgets/check_connectivity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    goToNextView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Constants.kMainColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(Constants.logo),
          ),
        ),
      ),
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        if (phone == null || token == null) {
          return const ChechConnectivity(
            child: LoginMobileScreen(),
          );
        } else {
          return ChechConnectivity(
            child: MainScreen(
              token: token!,
            ),
          );
        }
      }));
    });
  }
}
