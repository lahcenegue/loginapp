import 'package:flutter/material.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/screens/home_main/main/main_screen.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_password/update_pass_api.dart';
import 'package:loginapp/screens/home_main/drawer/update/update_password/update_pass_model.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';

class UpdatePassScreen extends StatefulWidget {
  final String token;
  const UpdatePassScreen({super.key, required this.token});

  @override
  State<UpdatePassScreen> createState() => _UpdatePassScreenState();
}

class _UpdatePassScreenState extends State<UpdatePassScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late UpdatePassRequestModel updatePassRequestModel;

  bool isApiCallProcess = false;

  @override
  void initState() {
    updatePassRequestModel = UpdatePassRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديق كلمة المرور'),
      ),
      body: Stack(
        children: [
          Form(
            key: globalKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                customTextFormField(
                  hintText: 'كلمة المرور',
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icons.person,
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {
                    updatePassRequestModel.pass = value.toString();
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

                      await apiUpdatePass(
                        token: widget.token,
                        updatePassRequestModel: updatePassRequestModel,
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
                              ));
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

  bool validateAndSave() {
    final FormState? form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
