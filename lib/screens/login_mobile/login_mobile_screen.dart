import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
  GlobalKey<FormState> globalKey = GlobalKey();

  String phoneNumber = '';
  String? verification;
  bool loading = false;
  bool isNotEmpty = false;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          ListView(
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
                  key: globalKey,
                  countries: const <Country>[
                    Country(
                      name: "Kuwait",
                      nameTranslations: {
                        "sk": "Kuvajt",
                        "se": "Kuwait",
                        "pl": "Kuwejt",
                        "no": "Kuwait",
                        "ja": "クウェート",
                        "it": "Kuwait",
                        "zh": "科威特",
                        "nl": "Koeweit",
                        "de": "Kuwait",
                        "fr": "Koweït",
                        "es": "Kuwait",
                        "en": "Kuwait",
                        "pt_BR": "Kuwait",
                        "sr-Cyrl": "Кувајт",
                        "sr-Latn": "Kuvajt",
                        "zh_TW": "科威特",
                        "tr": "Kuveyt",
                        "ro": "Kuweit",
                        "ar": "الكويت",
                        "fa": "کویت",
                        "yue": "科威特"
                      },
                      flag: "🇰🇼",
                      code: "KW",
                      dialCode: "965",
                      minLength: 8,
                      maxLength: 8,
                    ),
                  ],
                  textAlign: TextAlign.left,
                  invalidNumberMessage: 'قمت بإدخال رقم خاطئ',
                  onChanged: (value) {
                    phoneNumber = value.completeNumber;
                  },
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'أرجوا ادخال كلمة المرور';
                    } else {
                      setState(() {
                        isNotEmpty = true;
                      });
                    }
                    return null;
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

                  if (isNotEmpty) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    apiLoginMobile(newphone).then(
                      (value) {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.msg == 'ok') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginCodeScreen(
                                phoneNumber: newphone,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ],
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
}
