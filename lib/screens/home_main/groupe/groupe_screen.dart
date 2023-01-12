import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home_main/groupe/add_groupe.dart';

class GroupeScreen extends StatelessWidget {
  const GroupeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('المجموعات'),
          ),
          body: const Center(
            child: Text(
              'لم تقم بإضافة مجموعات خاصة بك بعد.',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: 24),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Constants.kMainColor,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddGroupeScreen(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
