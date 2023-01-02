import 'package:flutter/material.dart';
import 'package:loginapp/screens/login_code.dart';
import 'package:loginapp/services/api_services.dart';
import 'package:loginapp/widgets/text_form.dart';
import '../constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ApiServices apiServices = ApiServices();

  String? phoneNumber;
  bool isApiCallProcess = false;

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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Constants.kMainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(Constants.logo),
                  ),
                  const Text(
                    'مرحبا',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'الدخول الى حسابك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),

                  // login button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.kMainColor,
                          fixedSize: const Size(300, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        if (validateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          apiServices.loginMobile(phoneNumber!).then((value) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            if (value.msg == "ok") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginCodeScreen(
                                          phoneNumber: phoneNumber!,
                                        )),
                              );
                            }
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(Icons.login),
                          Text('تسجيل الدخول'),
                        ],
                      ),
                    ),
                  )
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
