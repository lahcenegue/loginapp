import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/add/add_api.dart';
import 'package:loginapp/screens/home/add/add_model.dart';
import 'package:loginapp/screens/home/home_screen.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تواصل معنا'),
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
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    hintText: 'الاميل',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                  customTextFormField(
                    hintText: 'الرسالة',
                    keyboardType: TextInputType.multiline,
                    maxLine: 10,
                    prefixIcon: Icons.subject,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                  customButton(
                    title: 'إرسال',
                    icon: Icons.send_rounded,
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
