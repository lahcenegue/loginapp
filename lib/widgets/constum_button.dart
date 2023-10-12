import 'package:flutter/material.dart';
import '../constants/constants.dart';

Widget customButton({
  required Function()? onPressed,
  required IconData? icon,
  required String? title,
  required double? topPadding,
}) {
  return Container(
    padding: EdgeInsets.only(top: topPadding!),
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
