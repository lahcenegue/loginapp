import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loginapp/firebase/function.dart';
import 'package:loginapp/screens/login_code/login_code_screen.dart';
import 'package:loginapp/screens/login_mobile/api_login_mobile.dart';
import 'package:loginapp/widgets/constum_button.dart';
import '../../constants/constants.dart';

class LoginMobileScreen extends StatefulWidget {
  const LoginMobileScreen({super.key});

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String phoneNumber = '';
  String? verification;
  bool loading = false;
  bool isApiCallProcess = false;

  void sendOtpCode({required String newPhone}) {
    loading = true;
    setState(() {});
    final auth = FirebaseAuth.instance;
    if (phoneNumber.isNotEmpty) {
      authWithPhoneNumber(
        phoneNumber,
        onCodeSend: (verificationId, v) {
          loading = false;

          verification = verificationId;
          setState(() {});

          apiLoginMobile(newPhone).then(
            (value) {
              setState(() {
                isApiCallProcess = false;
              });
              if (value.msg == 'ok') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginCodeScreen(
                      phoneNumber: newPhone,
                      verificationId: verification!,
                    ),
                  ),
                );
              }
            },
          );
        },
        onAutoVerify: (v) async {
          // await auth
          //     .signInWithCredential(v)
          //     .then((value) => Navigator.of(context).pop());
        },
        onFailed: (e) {
          loading = false;
          setState(() {});
        },
        autoRetrieval: (v) {},
      );
    }
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
              padding: const EdgeInsets.only(left: 50, right: 50),
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
                  'الدخول الى حسابك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 30),

                //
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: IntlPhoneField(
                    countries: const ['KW'],
                    textAlign: TextAlign.left,
                    invalidNumberMessage: 'قمت بإدخال رقم خاطئ',
                    onChanged: (value) {
                      phoneNumber = value.completeNumber;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                // login button
                customButton(
                  title: 'تسجيل الدخول',
                  icon: Icons.login,
                  topPadding: 40,
                  onPressed: () {
                    String newphone = phoneNumber.replaceAll('+965', '');
                    if (validateAndSave()) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      loading ? null : sendOtpCode(newPhone: newphone);
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
