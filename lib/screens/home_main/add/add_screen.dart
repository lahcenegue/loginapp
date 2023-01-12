import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home_main/add/add_api.dart';
import 'package:loginapp/screens/home_main/add/add_model.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late AddRequestModel addRequestModel;

  bool isApiCallProcess = false;

  @override
  void initState() {
    addRequestModel = AddRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة'),
        ),
        body: Stack(
          children: [
            Form(
              key: globalKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  customTextFormField(
                    hintText: 'الاسم',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addRequestModel.name = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'المبلغ',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.monetization_on,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addRequestModel.amount = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'رقم الهاتف',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addRequestModel.phone = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'الهدف',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.subject,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addRequestModel.comment = value.toString();
                    },
                  ),
                  customButton(
                    title: 'إضافة',
                    icon: Icons.add,
                    topPadding: 40,
                    onPressed: () async {
                      if (validateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        await apiAdd(
                          addRequestModel: addRequestModel,
                        ).then((value) async {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          print(value.msg);

                          if (value.msg == 'ok') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ));
                            //share
                            Share.share(
                              """
                            مرحبا:${addRequestModel.name}
                            يمكنك دفع المبلغ :${addRequestModel.amount}
                            عبر:${Constants.url}/pay/${value.md5id}
                                """,
                              subject: "$nameمشاركه عنوان",
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
