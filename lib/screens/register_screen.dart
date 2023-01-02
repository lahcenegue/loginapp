import 'package:flutter/material.dart';
import 'package:loginapp/widgets/text_form.dart';
import '../constants/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedItem;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword1 = true;
  bool hidePassword2 = true;

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
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        onChanged: (value) {},
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

                      //number
                      customTextFormField(
                        onChanged: (value) {},
                        validator: (value) {},
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.info_rounded,
                        hintText: 'الرقم المدني',
                      ),
                      const SizedBox(height: 10),
                      //number
                      customTextFormField(
                        onChanged: (value) {},
                        validator: (value) {},
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.mail,
                        hintText: 'الايميل',
                      ),

                      const SizedBox(height: 10),

                      //password
                      customTextFormField(
                        onChanged: (value) {},
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
                        validator: (value) {},
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
                              backgroundColor: Constants.buttonColor,
                              fixedSize: const Size(300, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {},
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
              ),
              // Visibility(
              //   visible: isApiCallProcess ? true : false,
              //   child: Stack(
              //     children: [
              //       ModalBarrier(
              //         color: Colors.white.withOpacity(0.6),
              //         dismissible: true,
              //       ),
              //       const Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     ],
              //   ),
              // ),
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
