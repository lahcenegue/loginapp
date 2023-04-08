import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';

Widget customContainer({
  required Function()? onTap,
  required IconData? icon,
  required String title,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
          Icon(
            icon,
            size: 42,
          ),
          FittedBox(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}
