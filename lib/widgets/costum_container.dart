import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';

Widget customContainer() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Constants.boxColor,
        boxShadow: [
          BoxShadow(
            color: Constants.boxShadow,
            offset: const Offset(4, 4),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.add),
          Text('data'),
        ],
      ),
    ),
  );
}
