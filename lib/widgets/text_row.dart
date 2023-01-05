import 'package:flutter/material.dart';

class TextRow extends StatelessWidget {
  final String text1;
  final String text2;
  const TextRow({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * .04, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .25,
            child: Text(text1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .03),
          Text(text2,
              style: const TextStyle(
                fontSize: 14,
              )),
        ],
      ),
    );
  }
}
