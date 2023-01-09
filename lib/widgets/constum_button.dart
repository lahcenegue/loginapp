import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';

Widget customButton({
  required Function()? onPressed,
  required IconData? icon,
  required String? title,
}) {
  return Container(
    padding: const EdgeInsets.only(top: 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Constants.kMainColor,
          fixedSize: const Size(300, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 20),
          Text(
            title!,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    ),
  );
}
