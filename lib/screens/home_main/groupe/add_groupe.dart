import 'package:flutter/material.dart';
import 'package:loginapp/screens/home_main/groupe/add_group_api.dart';
import 'package:loginapp/screens/home_main/groupe/groupe_model.dart';
import 'package:loginapp/widgets/constum_button.dart';
import 'package:loginapp/widgets/text_form.dart';

class AddGroupeScreen extends StatefulWidget {
  final String token;
  const AddGroupeScreen({
    super.key,
    required this.token,
  });

  @override
  State<AddGroupeScreen> createState() => _AddGroupeScreenState();
}

class _AddGroupeScreenState extends State<AddGroupeScreen> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late GroupRequestModel groupRequestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    groupRequestModel = GroupRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة مجموعة'),
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
                      groupRequestModel.name = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'المبلغ الكلي',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.monetization_on,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      groupRequestModel.amountall = value.toString();
                    },
                  ),
                  customTextFormField(
                    hintText: 'أقل مبلغ',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.monetization_on,
                    validator: (value) {
                      return null;
                    },
                    onChanged: (value) {
                      groupRequestModel.amount = value.toString();
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
                      groupRequestModel.comment = value.toString();
                    },
                  ),
                  customButton(
                    title: 'إضافة مجموعة',
                    icon: Icons.add,
                    topPadding: 40,
                    onPressed: () async {
                      if (validateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        await apiAddGroup(
                          token: widget.token,
                          groupRequestModel: groupRequestModel,
                        ).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });
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
