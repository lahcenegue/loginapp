import 'package:flutter/material.dart';
import 'package:loginapp/home_view_model/home_view_model.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_info/update_info_api.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_info/update_info_model.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';

class UpdateInfoScreen extends StatefulWidget {
  final String token;
  const UpdateInfoScreen({super.key, required this.token});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  HomeViewModel hvm = HomeViewModel();
  late UpdateInfoRequestModel updateInfoRequestModel;

  bool isApiCallProcess = false;

  @override
  void initState() {
    updateInfoRequestModel = UpdateInfoRequestModel();
    hvm.fetchGetInfo(token: widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hvm.addListener(() {
      setState(() {});
    });

    if (hvm.getInfo == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('تحديث البيانات'),
        ),
        body: Stack(
          children: [
            Form(
              key: globalKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  customTextFormField(
                    hintText: hvm.getInfo!.email,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      updateInfoRequestModel.email = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'المعلومات',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.info,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      updateInfoRequestModel.info = value.toString();
                    },
                  ),
                  customButton(
                    title: 'تأكيد',
                    icon: Icons.add,
                    topPadding: 40,
                    onPressed: () async {
                      if (validateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        await apiUpdateInfo(
                          token: widget.token,
                          updateInfoRequestModel: updateInfoRequestModel,
                        ).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if (value.edit == "ok") {
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
      );
    }
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
