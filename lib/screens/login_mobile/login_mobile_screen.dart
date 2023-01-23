import 'package:flutter/material.dart';
import 'package:loginapp/screens/login_code/login_code_screen.dart';
import 'package:loginapp/screens/login_mobile/api_login_mobile.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';
import '../../constants/constants.dart';

class LoginMobileScreen extends StatefulWidget {
  const LoginMobileScreen({super.key});

  @override
  State<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String? phoneNumber;
  bool isApiCallProcess = false;

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
                customTextFormField(
                  onChanged: (value) {
                    phoneNumber = value.toString();
                  },
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'ادخل رقم الهاتف';
                    } else if (value.toString().length != 8) {
                      return 'يجب ان يكون طول الرقم 8 ارقام';
                    }
                    return null;
                  },
                  hintText: 'رقم الهاتف',
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
                      apiLoginMobile(phoneNumber!).then((value) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.msg == "ok") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginCodeScreen(
                                phoneNumber: phoneNumber!,
                              ),
                            ),
                          );
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
