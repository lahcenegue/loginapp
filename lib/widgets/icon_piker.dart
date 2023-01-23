import 'package:flutter/material.dart';

Icon iconPiker(String show1) {
  Color pickedColor;
  IconData iconData;
  switch (show1) {
    case "0":
      {
        pickedColor = Colors.blue;
        iconData = Icons.new_releases;
      }
      break;

    case "2":
      {
        pickedColor = Colors.red;
        iconData = Icons.sms_failed_outlined;
      }
      break;

    case "3":
      {
        pickedColor = Colors.orange;
        iconData = Icons.timelapse;
      }
      break;

    case "4":
      {
        pickedColor = Colors.green;
        iconData = Icons.check_circle_sharp;
      }
      break;

    default:
      {
        pickedColor = Colors.purple;
        iconData = Icons.question_mark_outlined;
      }
      break;
  }

  return Icon(
    iconData,
    color: pickedColor,
    size: 20,
  );
}
