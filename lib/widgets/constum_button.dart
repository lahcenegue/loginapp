import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';

Widget customButton({
  required Function()? onPressed,
  required IconData? icon,
  required String? title,
}) {
  return SizedBox(
    height: 50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Constants.kMainColor,
          fixedSize: const Size(300, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon),
          Text(title!),
        ],
      ),
    ),
  );
}
