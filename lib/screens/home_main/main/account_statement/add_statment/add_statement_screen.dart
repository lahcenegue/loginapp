import 'package:flutter/material.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';

class AddStatementScreen extends StatelessWidget {
  const AddStatementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('السحب'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            customTextFormField(
              hintText: 'المبلغ',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.person,
              validator: (value) {
                return null;
              },
            ),
            customTextFormField(
              hintText: 'البنك',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.monetization_on,
              validator: (value) {
                return null;
              },
            ),
            customTextFormField(
              hintText: 'اسم صاحب الحساب',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.monetization_on,
              validator: (value) {
                return null;
              },
            ),
            customTextFormField(
              hintText: 'IBAN Number',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.subject,
              validator: (value) {
                return null;
              },
            ),
            customTextFormField(
              hintText: 'ملاحظات',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.subject,
              validator: (value) {
                return null;
              },
            ),
            customButton(
              title: 'سحب',
              icon: Icons.add,
              topPadding: 40,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
