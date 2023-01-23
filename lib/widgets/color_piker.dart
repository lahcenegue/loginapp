import 'package:flutter/material.dart';

Color colorPiker(String show1) {
  Color pickedColor;
  switch (show1) {
    case "0":
      {
        pickedColor = Colors.blue;
      }
      break;

    case "2":
      {
        pickedColor = Colors.red;
      }
      break;

    case "3":
      {
        pickedColor = Colors.orange;
      }
      break;

    case "4":
      {
        pickedColor = Colors.green;
      }
      break;

    default:
      {
        pickedColor = Colors.purple;
      }
      break;
  }

  return pickedColor;
}
