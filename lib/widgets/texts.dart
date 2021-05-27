import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  String text;
  TitleText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }
}
