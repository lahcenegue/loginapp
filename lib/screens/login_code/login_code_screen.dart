import 'package:flutter/material.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/screens/login_code/api_login_code.dart';
import 'package:loginapp/screens/register/register_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';

class LoginCodeScreen extends StatefulWidget {
  final String phoneNumber;

  const LoginCodeScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<LoginCodeScreen> createState() => _LoginCodeScreenState();
}

class _LoginCodeScreenState extends State<LoginCodeScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String smsCode = '';

  bool loading = false;

  bool isApiCallProcess = false;

  savePhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
  }

  saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Form(
            key: globalKey,
            child: ListView(
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              children: [
                const SizedBox(height: 120),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Constants.kMainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(Constants.logo),
                ),

                const SizedBox(height: 30),

                const Text(
                  'مرحبا',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  'ادخل الكود الخاص بك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 30),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      Pinput(
                        length: 4,
                        onChanged: (value) {
                          setState(() {
                            smsCode = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                // login button
                customButton(
                  title: 'تسجيل الدخول',
                  icon: Icons.login,
                  topPadding: 40,
                  onPressed: () {
                    if (validateAndSave()) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      apiLoginCode(widget.phoneNumber, smsCode)
                          .then((value) async {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        savePhone(widget.phoneNumber);
                        if (value.user == "new") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen(
                                      phoneNumber: widget.phoneNumber,
                                      code: smsCode,
                                    )),
                          );
                        } else if (value.user == "old") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                      token: value.token!,
                                    )),
                          );
                          saveToken(value.token!);
                          saveName(value.name!);
                        }
                      });
                    }
                  },
                ),
              ],
            ),
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
      )),
    );
  }

  bool validateAndSave() {
    final FormState? form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
