import 'package:flutter/material.dart';
import 'package:loginapp/models/models.dart';
import 'package:loginapp/screens/home_screen.dart';
import 'package:loginapp/services/api_services.dart';
import 'package:loginapp/widgets/email_validator.dart';
import 'package:loginapp/widgets/text_form.dart';
import '../constants/constants.dart';

class RegisterScreen extends StatefulWidget {
  final String phoneNumber;
  final String code;
  const RegisterScreen({
    super.key,
    required this.phoneNumber,
    required this.code,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  ApiServices apiServices = ApiServices();

  bool hidePassword1 = true;
  bool hidePassword2 = true;
  bool isApiCallProcess = false;

//api info
  String? name;
  String? civilNumber;
  String? email;
  String? password;

  String? passVerif;

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
                      'عمل حساب جديد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // name
                    customTextFormField(
                      onChanged: (value) {
                        name = value.toString();
                        //print(name);
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أدخل الاسم';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.person,
                      hintText: 'الاسم',
                    ),
                    const SizedBox(height: 10),

                    //civilNumber
                    customTextFormField(
                      onChanged: (value) {
                        civilNumber = value.toString();
                        //print(civilNumber);
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أدخل الرقم المدني';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.info_rounded,
                      hintText: 'الرقم المدني',
                    ),
                    const SizedBox(height: 10),

                    //email
                    customTextFormField(
                      onChanged: (value) {
                        email = value.toString();
                        // print(email);
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أرجو التحقق من عنوان البريد الالكتروني';
                        }
                        if (value!.isNotEmpty &&
                            !value.toString().isValidEmail()) {
                          return 'أرجو التحقق من عنوان البريد الالكتروني';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.mail,
                      hintText: 'الايميل',
                    ),

                    const SizedBox(height: 10),

                    //password
                    customTextFormField(
                      onChanged: (value) {
                        password = value.toString();
                        //print(password);
                        passVerif = value.toString();
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أرجوا ادخال كلمة المرور';
                        } else if (value.toString().length < 8) {
                          return 'كلمة المرور تحتوي على اقل من 8 احرف';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePassword1,
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword1 = !hidePassword1;
                            });
                          },
                          icon: Icon(
                            hidePassword1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      hintText: 'كلمة المرور',
                    ),

                    const SizedBox(height: 10),

                    //password 2
                    customTextFormField(
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'أرجوا ادخال كلمة المرور';
                        }
                        if (value.toString().isNotEmpty &&
                            value.toString() != passVerif) {
                          return 'أرجوا ادخال نفس كلمة المرور';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePassword2,
                      prefixIcon: Icons.lock,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword2 = !hidePassword2;
                            });
                          },
                          icon: Icon(
                            hidePassword2
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      hintText: 'تأكيد كلمة المرور',
                    ),

                    const SizedBox(height: 20),
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
                            apiServices
                                .register(
                              phone: widget.phoneNumber,
                              yourCode: widget.code,
                              civilNumber: civilNumber!,
                              email: email!,
                              name: name!,
                              password: password!,
                            )
                                .then((value) {
                              setState(() {
                                isApiCallProcess = false;
                              });

                              if (value.msg == "ok") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      name: value.name!,
                                    ),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(Icons.login),
                            Text('تسجيل حساب جديد'),
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
          ),
        ),
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
