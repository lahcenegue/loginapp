import 'package:flutter/material.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            customTextFormField(
              hintText: 'الاسم',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.person,
              validator: (String) {
                return null;
              },
            ),
            customTextFormField(
              hintText: 'المبلغ',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.monetization_on,
              validator: (String) {
                return null;
              },
            ),
            customTextFormField(
              hintText: 'رقم الهاتف',
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone,
              validator: (String) {
                return null;
              },
            ),
            customTextFormField(
              hintText: 'الهدف',
              keyboardType: TextInputType.text,
              prefixIcon: Icons.subject,
              validator: (String) {
                return null;
              },
            ),
            customButton(
              title: 'إضافة',
              icon: Icons.add,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
