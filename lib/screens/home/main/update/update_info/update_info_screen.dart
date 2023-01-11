import 'package:flutter/material.dart';
import 'package:loginapp/screens/home/add/add_model.dart';
import 'package:loginapp/screens/home/main/main_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late AddRequestModel addRequestModel;

  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تحديق البيانات'),
        ),
        body: Stack(
          children: [
            Form(
              key: globalKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  customTextFormField(
                    hintText: 'الاميل',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    hintText: 'المعلومات',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.info,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      addRequestModel.amount = value.toString();
                    },
                  ),
                  customButton(
                    title: 'تأكيد',
                    icon: Icons.add,
                    topPadding: 40,
                    onPressed: () async {},
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
