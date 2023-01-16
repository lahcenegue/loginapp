import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/add_statment/add_statement_api.dart';
import 'package:loginapp/screens/home_main/drawer/account_statement/add_statment/add_statement_model.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';

class AddStatementScreen extends StatefulWidget {
  final int balance;
  final String token;
  const AddStatementScreen({
    super.key,
    required this.balance,
    required this.token,
  });

  @override
  State<AddStatementScreen> createState() => _AddStatementScreenState();
}

class _AddStatementScreenState extends State<AddStatementScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late AddStatementRequest addStatementRequest;

  bool isApiCallProcess = false;

  @override
  void initState() {
    addStatementRequest = AddStatementRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('السحب'),
        ),
        body: Stack(
          children: [
            Form(
              key: globalKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    "رصيد الحساب",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.kMainColor,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "${widget.balance} د.ك",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  customTextFormField(
                    hintText: 'المبلغ',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.monetization_on,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addStatementRequest.amout = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'البنك',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.account_balance_rounded,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addStatementRequest.banq = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'اسم صاحب الحساب',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addStatementRequest.name = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'IBAN Number',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.numbers,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addStatementRequest.iban = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'ملاحظات',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.subject,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addStatementRequest.comment = value.toString();
                    },
                  ),
                  customButton(
                    title: 'سحب',
                    icon: Icons.add,
                    topPadding: 40,
                    onPressed: () async {
                      if (validateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        apiStatmentAdd(
                          token: widget.token,
                          addStatementRequest: addStatementRequest,
                        ).then((value) async {
                          setState(() {
                            isApiCallProcess = false;
                          });

                          if (value.add == "ok") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(
                                  token: token!,
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
