import 'package:flutter/material.dart';
import 'package:loginapp/screens/home/home_screen.dart';
import 'package:loginapp/screens/login_code/api_login_code.dart';
import 'package:loginapp/screens/register/register_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';
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

  String? yourCode;

  bool isApiCallProcess = false;

  savePhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phone);
    print("phone succes");
  }

  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print("token succes");
  }

  saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    print("name succes");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
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
                  customTextFormField(
                    onChanged: (value) {
                      yourCode = value.toString();
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
                                  builder: (context) => HomeScreen(
                                        name: value.name!,
                                        token: value.token!,
                                      )),
                            );
                            saveToken(value.token!);
                            saveName(value.name!);
                          }
                        });
                      }
                    },
                    icon: Icons.login,
                    title: 'تسجيل الدخول',
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
      ),
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
