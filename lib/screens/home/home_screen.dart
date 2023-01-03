import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Constants.kMainColor,
              child: Column(
                children: [
                  const Text('أهلا'),
                  Text(name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
