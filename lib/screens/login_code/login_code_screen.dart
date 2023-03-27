import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/firebase/function.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/screens/login_code/api_login_code.dart';
import 'package:loginapp/screens/register/register_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';

class LoginCodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const LoginCodeScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<LoginCodeScreen> createState() => _LoginCodeScreenState();
}

class _LoginCodeScreenState extends State<LoginCodeScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String yourCode = '6677';
  String smsCode = '';

  bool loading = false;
  bool resend = false;
  int count = 20;

  bool isApiCallProcess = false;

  final _auth = FirebaseAuth.instance;

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

  //OTP
  late Timer timer;

  void decompte() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (count < 1) {
        timer.cancel();
        count = 20;
        resend = true;
        setState(() {});
        return;
      }
      count--;
      setState(() {});
    });
  }

  void onResendSmsCode() {
    resend = false;
    setState(() {});
    authWithPhoneNumber(
      widget.phoneNumber,
      onCodeSend: (verificationId, v) {
        loading = false;

        decompte();
        setState(() {});
      },
      onAutoVerify: (v) async {
        await _auth.signInWithCredential(v);
      },
      onFailed: (e) {
        loading = false;
        setState(() {});
        print("Le code est erroné");
      },
      autoRetrieval: (v) {},
    );
  }

  void onVerifySmsCode() async {
    loading = true;
    setState(() {});
    await validateOtp(smsCode, widget.verificationId);
    loading = true;
    setState(() {});
    Navigator.of(context).pop();
    print('=============================');
    print(FirebaseAuth.instance.currentUser!.uid);

    print("Vérification éfectué avec succès");
  }

  @override
  void initState() {
    super.initState();
    decompte();
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
                  child: Pinput(
                    length: 6,
                    onChanged: (value) {
                      smsCode = value;
                      setState(() {});
                    },
                  ),
                ),
                customTextFormField(
                  onChanged: (value) {
                    smsCode = value.toString();
                  },
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'ادخل الكود الخاص بك';
                    } else if (value.toString().length != 4) {
                      return 'يجب ان يكون طول الرقم 4 ارقام';
                    }
                    return null;
                  },
                  hintText: 'الكود',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
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
                      apiLoginCode(widget.phoneNumber, yourCode)
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
                                      code: yourCode!,
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
